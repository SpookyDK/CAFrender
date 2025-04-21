// scene
// Header file for the scene class
#include <camera.h>
#include <cstddef>
#include <models.h>

#pragma once

class Scene{
public:
    Scene();
    ~Scene();

    int importModel(std::string path);
    int addObject();
    int removeObject();
    int editObject(int idx);

    int* getObjects();
    int* getObjectInfo(int idx);
    int renderScene(int camera_idx);

private:
    int* Objects[10];
    std::string object_names[sizeof(Objects) / sizeof(Objects[0]];

};
