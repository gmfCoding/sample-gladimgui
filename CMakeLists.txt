cmake_minimum_required(VERSION 3.12)
project(app)
set(SOURCES "")
set(IMGUISRC "")
message(STATUS "[1]CBD:${CMAKE_BINARY_DIR}\nCSD:${CMAKE_SOURCE_DIR}\nCCBD:${CMAKE_CURRENT_BINARY_DIR}\nCCSD:${CMAKE_CURRENT_SOURCE_DIR}")

find_package(OpenGL REQUIRED)
include_directories( ${OPENGL_INCLUDE_DIRS} )

set(GLFW_BUILD_DOCS OFF CACHE BOOL "" FORCE)
set(GLFW_BUILD_TESTS OFF CACHE BOOL "" FORCE)
set(GLFW_BUILD_EXAMPLES OFF CACHE BOOL "" FORCE)
set(GLFW_HEADERS ${CMAKE_SOURCE_DIR}/app/vendor/glfw)

add_subdirectory(app/vendor/glfw-3.3.7)


add_subdirectory(app/vendor/imgui)
add_subdirectory(app/vendor/glad)

# Populates SOURCES with the src files defined in app/src/CMakeLists.txt 
add_subdirectory(app/src)

add_executable(${CMAKE_PROJECT_NAME} ${SOURCES})

target_include_directories(${CMAKE_PROJECT_NAME}
    PRIVATE 
        ${PROJECT_SOURCE_DIR}/app/srcinc
    PUBLIC
        ${PROJECT_SOURCE_DIR}/app/vendor/
        ${PROJECT_SOURCE_DIR}/app/vendor/imgui
        ${PROJECT_SOURCE_DIR}/app/vendor/imgui/backends
        ${GLFW_HEADERS}
)

# target_link_directories(${CMAKE_PROJECT_NAME} PUBLIC app/vendor/lib)

# link the new hello_library target with the hello_binary target
target_link_libraries(${CMAKE_PROJECT_NAME}
    PRIVATE 
        glad
        imgui
        glfw
)





message(STATUS "[2]CBD:${CMAKE_BINARY_DIR}\nCSD:${CMAKE_SOURCE_DIR}\nCCBD:${CMAKE_CURRENT_BINARY_DIR}\nCCSD:${CMAKE_CURRENT_SOURCE_DIR}")