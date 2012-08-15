//
//  RBAnimatedFlask.h
//  AnimatedFlask
//
//  Created by Robert Brown on 7/24/12.
//  Copyright (c) 2012 Robert Brown. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RBAnimatedFlask : UIView

@property (nonatomic, assign, getter=isAnimating, readonly) BOOL animating;

- (void)startAnimating;

- (void)stopAnimating;

- (void)toggleAnimating;

@end
