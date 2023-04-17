cmake_minimum_required(VERSION 3.22)

project(velvet)

# Cmake standard
set(CMAKE_CXX_STANDARD 20)

# Somehow set the cache path...
# Building with compile_commands flag is fine but only without emcmake!

if(${CMAKE_SYSTEM_NAME} MATCHES "Emscripten")
    set(USE_FLAGS "-s USE_SDL=2")
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${USE_FLAGS}")
    set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} ${USE_FLAGS}")
    set(CMAKE_EXECUTABLE_SUFFIX .html)
else()
    find_package(SDL2 REQUIRED)
endif()

# Include sources for SDL2
include_directories(${SDL2_INCLUDE_DIRS})

add_executable(draw main.cpp)
target_link_libraries(draw ${SDL2_LIBRARIES})

