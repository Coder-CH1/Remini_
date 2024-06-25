//
//  OpenCVWrapper.h
//  Remini_
//
//  Created by Mac on 25/06/2024.
//

#ifndef OpenCVWrapper_h
#define OpenCVWrapper_h

#import <opencv2/opencv.hpp>
#import <UIKit/UIKit.h>

@interface OpenCVWrapper : NSObject

+ (UIImage *)processImage:(UIImage *)inputImage;

@end

#endif /* OpenCVWrapper_h */

