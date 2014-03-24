//
//  UIColor+Extras.h
//  RACDemo
//
//  Created by Robert Brown on 3/17/14.
//  Copyright (c) 2014 Robert Brown. All rights reserved.
//

#import <UIKit/UIKit.h>


#define RGBA(r, g, b, a) [UIColor colorWithRed:((r) / 255.0f) green:((g) / 255.0f) blue:((b) / 255.0f) alpha:(a)]

#define RGB(r, g, b) RGBA(r, g, b, 1.0f)


@interface UIColor (Extras)

+ (UIColor *)inputValidColor;

+ (UIColor *)inputInvalidColor;

@end
