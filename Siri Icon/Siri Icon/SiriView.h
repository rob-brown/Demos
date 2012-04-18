//
//  SiriView.h
//  Siri Icon
//
//  Created by Robert Brown on 4/18/12.
//  Copyright (c) 2012 Robert Brown. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SiriView : UIView

/// Translation in pixels in x.
@property (nonatomic, assign) CGFloat translationX;

/// Translation in pixels in y.
@property (nonatomic, assign) CGFloat translationY;

/// Rotation in degrees.
@property (nonatomic, assign) CGFloat rotation;

/// Scale in x.
@property (nonatomic, assign) CGFloat scaleX;

/// Scale in y.
@property (nonatomic, assign) CGFloat scaleY;

/// Sets the scale of X and Y to the given scale.
- (void)setAspectScale:(CGFloat)scale;

/// Sets all of the default tranformation values to their defaults.
- (void)setupWithDefaultTranforms;

@end
