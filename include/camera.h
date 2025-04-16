// camera.h
// Header file for the Camera class

#pragma once

class Camera {
public:
    Camera(int width, int height);
    ~Camera();

    int setPosition(float x, float y, float z);
    int setRotation(float x, float y, float z); // Applied XYZ    
    int setFOV(float value, int type);    // type=1 for FOV else mm
    int setPlaneDistance(float value);
    int setResolution(int width, int height);

    int* getResolution();
    float getFOV();
    float* getPosition();
    float* getRotation();
    float getPlaneDistance();

private:
    int resolution[2];
    float position[3];
    float rotation[3];
    float fov;
    float nearPlaneDistance;

};
