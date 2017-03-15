set (GTEST_VERSION      1.8.0)

ExternalProject_Add(google-test
    DOWNLOAD_NAME       google-test-${GTEST_VERSION}.tar.gz
    URL                 https://github.com/google/googletest/archive/release-${GTEST_VERSION}.tar.gz
    URL_MD5             16877098823401d1bf2ed7891d7dce36
    CMAKE_ARGS          -DCMAKE_INSTALL_PREFIX=<INSTALL_DIR>
)

ExternalProject_Get_Property(google-test INSTALL_DIR)

set (GTEST_ROOT                 ${INSTALL_DIR})
set (GTEST_INCLUDE_DIRS         ${GTEST_ROOT}/include)
set (GTEST_LIBRARY_DIRS         ${GTEST_ROOT}/lib)

set (GTEST_LIBRARIES            gtest)
set (GTEST_MAIN_LIBRARIES       gtest-main)
set (GTEST_BOTH_LIBRARIES       ${GTEST_LIBRARIES} ${GTEST_MAIN_LIBRARIES})
set (GMOCK_LIBRARIES            gmock)
set (GMOCK_MAIN_LIBRARIES       gmock-main)
set (GMOCK_BOTH_LIBRARIES       ${GMOCK_LIBRARIES} ${GMOCK_MAIN_LIBRARIES})

set (GTEST_LIBRARY_PATH         ${GTEST_LIBRARY_DIRS}/libgtest.a)
set (GTEST_MAIN_LIBRARY_PATH    ${GTEST_LIBRARY_DIRS}/libgtest-main.a)
set (GMOCK_LIBRARY_PATH         ${GTEST_LIBRARY_DIRS}/libgmock.a)
set (GMOCK_MAIN_LIBRARY_PATH    ${GTEST_LIBRARY_DIRS}/libgmock-main.a)

set (GTEST_SHARED_LIBRIRES GTEST_LIBRARIES GTEST_MAIN_LIBRARIES GMOCK_LIBRARIES GMOCK_MAIN_LIBRARIES)
SET (GTEST_STATIC_LIBRIRES GTEST_LIBRARY_PATH GTEST_MAIN_LIBRARY_PATH GMOCK_LIBRARY_PATH GMOCK_MAIN_LIBRARY_PATH)

find_package_handle_standard_args(google-test
    REQUIRED_ARGS   GTEST_SHARED_LIBRIRES GTEST_STATIC_LIBRIRES GTEST_INCLUDE_DIRS
)

foreach (lib GTEST_SHARED_LIBRIRES)
    add_library(${lib} SHARED IMPORTED)
    add_dependencies(${lib} google-test)
endforeach ()

foreach (lib GTEST_STATIC_LIBRIRES)
    add_library(${lib} STATIC IMPORTED)
    add_dependencies(${lib} google-test)
endforeach ()

mark_as_advanced(GTEST_LIBRARIES GTEST_MAIN_LIBRARIES GMOCK_LIBRARIES GMOCK_MAIN_LIBRARIES GTEST_INCLUDE_DIRS)