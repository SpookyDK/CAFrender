// camera.cpp
#include "camera.h"
#include <cmath>
#include <iostream> // if you're using std::cout etc.

Camera::Camera(int width, int height) {
    resolution[0] = width;
    resolution[1] = height;
    position[0] = 0;
    position[1] = 0;
    position[2] = 0;
    rotation[0] = 0;
    rotation[1] = 0;
    rotation[2] = 0;
    fov = 50;
    nearPlaneDistance = 0.5;
    // Constructor logic (optional)
}

Camera::~Camera() {
    // Destructor logic (optional)
}

int Camera::setPosition(float x, float y, float z) {
    position[0] = x;
    position[1] = y;
    position[2] = z;
    return 0;
}

int Camera::setRotation(float x, float y, float z) {
    rotation[0] = x;
    rotation[1] = y;
    rotation[2] = z;
    return 0;
}

int Camera::setFOV(float value, int type) {
    if (type == 1){
        fov = value;
    }
    else{
        float fovRadians = 2 * atan(36 / (2 * value));
        fov = fovRadians * (180.0f / M_PI);  // Convert radians to degrees
    }
    return 0;
}

int Camera::setPlaneDistance(float value) {
    nearPlaneDistance = value;
    // Your logic here
    return 0;
}

int Camera::setResolution(int height, int width){
    resolution[0] = width;
    resolution[1] = height;
    return 0;
}
int* Camera::getResolution(){
    return resolution;
}
float Camera::getFOV(){
    return fov;
}
float Camera::getPlaneDistance(){
    return nearPlaneDistance;
}
float* Camera::getPosition(){
    return position;
} 
float* Camera::getRotation(){
    return rotation;
} 
