//
//  OpenCVWrapper.m
//  Remini_
//
//  Created by Mac on 25/06/2024.
//

// OpenCVWrapper.m

#import <opencv2/opencv.hpp>
//#import <opencv2/imgcodecs/ios.h>
#import "OpenCVWrapper.h"

@implementation OpenCVWrapper

+ (UIImage *)processImage:(UIImage *)inputImage {
cv::Mat cvImage = [self cvMatFromUIImage:inputImage];
cv::cvtColor(cvImage, cvImage, cv::COLOR_BGR2GRAY); // Convert to grayscale
UIImage *outputImage = [self UIImageFromCVMat:cvImage];
return outputImage;
}

+ (cv::Mat)cvMatFromUIImage:(UIImage *)image {
CGColorSpaceRef colorSpace = CGImageGetColorSpace(image.CGImage);
CGFloat cols = image.size.width;
CGFloat rows = image.size.height;
cv::Mat cvImage(rows, cols, CV_8UC4); // 8-bit, 4-channel (RGBA)
CGContextRef contextRef = CGBitmapContextCreate(cvImage.data, cols, rows, 8, cvImage.step[0], colorSpace, kCGImageAlphaNoneSkipLast | kCGBitmapByteOrderDefault);
CGContextDrawImage(contextRef, CGRectMake(0, 0, cols, rows), image.CGImage);
CGContextRelease(contextRef);
return cvImage;
}

+ (UIImage *)UIImageFromCVMat:(cv::Mat)cvMat {
NSData *data = [NSData dataWithBytes:cvMat.data length:cvMat.elemSize() * cvMat.total()];
CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
CGDataProviderRef provider = CGDataProviderCreateWithCFData((__bridge CFDataRef)data);
CGImageRef imageRef = CGImageCreate(cvMat.cols, cvMat.rows, 8, 8 * 4, cvMat.step[0], colorSpace, kCGImageAlphaNoneSkipLast | kCGBitmapByteOrderDefault, provider, NULL, false, kCGRenderingIntentDefault);
UIImage *outputImage = [UIImage imageWithCGImage:imageRef];
CGImageRelease(imageRef);
CGDataProviderRelease(provider);
CGColorSpaceRelease(colorSpace);
return outputImage;
}

@end
