// models.h
// Header file for the models class
#pragma once

class Model{
public:
    Model(int* model);
    ~Model();
    int setPosition(float x, float y, float z);
    int setScale(float x, float y, float z);
    int setRotation(float x, float y, float z);
    int* getPosition();
    int* getScale();
    int* getRotation();
    int* getModel();


private:
    float rotation[3];
    float position[3];
    float scalar[3];
    int* ptrmodel;

};
