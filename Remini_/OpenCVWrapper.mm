//
//  OpenCVWrapper.m
//  Remini_
//
//  Created by Mac on 25/06/2024.
//

#import "OpenCVWrapper.h"
#import <UIKit/UIKit.h>
#import <CoreML/CoreML.h>
#import <CoreImage/CoreImage.h>
#import <CoreGraphics/CoreGraphics.h>
#import <CoreFoundation/CoreFoundation.h>
#import <opencv2/opencv.hpp>

@implementation OpenCVWrapper

+ (UIImage *)processImage:(UIImage *)inputImage {
    cv::Mat cvImage;
    cvImage = [self cvMatFromUIImage:inputImage];
    cv::cvtColor(cvImage, cvImage, cv::COLOR_COLORCVT_MAX);
    UIImage *outputImage = [self UIImageFromCVMat:cvImage];
    return outputImage;
}

+ (cv::Mat)cvMatFromUIImage:(UIImage *)image {
    return  cv::Mat();
}

+ (UIImage *)UIImageFromCVMat:(cv::Mat)cvMat {
    return  [UIImage new];
}

@end
