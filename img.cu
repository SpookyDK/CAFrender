#include <iostream>
#include <opencv2/opencv.hpp>

__global__ void adjustBrightness(unsigned char* image, int width, int height, int channels, int brightness) {
    int x = blockIdx.x * blockDim.x + threadIdx.x;
    int y = blockIdx.y * blockDim.y + threadIdx.y;

    if (x < width && y < height) {
        int idx = (y * width + x) * channels; //skips amount of lines and space into the line, then multiply by channels
        for (int c = 0; c < channels; ++c) {
            int val = image[idx + c] + brightness;
            image[idx + c] = min(255, max(0, val));
        }
    }
}
__global__ void avgImages(unsigned char* imageA, unsigned char* imageB, int width, int height, int channels){
    int x = blockIdx.x * blockDim.x + threadIdx.x;
    int y = blockIdx.y * blockDim.y + threadIdx.y;


    if (x < width && y < height){
        int idx = (y * width + x) * channels;
        for (int c = 0; c < channels; ++c){
                int val = (imageA[idx +c] + imageB[idx + c]) / 2;
                imageA[idx + c] = min(255, max(0, val));
        }
    }
}
int main() {
    std::string imagePath = "inputA.png";
    cv::Mat inputImageA = cv::imread(imagePath, cv::IMREAD_COLOR);
    if (inputImageA.empty()) {
        std::cerr << "Could not open or find the image!\n";
        return -1;
    }
    imagePath = "inputB.png";
    cv::Mat inputImageB = cv::imread(imagePath, cv::IMREAD_COLOR);
    if (inputImageB.empty()) {
        std::cerr << "Could not open or find the image!\n";
        return -1;
    }

    int width = inputImageA.cols; // width of image
    int height = inputImageA.rows; // heigh of image
    int channels = inputImageA.channels(); // amount of channels RGB = 3
    size_t imgSize = width * height * channels; // the size of the image in bytes

    unsigned char* a_image;
    unsigned char* b_image;
    cudaMalloc((void**)&a_image, imgSize); //allocates the gpu memory at &d_image of size imgSize, d_image can be used to say where to copy memory
    cudaMalloc((void**)&b_image, imgSize); //allocates the gpu memory at &d_image of size imgSize, d_image can be used to say where to copy memory
    cudaMemcpy(a_image, inputImageA.ptr(), imgSize, cudaMemcpyHostToDevice);  // copies input image to d_iamge at the gpu, of size imgSize, and tells cuda its from hosytodevice
    cudaMemcpy(b_image, inputImageB.ptr(), imgSize, cudaMemcpyHostToDevice);  // copies input image to d_iamge at the gpu, of size imgSize, and tells cuda its from hosytodevice

    dim3 block(16, 16);
    dim3 grid((width + block.x - 1) / block.x, (height + block.y - 1) / block.y);

    int brightnessValue = 10;
    avgImages<<<grid, block>>>(a_image, b_image, width, height, channels);
    cudaDeviceSynchronize();

    cv::Mat outputImage(height, width, inputImageA.type());
    cudaMemcpy(outputImage.ptr(), a_image, imgSize, cudaMemcpyDeviceToHost);
    cudaFree(a_image);
    cudaFree(b_image);
    cv::imwrite("brightened.jpg", outputImage);
    std::cout << "Brightness adjusted image saved as brightened.jpg\n";

    return 0;
}
