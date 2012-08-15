//
//  RBExample.m
//  AnimatedFlask
//
//  Created by Robert Brown on 8/4/12.
//  Copyright (c) 2012 Robert Brown. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

#import "RBExample.h"

@implementation RBExample

- (void)doSomething {
    
    UIView * myView = nil;
    
    CABasicAnimation * moveAnimation = nil;
    CABasicAnimation * scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    
    scaleAnimation.duration = 1.0f;    // A float
    scaleAnimation.fromValue = @0.0f;  // An NSNumber
    scaleAnimation.toValue = @1.0f;
    
    [myView.layer addAnimation:scaleAnimation forKey:@"scale"];
    
    CABasicAnimation * shrinkAnimation = [CABasicAnimation animationWithKeyPath:@"frame"];
    
    shrinkAnimation.duration = 1.0f;    // A float
    shrinkAnimation.fromValue = [NSValue valueWithCGRect:CGRectMake(0.0f, 0.0f, 320.0f, 480.0f)];
    shrinkAnimation.toValue = [NSValue valueWithCGRect:CGRectMake(80.0f, 120.0f, 160.0f, 240.0f)];
    
    [myView.layer addAnimation:shrinkAnimation forKey:@"shrink"];
    
    CAAnimationGroup * group = [CAAnimationGroup animation];
    
    group.duration = 1.0f;
    group.animations = @[moveAnimation, scaleAnimation];
    
    [myView.layer addAnimation:group forKey:@"group"];
    
    
    myView.transform = CGAffineTransformMakeScale(0.0f, 0.0f);
    
    [UIView animateWithDuration:1.0f animations:^{
        
        CGPoint center = myView.center;
        center.y += 10.0f;
        myView.center = center;
        
        myView.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
    }];
}

@end
