cmake_minimum_required(VERSION 3.10)
project(cuda_brightness LANGUAGES CXX CUDA)

find_package(OpenCV REQUIRED)

add_executable(img img.cu)
target_link_libraries(img PRIVATE ${OpenCV_LIBS})
set_target_properties(img PROPERTIES
    CUDA_SEPARABLE_COMPILATION ON
    CXX_STANDARD 14
)
