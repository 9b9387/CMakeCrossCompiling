cmake_minimum_required(VERSION 2.8)

project(log_project)

include_directories(${CMAKE_CURRENT_SOURCE_DIR}/src/include)

add_library(log STATIC ./src/log.cpp)