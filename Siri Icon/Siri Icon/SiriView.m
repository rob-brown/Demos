//
//  SiriView.m
//  Siri Icon
//
//  Created by Robert Brown on 4/18/12.
//  Copyright (c) 2012 Robert Brown. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

#import "SiriView.h"

@implementation SiriView

@synthesize translationX = _translationX;
@synthesize translationY = _translationY;
@synthesize rotation     = _rotation;
@synthesize scaleX       = _scaleX;
@synthesize scaleY       = _scaleY;

- (id)initWithFrame:(CGRect)frame {
    
    if ((self = [super initWithFrame:frame])) {
        [self setupWithDefaultTranforms];
    }
    
    return self;
}

- (void)setAspectScale:(CGFloat)scale {
    self.scaleX = scale;
    self.scaleY = scale;
}

- (void)setupWithDefaultTranforms {
    self.translationX = 0.0f;
    self.translationY = 0.0f;
    self.rotation = 0.0f;
    self.scaleX = 1.0f;
    self.scaleY = 1.0f;
}

- (void)drawRect:(CGRect)rect {
    
    //// General Declarations
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //// Rotates the view about the center.
    CGRect frame = self.frame;
    CGContextTranslateCTM(context, frame.size.width / 2.0f, frame.size.height / 2.0f);
    CGContextRotateCTM(context, self.rotation / 180.0f * M_PI);
    CGContextTranslateCTM(context, -frame.size.width / 2.0f, -frame.size.height / 2.0f);
    
    //// Scales the view.
    CGContextScaleCTM(context, self.scaleX, self.scaleY);
    
    //// Translates the view.
    CGContextTranslateCTM(context, self.translationX, self.translationY);
    
    //// Color Declarations
    UIColor * darkColor = [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:1];
    UIColor * transparentChrome1 = [darkColor colorWithAlphaComponent:0.3];
    UIColor * chrome = [UIColor colorWithRed:0.75 green:0.75 blue:0.75 alpha:1];
    UIColor * transparentChrome2 = [chrome colorWithAlphaComponent:0.4];
    UIColor * chromeHighlight = [UIColor colorWithRed:0.84 green:0.84 blue:0.84 alpha:1];
    UIColor * micColor = [UIColor colorWithRed:0.43 green:0 blue:0.71 alpha:1];
    CGFloat micColorRGBA[4];
    [micColor getRed:&micColorRGBA[0] green:&micColorRGBA[1] blue:&micColorRGBA[2] alpha:&micColorRGBA[3]];
    
    UIColor * lightMicColor = [UIColor colorWithRed:(micColorRGBA[0] * 0.5 + 0.5) 
                                              green:(micColorRGBA[1] * 0.5 + 0.5) 
                                               blue:(micColorRGBA[2] * 0.5 + 0.5) 
                                              alpha:(micColorRGBA[3] * 0.5 + 0.5)];
    UIColor * transparentShine = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.5];
    
    //// Gradient Declarations
    NSArray * chromeRadialGradientColors = [NSArray arrayWithObjects:
                                            (id)chrome.CGColor, 
                                            (id)chromeHighlight.CGColor, 
                                            (id)chrome.CGColor, 
                                            (id)chromeHighlight.CGColor, 
                                            (id)chrome.CGColor, 
                                            (id)chromeHighlight.CGColor, 
                                            (id)chrome.CGColor, 
                                            (id)chromeHighlight.CGColor, 
                                            (id)chrome.CGColor, 
                                            (id)chromeHighlight.CGColor, 
                                            (id)chrome.CGColor, 
                                            (id)chromeHighlight.CGColor, 
                                            (id)chrome.CGColor, 
                                            (id)chromeHighlight.CGColor, 
                                            (id)chrome.CGColor, 
                                            (id)chromeHighlight.CGColor, 
                                            (id)chrome.CGColor, 
                                            (id)chromeHighlight.CGColor, 
                                            (id)chrome.CGColor, 
                                            (id)chromeHighlight.CGColor, 
                                            (id)chrome.CGColor, 
                                            (id)chromeHighlight.CGColor, 
                                            (id)chrome.CGColor, 
                                            (id)chromeHighlight.CGColor, 
                                            (id)chrome.CGColor, 
                                            (id)chromeHighlight.CGColor, 
                                            (id)chrome.CGColor, 
                                            (id)chromeHighlight.CGColor, 
                                            (id)chrome.CGColor, 
                                            (id)chromeHighlight.CGColor, 
                                            (id)chrome.CGColor, 
                                            (id)chromeHighlight.CGColor, 
                                            (id)chrome.CGColor, 
                                            (id)chromeHighlight.CGColor, 
                                            (id)chrome.CGColor, 
                                            (id)chromeHighlight.CGColor, 
                                            (id)chrome.CGColor, 
                                            (id)chromeHighlight.CGColor, 
                                            (id)chrome.CGColor, 
                                            (id)chromeHighlight.CGColor, 
                                            (id)chrome.CGColor, 
                                            nil];
    CGFloat chromeRadialGradientLocations[41u] = {
        0.0f, 0.025f, 0.05f, 0.075f, 
        0.1f, 0.125f, 0.15f, 0.175f, 
        0.2f, 0.225f, 0.25f, 0.275f, 
        0.3f, 0.325f, 0.35f, 0.375f, 
        0.4f, 0.425f, 0.45f, 0.475f, 
        0.5f, 0.525f, 0.55f, 0.575f, 
        0.6f, 0.625f, 0.65f, 0.675f, 
        0.7f, 0.725f, 0.75f, 0.775f, 
        0.8f, 0.825f, 0.85f, 0.875f, 
        0.9f, 0.925f, 0.95f, 0.975f, 
        1.0f};
    CGGradientRef chromeRadialGradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)chromeRadialGradientColors, chromeRadialGradientLocations);
    NSArray * flareGradientColors = [NSArray arrayWithObjects:
                                    (id)transparentChrome1.CGColor, 
                                    (id)transparentChrome2.CGColor, nil];
    CGFloat flareGradientLocations[] = {0, 1};
    CGGradientRef flareGradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)flareGradientColors, flareGradientLocations);
    NSArray * shineGradientColors = [NSArray arrayWithObjects:
                                    (id)[UIColor clearColor].CGColor, 
                                    (id)[UIColor colorWithRed:0.57 green:0.57 blue:0.57 alpha:0.25].CGColor, 
                                    (id)transparentShine.CGColor, 
                                    (id)[UIColor colorWithRed:1 green:1 blue:1 alpha:0.5].CGColor, 
                                    (id)transparentShine.CGColor, nil];
    CGFloat shineGradientLocations[] = {0, 0.55, 0.55, 0.84, 1};
    CGGradientRef shineGradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)shineGradientColors, shineGradientLocations);
    
    //// Shadow Declarations
    CGColorRef shadow = [UIColor blackColor].CGColor;
    CGSize shadowOffset = CGSizeMake(0, 1);
    CGFloat shadowBlurRadius = 1;
    CGColorRef insetHighlight = lightMicColor.CGColor;
    CGSize insetHighlightOffset = CGSizeMake(1, -1);
    CGFloat insetHighlightBlurRadius = 2;
    
    
    //// Background Drawing
    UIBezierPath * backgroundPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0.5, 0.5, 100, 100)];
    [darkColor setFill];
    [backgroundPath fill];
    
    [[UIColor blackColor] setStroke];
    backgroundPath.lineWidth = 0.5;
    [backgroundPath stroke];
    
    
    //// Outer Ring Drawing
    UIBezierPath * outerRingPath = [UIBezierPath bezierPath];
    [outerRingPath moveToPoint:CGPointMake(17.27, 17.27)];
    [outerRingPath addCurveToPoint:CGPointMake(17.27, 83.73) controlPoint1:CGPointMake(-1.09, 35.62) controlPoint2:CGPointMake(-1.09, 65.38)];
    [outerRingPath addCurveToPoint:CGPointMake(83.73, 83.73) controlPoint1:CGPointMake(35.62, 102.09) controlPoint2:CGPointMake(65.38, 102.09)];
    [outerRingPath addCurveToPoint:CGPointMake(83.73, 17.27) controlPoint1:CGPointMake(102.09, 65.38) controlPoint2:CGPointMake(102.09, 35.62)];
    [outerRingPath addCurveToPoint:CGPointMake(17.27, 17.27) controlPoint1:CGPointMake(65.38, -1.09) controlPoint2:CGPointMake(35.62, -1.09)];
    [outerRingPath closePath];
    [outerRingPath moveToPoint:CGPointMake(85.86, 15.14)];
    [outerRingPath addCurveToPoint:CGPointMake(85.86, 85.86) controlPoint1:CGPointMake(105.38, 34.67) controlPoint2:CGPointMake(105.38, 66.33)];
    [outerRingPath addCurveToPoint:CGPointMake(15.14, 85.86) controlPoint1:CGPointMake(66.33, 105.38) controlPoint2:CGPointMake(34.67, 105.38)];
    [outerRingPath addCurveToPoint:CGPointMake(15.14, 15.14) controlPoint1:CGPointMake(-4.38, 66.33) controlPoint2:CGPointMake(-4.38, 34.67)];
    [outerRingPath addCurveToPoint:CGPointMake(85.86, 15.14) controlPoint1:CGPointMake(34.67, -4.38) controlPoint2:CGPointMake(66.33, -4.38)];
    [outerRingPath closePath];
    [chrome setFill];
    [outerRingPath fill];
    
    [[UIColor blackColor] setStroke];
    outerRingPath.lineWidth = 1;
    [outerRingPath stroke];
    
    
    //// Inner ring Drawing
    UIBezierPath * innerRingPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(6.5, 6.5, 88, 88)];
    CGContextSaveGState(context);
    [innerRingPath addClip];
    CGContextDrawRadialGradient(context, chromeRadialGradient,
                                CGPointMake(50.5, 50.5), 0,
                                CGPointMake(50.5, 50.5), 43.28,
                                kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
    CGContextRestoreGState(context);
    
    CGContextSaveGState(context);
    CGContextSetShadowWithColor(context, shadowOffset, shadowBlurRadius, shadow);
    [[UIColor blackColor] setStroke];
    innerRingPath.lineWidth = 1;
    [innerRingPath stroke];
    CGContextRestoreGState(context);
    
    
    //// Flare 1 Drawing
    UIBezierPath * flare1Path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(6.5, 6.5, 88, 88)];
    CGContextSaveGState(context);
    [flare1Path addClip];
    CGContextDrawRadialGradient(context, flareGradient,
                                CGPointMake(138.56, 131.73), 72.72,
                                CGPointMake(57.14, 57.49), 6.81,
                                kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
    CGContextRestoreGState(context);
    
    
    
    //// Flare 2 Drawing
    UIBezierPath * flare2Path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(7, 7, 88, 87)];
    CGContextSaveGState(context);
    [flare2Path addClip];
    CGContextDrawRadialGradient(context, flareGradient,
                                CGPointMake(-58.95, -40.23), 72.72,
                                CGPointMake(39.5, 42.47), 6.81,
                                kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
    CGContextRestoreGState(context);
    
    
    
    //// Mic Top Drawing
    UIBezierPath * micTopPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(40.5, 16.5, 20, 40) cornerRadius:10];
    [darkColor setFill];
    [micTopPath fill];
    
    [darkColor setStroke];
    micTopPath.lineWidth = 1;
    [micTopPath stroke];
    
    
    //// Mic Base Drawing
    UIBezierPath * micBasePath = [UIBezierPath bezierPath];
    [micBasePath moveToPoint:CGPointMake(66.5, 52.5)];
    [micBasePath addCurveToPoint:CGPointMake(54.5, 64.5) controlPoint1:CGPointMake(66.5, 59.13) controlPoint2:CGPointMake(61.13, 64.5)];
    [micBasePath addLineToPoint:CGPointMake(46.5, 64.5)];
    [micBasePath addCurveToPoint:CGPointMake(34.5, 52.5) controlPoint1:CGPointMake(39.87, 64.5) controlPoint2:CGPointMake(34.5, 59.13)];
    [micBasePath addLineToPoint:CGPointMake(34.5, 36.5)];
    [micBasePath addLineToPoint:CGPointMake(37.5, 36.5)];
    [micBasePath addLineToPoint:CGPointMake(37.5, 51.5)];
    [micBasePath addCurveToPoint:CGPointMake(47.5, 61.5) controlPoint1:CGPointMake(37.5, 57.02) controlPoint2:CGPointMake(41.98, 61.5)];
    [micBasePath addLineToPoint:CGPointMake(53.5, 61.5)];
    [micBasePath addCurveToPoint:CGPointMake(63.5, 51.5) controlPoint1:CGPointMake(59.02, 61.5) controlPoint2:CGPointMake(63.5, 57.02)];
    [micBasePath addLineToPoint:CGPointMake(63.5, 36.5)];
    [micBasePath addLineToPoint:CGPointMake(66.5, 36.5)];
    [micBasePath addLineToPoint:CGPointMake(66.5, 52.5)];
    [micBasePath closePath];
    [micBasePath moveToPoint:CGPointMake(48.5, 75.5)];
    [micBasePath addLineToPoint:CGPointMake(52.5, 75.5)];
    [micBasePath addLineToPoint:CGPointMake(52.5, 64.5)];
    [micBasePath addLineToPoint:CGPointMake(48.5, 64.5)];
    [micBasePath addLineToPoint:CGPointMake(48.5, 75.5)];
    [micBasePath closePath];
    [micBasePath moveToPoint:CGPointMake(40.5, 78.5)];
    [micBasePath addLineToPoint:CGPointMake(60.5, 78.5)];
    [micBasePath addLineToPoint:CGPointMake(60.5, 75.5)];
    [micBasePath addLineToPoint:CGPointMake(40.5, 75.5)];
    [micBasePath addLineToPoint:CGPointMake(40.5, 78.5)];
    [micBasePath closePath];
    [darkColor setFill];
    [micBasePath fill];
    
    ////// Mic Base Inner Shadow
    CGRect micBaseBorderRect = CGRectInset([micBasePath bounds], -insetHighlightBlurRadius, -insetHighlightBlurRadius);
    micBaseBorderRect = CGRectOffset(micBaseBorderRect, -insetHighlightOffset.width, -insetHighlightOffset.height);
    micBaseBorderRect = CGRectInset(CGRectUnion(micBaseBorderRect, [micBasePath bounds]), -1, -1);
    
    UIBezierPath * micBaseNegativePath = [UIBezierPath bezierPathWithRect:micBaseBorderRect];
    [micBaseNegativePath appendPath:micBasePath];
    micBaseNegativePath.usesEvenOddFillRule = YES;
    
    CGContextSaveGState(context);
    {
        CGFloat xOffset = insetHighlightOffset.width + round(micBaseBorderRect.size.width);
        CGFloat yOffset = insetHighlightOffset.height;
        CGContextSetShadowWithColor(context,
                                    CGSizeMake(xOffset + copysign(0.1, xOffset), yOffset + copysign(0.1, yOffset)),
                                    insetHighlightBlurRadius,
                                    insetHighlight);
        
        [micBasePath addClip];
        CGAffineTransform transform = CGAffineTransformMakeTranslation(-round(micBaseBorderRect.size.width), 0);
        [micBaseNegativePath applyTransform:transform];
        [[UIColor grayColor] setFill];
        [micBaseNegativePath fill];
    }
    CGContextRestoreGState(context);
    
    
    [darkColor setStroke];
    micBasePath.lineWidth = 1;
    [micBasePath stroke];
    
    
    //// Mic Highlight Drawing
    UIBezierPath * micHighlightPath = [UIBezierPath bezierPath];
    [micHighlightPath moveToPoint:CGPointMake(53.38, 34.07)];
    [micHighlightPath addCurveToPoint:CGPointMake(53.71, 35.71) controlPoint1:CGPointMake(54.09, 34.86) controlPoint2:CGPointMake(54.04, 35.37)];
    [micHighlightPath addCurveToPoint:CGPointMake(52.29, 35.71) controlPoint1:CGPointMake(53.32, 36.1) controlPoint2:CGPointMake(52.68, 36.1)];
    [micHighlightPath addCurveToPoint:CGPointMake(52.29, 34.29) controlPoint1:CGPointMake(51.9, 35.32) controlPoint2:CGPointMake(51.9, 34.68)];
    [micHighlightPath addCurveToPoint:CGPointMake(53.38, 34.07) controlPoint1:CGPointMake(52.59, 34) controlPoint2:CGPointMake(53.02, 33.93)];
    [micHighlightPath closePath];
    [micHighlightPath moveToPoint:CGPointMake(48.38, 34.07)];
    [micHighlightPath addCurveToPoint:CGPointMake(48.71, 35.71) controlPoint1:CGPointMake(49.09, 34.86) controlPoint2:CGPointMake(49.04, 35.37)];
    [micHighlightPath addCurveToPoint:CGPointMake(47.29, 35.71) controlPoint1:CGPointMake(48.32, 36.1) controlPoint2:CGPointMake(47.68, 36.1)];
    [micHighlightPath addCurveToPoint:CGPointMake(47.29, 34.29) controlPoint1:CGPointMake(46.9, 35.32) controlPoint2:CGPointMake(46.9, 34.68)];
    [micHighlightPath addCurveToPoint:CGPointMake(48.38, 34.07) controlPoint1:CGPointMake(47.59, 34) controlPoint2:CGPointMake(48.02, 33.93)];
    [micHighlightPath closePath];
    [micHighlightPath moveToPoint:CGPointMake(43.38, 34.07)];
    [micHighlightPath addCurveToPoint:CGPointMake(43.71, 35.71) controlPoint1:CGPointMake(44.09, 34.86) controlPoint2:CGPointMake(44.04, 35.37)];
    [micHighlightPath addCurveToPoint:CGPointMake(42.29, 35.71) controlPoint1:CGPointMake(43.32, 36.1) controlPoint2:CGPointMake(42.68, 36.1)];
    [micHighlightPath addCurveToPoint:CGPointMake(42.29, 34.29) controlPoint1:CGPointMake(41.9, 35.32) controlPoint2:CGPointMake(41.9, 34.68)];
    [micHighlightPath addCurveToPoint:CGPointMake(43.38, 34.07) controlPoint1:CGPointMake(42.59, 34) controlPoint2:CGPointMake(43.02, 33.93)];
    [micHighlightPath closePath];
    [micHighlightPath moveToPoint:CGPointMake(60.5, 34.5)];
    [micHighlightPath addLineToPoint:CGPointMake(60.5, 36.5)];
    [micHighlightPath addCurveToPoint:CGPointMake(59.79, 34.79) controlPoint1:CGPointMake(59.19, 35.86) controlPoint2:CGPointMake(59.56, 35.03)];
    [micHighlightPath addLineToPoint:CGPointMake(60.5, 34.5)];
    [micHighlightPath closePath];
    [micHighlightPath moveToPoint:CGPointMake(55.88, 35.07)];
    [micHighlightPath addCurveToPoint:CGPointMake(56.21, 36.71) controlPoint1:CGPointMake(56.59, 35.86) controlPoint2:CGPointMake(56.54, 36.37)];
    [micHighlightPath addCurveToPoint:CGPointMake(54.79, 36.71) controlPoint1:CGPointMake(55.82, 37.1) controlPoint2:CGPointMake(55.18, 37.1)];
    [micHighlightPath addCurveToPoint:CGPointMake(54.79, 35.29) controlPoint1:CGPointMake(54.4, 36.32) controlPoint2:CGPointMake(54.4, 35.68)];
    [micHighlightPath addCurveToPoint:CGPointMake(55.88, 35.07) controlPoint1:CGPointMake(55.09, 35) controlPoint2:CGPointMake(55.52, 34.93)];
    [micHighlightPath closePath];
    [micHighlightPath moveToPoint:CGPointMake(50.88, 35.07)];
    [micHighlightPath addCurveToPoint:CGPointMake(51.21, 36.71) controlPoint1:CGPointMake(51.59, 35.86) controlPoint2:CGPointMake(51.54, 36.37)];
    [micHighlightPath addCurveToPoint:CGPointMake(49.79, 36.71) controlPoint1:CGPointMake(50.82, 37.1) controlPoint2:CGPointMake(50.18, 37.1)];
    [micHighlightPath addCurveToPoint:CGPointMake(49.79, 35.29) controlPoint1:CGPointMake(49.4, 36.32) controlPoint2:CGPointMake(49.4, 35.68)];
    [micHighlightPath addCurveToPoint:CGPointMake(50.88, 35.07) controlPoint1:CGPointMake(50.09, 35) controlPoint2:CGPointMake(50.52, 34.93)];
    [micHighlightPath closePath];
    [micHighlightPath moveToPoint:CGPointMake(45.88, 35.57)];
    [micHighlightPath addCurveToPoint:CGPointMake(46.21, 37.21) controlPoint1:CGPointMake(46.59, 36.36) controlPoint2:CGPointMake(46.54, 36.87)];
    [micHighlightPath addCurveToPoint:CGPointMake(44.79, 37.21) controlPoint1:CGPointMake(45.82, 37.6) controlPoint2:CGPointMake(45.18, 37.6)];
    [micHighlightPath addCurveToPoint:CGPointMake(44.79, 35.79) controlPoint1:CGPointMake(44.4, 36.82) controlPoint2:CGPointMake(44.4, 36.18)];
    [micHighlightPath addCurveToPoint:CGPointMake(45.88, 35.57) controlPoint1:CGPointMake(45.09, 35.5) controlPoint2:CGPointMake(45.52, 35.43)];
    [micHighlightPath closePath];
    [micHighlightPath moveToPoint:CGPointMake(40.69, 35.52)];
    [micHighlightPath addCurveToPoint:CGPointMake(41.21, 37.21) controlPoint1:CGPointMake(41.6, 36.18) controlPoint2:CGPointMake(41.6, 36.82)];
    [micHighlightPath addLineToPoint:CGPointMake(40.5, 37.5)];
    [micHighlightPath addLineToPoint:CGPointMake(40.5, 35.5)];
    [micHighlightPath addLineToPoint:CGPointMake(40.69, 35.52)];
    [micHighlightPath closePath];
    [micHighlightPath moveToPoint:CGPointMake(58.38, 36.57)];
    [micHighlightPath addCurveToPoint:CGPointMake(58.71, 37.79) controlPoint1:CGPointMake(59.09, 37.36) controlPoint2:CGPointMake(59.04, 37.46)];
    [micHighlightPath addCurveToPoint:CGPointMake(57.29, 38) controlPoint1:CGPointMake(58.32, 38.18) controlPoint2:CGPointMake(57.68, 38.39)];
    [micHighlightPath addCurveToPoint:CGPointMake(57.29, 36.79) controlPoint1:CGPointMake(56.9, 37.61) controlPoint2:CGPointMake(56.9, 37.18)];
    [micHighlightPath addCurveToPoint:CGPointMake(58.38, 36.57) controlPoint1:CGPointMake(57.59, 36.5) controlPoint2:CGPointMake(58.02, 36.43)];
    [micHighlightPath closePath];
    [micHighlightPath moveToPoint:CGPointMake(53.38, 36.57)];
    [micHighlightPath addCurveToPoint:CGPointMake(53.71, 38.21) controlPoint1:CGPointMake(54.09, 37.36) controlPoint2:CGPointMake(54.04, 37.87)];
    [micHighlightPath addCurveToPoint:CGPointMake(52.29, 38.21) controlPoint1:CGPointMake(53.32, 38.6) controlPoint2:CGPointMake(52.68, 38.6)];
    [micHighlightPath addCurveToPoint:CGPointMake(52.29, 36.79) controlPoint1:CGPointMake(51.9, 37.82) controlPoint2:CGPointMake(51.9, 37.18)];
    [micHighlightPath addCurveToPoint:CGPointMake(53.38, 36.57) controlPoint1:CGPointMake(52.59, 36.5) controlPoint2:CGPointMake(53.02, 36.43)];
    [micHighlightPath closePath];
    [micHighlightPath moveToPoint:CGPointMake(48.38, 36.57)];
    [micHighlightPath addCurveToPoint:CGPointMake(48.71, 38.21) controlPoint1:CGPointMake(49.09, 37.36) controlPoint2:CGPointMake(49.04, 37.87)];
    [micHighlightPath addCurveToPoint:CGPointMake(47.29, 38.21) controlPoint1:CGPointMake(48.32, 38.6) controlPoint2:CGPointMake(47.68, 38.6)];
    [micHighlightPath addCurveToPoint:CGPointMake(47.29, 36.79) controlPoint1:CGPointMake(46.9, 37.82) controlPoint2:CGPointMake(46.9, 37.18)];
    [micHighlightPath addCurveToPoint:CGPointMake(48.38, 36.57) controlPoint1:CGPointMake(47.59, 36.5) controlPoint2:CGPointMake(48.02, 36.43)];
    [micHighlightPath closePath];
    [micHighlightPath moveToPoint:CGPointMake(43.38, 36.57)];
    [micHighlightPath addCurveToPoint:CGPointMake(43.71, 38.21) controlPoint1:CGPointMake(44.09, 37.36) controlPoint2:CGPointMake(44.04, 37.87)];
    [micHighlightPath addCurveToPoint:CGPointMake(42.29, 38.21) controlPoint1:CGPointMake(43.32, 38.6) controlPoint2:CGPointMake(42.68, 38.6)];
    [micHighlightPath addCurveToPoint:CGPointMake(42.29, 36.79) controlPoint1:CGPointMake(41.9, 37.82) controlPoint2:CGPointMake(41.9, 37.18)];
    [micHighlightPath addCurveToPoint:CGPointMake(43.38, 36.57) controlPoint1:CGPointMake(42.59, 36.5) controlPoint2:CGPointMake(43.02, 36.43)];
    [micHighlightPath closePath];
    [micHighlightPath moveToPoint:CGPointMake(60.5, 37)];
    [micHighlightPath addLineToPoint:CGPointMake(60.5, 39)];
    [micHighlightPath addCurveToPoint:CGPointMake(59.79, 37.21) controlPoint1:CGPointMake(59.34, 37.75) controlPoint2:CGPointMake(59.52, 37.48)];
    [micHighlightPath addLineToPoint:CGPointMake(60.5, 37)];
    [micHighlightPath closePath];
    [micHighlightPath moveToPoint:CGPointMake(55.88, 37.57)];
    [micHighlightPath addCurveToPoint:CGPointMake(56.21, 39.21) controlPoint1:CGPointMake(56.59, 38.36) controlPoint2:CGPointMake(56.54, 38.87)];
    [micHighlightPath addCurveToPoint:CGPointMake(54.79, 39.21) controlPoint1:CGPointMake(55.82, 39.6) controlPoint2:CGPointMake(55.18, 39.6)];
    [micHighlightPath addCurveToPoint:CGPointMake(54.79, 37.79) controlPoint1:CGPointMake(54.4, 38.82) controlPoint2:CGPointMake(54.4, 38.18)];
    [micHighlightPath addCurveToPoint:CGPointMake(55.88, 37.57) controlPoint1:CGPointMake(55.09, 37.5) controlPoint2:CGPointMake(55.52, 37.43)];
    [micHighlightPath closePath];
    [micHighlightPath moveToPoint:CGPointMake(50.88, 37.57)];
    [micHighlightPath addCurveToPoint:CGPointMake(51.21, 39.21) controlPoint1:CGPointMake(51.59, 38.36) controlPoint2:CGPointMake(51.54, 38.87)];
    [micHighlightPath addCurveToPoint:CGPointMake(49.79, 39.21) controlPoint1:CGPointMake(50.82, 39.6) controlPoint2:CGPointMake(50.18, 39.6)];
    [micHighlightPath addCurveToPoint:CGPointMake(49.79, 37.79) controlPoint1:CGPointMake(49.4, 38.82) controlPoint2:CGPointMake(49.4, 38.18)];
    [micHighlightPath addCurveToPoint:CGPointMake(50.88, 37.57) controlPoint1:CGPointMake(50.09, 37.5) controlPoint2:CGPointMake(50.52, 37.43)];
    [micHighlightPath closePath];
    [micHighlightPath moveToPoint:CGPointMake(45.88, 38.07)];
    [micHighlightPath addCurveToPoint:CGPointMake(46.21, 39.71) controlPoint1:CGPointMake(46.59, 38.86) controlPoint2:CGPointMake(46.54, 39.37)];
    [micHighlightPath addCurveToPoint:CGPointMake(44.79, 39.71) controlPoint1:CGPointMake(45.82, 40.1) controlPoint2:CGPointMake(45.18, 40.1)];
    [micHighlightPath addCurveToPoint:CGPointMake(44.79, 38.29) controlPoint1:CGPointMake(44.4, 39.32) controlPoint2:CGPointMake(44.4, 38.68)];
    [micHighlightPath addCurveToPoint:CGPointMake(45.88, 38.07) controlPoint1:CGPointMake(45.09, 38) controlPoint2:CGPointMake(45.52, 37.93)];
    [micHighlightPath closePath];
    [micHighlightPath moveToPoint:CGPointMake(40.69, 38.02)];
    [micHighlightPath addCurveToPoint:CGPointMake(41.21, 39.71) controlPoint1:CGPointMake(41.6, 38.68) controlPoint2:CGPointMake(41.6, 39.32)];
    [micHighlightPath addLineToPoint:CGPointMake(40.5, 40)];
    [micHighlightPath addLineToPoint:CGPointMake(40.5, 38)];
    [micHighlightPath addLineToPoint:CGPointMake(40.69, 38.02)];
    [micHighlightPath closePath];
    [micHighlightPath moveToPoint:CGPointMake(58.38, 38.79)];
    [micHighlightPath addCurveToPoint:CGPointMake(58.71, 40.5) controlPoint1:CGPointMake(59.09, 39.58) controlPoint2:CGPointMake(59.04, 40.17)];
    [micHighlightPath addCurveToPoint:CGPointMake(57.29, 40.5) controlPoint1:CGPointMake(58.32, 40.89) controlPoint2:CGPointMake(57.68, 40.89)];
    [micHighlightPath addCurveToPoint:CGPointMake(57.29, 39) controlPoint1:CGPointMake(56.9, 40.11) controlPoint2:CGPointMake(56.9, 39.39)];
    [micHighlightPath addCurveToPoint:CGPointMake(58.38, 38.79) controlPoint1:CGPointMake(57.59, 38.71) controlPoint2:CGPointMake(58.02, 38.65)];
    [micHighlightPath closePath];
    [micHighlightPath moveToPoint:CGPointMake(53.38, 39.07)];
    [micHighlightPath addCurveToPoint:CGPointMake(53.71, 40.71) controlPoint1:CGPointMake(54.09, 39.86) controlPoint2:CGPointMake(54.04, 40.37)];
    [micHighlightPath addCurveToPoint:CGPointMake(52.29, 40.71) controlPoint1:CGPointMake(53.32, 41.1) controlPoint2:CGPointMake(52.68, 41.1)];
    [micHighlightPath addCurveToPoint:CGPointMake(52.29, 39.29) controlPoint1:CGPointMake(51.9, 40.32) controlPoint2:CGPointMake(51.9, 39.68)];
    [micHighlightPath addCurveToPoint:CGPointMake(53.38, 39.07) controlPoint1:CGPointMake(52.59, 39) controlPoint2:CGPointMake(53.02, 38.93)];
    [micHighlightPath closePath];
    [micHighlightPath moveToPoint:CGPointMake(48.38, 39.07)];
    [micHighlightPath addCurveToPoint:CGPointMake(48.71, 40.71) controlPoint1:CGPointMake(49.09, 39.86) controlPoint2:CGPointMake(49.04, 40.37)];
    [micHighlightPath addCurveToPoint:CGPointMake(47.29, 40.71) controlPoint1:CGPointMake(48.32, 41.1) controlPoint2:CGPointMake(47.68, 41.1)];
    [micHighlightPath addCurveToPoint:CGPointMake(47.29, 39.29) controlPoint1:CGPointMake(46.9, 40.32) controlPoint2:CGPointMake(46.9, 39.68)];
    [micHighlightPath addCurveToPoint:CGPointMake(48.38, 39.07) controlPoint1:CGPointMake(47.59, 39) controlPoint2:CGPointMake(48.02, 38.93)];
    [micHighlightPath closePath];
    [micHighlightPath moveToPoint:CGPointMake(43.38, 39.07)];
    [micHighlightPath addCurveToPoint:CGPointMake(43.71, 40.71) controlPoint1:CGPointMake(44.09, 39.86) controlPoint2:CGPointMake(44.04, 40.37)];
    [micHighlightPath addCurveToPoint:CGPointMake(42.29, 40.71) controlPoint1:CGPointMake(43.32, 41.1) controlPoint2:CGPointMake(42.68, 41.1)];
    [micHighlightPath addCurveToPoint:CGPointMake(42.29, 39.29) controlPoint1:CGPointMake(41.9, 40.32) controlPoint2:CGPointMake(41.9, 39.68)];
    [micHighlightPath addCurveToPoint:CGPointMake(43.38, 39.07) controlPoint1:CGPointMake(42.59, 39) controlPoint2:CGPointMake(43.02, 38.93)];
    [micHighlightPath closePath];
    [micHighlightPath moveToPoint:CGPointMake(60.5, 39.5)];
    [micHighlightPath addLineToPoint:CGPointMake(60.5, 41.5)];
    [micHighlightPath addCurveToPoint:CGPointMake(59.79, 39.71) controlPoint1:CGPointMake(59.05, 39.71) controlPoint2:CGPointMake(59.53, 39.97)];
    [micHighlightPath addLineToPoint:CGPointMake(60.5, 39.5)];
    [micHighlightPath closePath];
    [micHighlightPath moveToPoint:CGPointMake(55.88, 40.07)];
    [micHighlightPath addCurveToPoint:CGPointMake(56.21, 41.71) controlPoint1:CGPointMake(56.59, 40.86) controlPoint2:CGPointMake(56.54, 41.37)];
    [micHighlightPath addCurveToPoint:CGPointMake(54.79, 41.71) controlPoint1:CGPointMake(55.82, 42.1) controlPoint2:CGPointMake(55.18, 42.1)];
    [micHighlightPath addCurveToPoint:CGPointMake(54.79, 40.29) controlPoint1:CGPointMake(54.4, 41.32) controlPoint2:CGPointMake(54.4, 40.68)];
    [micHighlightPath addCurveToPoint:CGPointMake(55.88, 40.07) controlPoint1:CGPointMake(55.09, 40) controlPoint2:CGPointMake(55.52, 39.93)];
    [micHighlightPath closePath];
    [micHighlightPath moveToPoint:CGPointMake(50.88, 40.07)];
    [micHighlightPath addCurveToPoint:CGPointMake(51.21, 41.71) controlPoint1:CGPointMake(51.59, 40.86) controlPoint2:CGPointMake(51.54, 41.37)];
    [micHighlightPath addCurveToPoint:CGPointMake(49.79, 41.71) controlPoint1:CGPointMake(50.82, 42.1) controlPoint2:CGPointMake(50.18, 42.1)];
    [micHighlightPath addCurveToPoint:CGPointMake(49.79, 40.29) controlPoint1:CGPointMake(49.4, 41.32) controlPoint2:CGPointMake(49.4, 40.68)];
    [micHighlightPath addCurveToPoint:CGPointMake(50.88, 40.07) controlPoint1:CGPointMake(50.09, 40) controlPoint2:CGPointMake(50.52, 39.93)];
    [micHighlightPath closePath];
    [micHighlightPath moveToPoint:CGPointMake(45.88, 40.57)];
    [micHighlightPath addCurveToPoint:CGPointMake(46.21, 42.21) controlPoint1:CGPointMake(46.59, 41.36) controlPoint2:CGPointMake(46.54, 41.87)];
    [micHighlightPath addCurveToPoint:CGPointMake(44.79, 42.21) controlPoint1:CGPointMake(45.82, 42.6) controlPoint2:CGPointMake(45.18, 42.6)];
    [micHighlightPath addCurveToPoint:CGPointMake(44.79, 40.79) controlPoint1:CGPointMake(44.4, 41.82) controlPoint2:CGPointMake(44.4, 41.18)];
    [micHighlightPath addCurveToPoint:CGPointMake(45.88, 40.57) controlPoint1:CGPointMake(45.09, 40.5) controlPoint2:CGPointMake(45.52, 40.43)];
    [micHighlightPath closePath];
    [micHighlightPath moveToPoint:CGPointMake(40.69, 40.52)];
    [micHighlightPath addCurveToPoint:CGPointMake(41.21, 42.21) controlPoint1:CGPointMake(41.6, 41.18) controlPoint2:CGPointMake(41.6, 41.82)];
    [micHighlightPath addLineToPoint:CGPointMake(40.5, 42.5)];
    [micHighlightPath addLineToPoint:CGPointMake(40.5, 40.5)];
    [micHighlightPath addLineToPoint:CGPointMake(40.69, 40.52)];
    [micHighlightPath closePath];
    [micHighlightPath moveToPoint:CGPointMake(58.38, 41.5)];
    [micHighlightPath addCurveToPoint:CGPointMake(58.71, 43.02) controlPoint1:CGPointMake(59.09, 42.29) controlPoint2:CGPointMake(59.04, 42.69)];
    [micHighlightPath addCurveToPoint:CGPointMake(57.29, 43.07) controlPoint1:CGPointMake(58.32, 43.41) controlPoint2:CGPointMake(57.68, 43.46)];
    [micHighlightPath addCurveToPoint:CGPointMake(57.29, 41.5) controlPoint1:CGPointMake(56.9, 42.68) controlPoint2:CGPointMake(56.9, 41.89)];
    [micHighlightPath addCurveToPoint:CGPointMake(58.38, 41.5) controlPoint1:CGPointMake(57.59, 41.21) controlPoint2:CGPointMake(58.02, 41.35)];
    [micHighlightPath closePath];
    [micHighlightPath moveToPoint:CGPointMake(53.38, 41.57)];
    [micHighlightPath addCurveToPoint:CGPointMake(53.71, 43.21) controlPoint1:CGPointMake(54.09, 42.36) controlPoint2:CGPointMake(54.04, 42.87)];
    [micHighlightPath addCurveToPoint:CGPointMake(52.29, 43.21) controlPoint1:CGPointMake(53.32, 43.6) controlPoint2:CGPointMake(52.68, 43.6)];
    [micHighlightPath addCurveToPoint:CGPointMake(52.29, 41.79) controlPoint1:CGPointMake(51.9, 42.82) controlPoint2:CGPointMake(51.9, 42.18)];
    [micHighlightPath addCurveToPoint:CGPointMake(53.38, 41.57) controlPoint1:CGPointMake(52.59, 41.5) controlPoint2:CGPointMake(53.02, 41.43)];
    [micHighlightPath closePath];
    [micHighlightPath moveToPoint:CGPointMake(48.38, 41.57)];
    [micHighlightPath addCurveToPoint:CGPointMake(48.71, 43.21) controlPoint1:CGPointMake(49.09, 42.36) controlPoint2:CGPointMake(49.04, 42.87)];
    [micHighlightPath addCurveToPoint:CGPointMake(47.29, 43.21) controlPoint1:CGPointMake(48.32, 43.6) controlPoint2:CGPointMake(47.68, 43.6)];
    [micHighlightPath addCurveToPoint:CGPointMake(47.29, 41.79) controlPoint1:CGPointMake(46.9, 42.82) controlPoint2:CGPointMake(46.9, 42.18)];
    [micHighlightPath addCurveToPoint:CGPointMake(48.38, 41.57) controlPoint1:CGPointMake(47.59, 41.5) controlPoint2:CGPointMake(48.02, 41.43)];
    [micHighlightPath closePath];
    [micHighlightPath moveToPoint:CGPointMake(43.38, 41.57)];
    [micHighlightPath addCurveToPoint:CGPointMake(43.71, 43.21) controlPoint1:CGPointMake(44.09, 42.36) controlPoint2:CGPointMake(44.04, 42.87)];
    [micHighlightPath addCurveToPoint:CGPointMake(42.29, 43.21) controlPoint1:CGPointMake(43.32, 43.6) controlPoint2:CGPointMake(42.68, 43.6)];
    [micHighlightPath addCurveToPoint:CGPointMake(42.29, 41.79) controlPoint1:CGPointMake(41.9, 42.82) controlPoint2:CGPointMake(41.9, 42.18)];
    [micHighlightPath addCurveToPoint:CGPointMake(43.38, 41.57) controlPoint1:CGPointMake(42.59, 41.5) controlPoint2:CGPointMake(43.02, 41.43)];
    [micHighlightPath closePath];
    [micHighlightPath moveToPoint:CGPointMake(60.5, 42)];
    [micHighlightPath addLineToPoint:CGPointMake(60.5, 44)];
    [micHighlightPath addCurveToPoint:CGPointMake(59.79, 42.29) controlPoint1:CGPointMake(59.34, 42.78) controlPoint2:CGPointMake(59.55, 42.54)];
    [micHighlightPath addLineToPoint:CGPointMake(60.5, 42)];
    [micHighlightPath closePath];
    [micHighlightPath moveToPoint:CGPointMake(55.88, 42.57)];
    [micHighlightPath addCurveToPoint:CGPointMake(56.21, 44.21) controlPoint1:CGPointMake(56.59, 43.36) controlPoint2:CGPointMake(56.54, 43.87)];
    [micHighlightPath addCurveToPoint:CGPointMake(54.79, 44.21) controlPoint1:CGPointMake(55.82, 44.6) controlPoint2:CGPointMake(55.18, 44.6)];
    [micHighlightPath addCurveToPoint:CGPointMake(54.79, 42.79) controlPoint1:CGPointMake(54.4, 43.82) controlPoint2:CGPointMake(54.4, 43.18)];
    [micHighlightPath addCurveToPoint:CGPointMake(55.88, 42.57) controlPoint1:CGPointMake(55.09, 42.5) controlPoint2:CGPointMake(55.52, 42.43)];
    [micHighlightPath closePath];
    [micHighlightPath moveToPoint:CGPointMake(50.88, 42.57)];
    [micHighlightPath addCurveToPoint:CGPointMake(51.21, 44.21) controlPoint1:CGPointMake(51.59, 43.36) controlPoint2:CGPointMake(51.54, 43.87)];
    [micHighlightPath addCurveToPoint:CGPointMake(49.79, 44.21) controlPoint1:CGPointMake(50.82, 44.6) controlPoint2:CGPointMake(50.18, 44.6)];
    [micHighlightPath addCurveToPoint:CGPointMake(49.79, 42.79) controlPoint1:CGPointMake(49.4, 43.82) controlPoint2:CGPointMake(49.4, 43.18)];
    [micHighlightPath addCurveToPoint:CGPointMake(50.88, 42.57) controlPoint1:CGPointMake(50.09, 42.5) controlPoint2:CGPointMake(50.52, 42.43)];
    [micHighlightPath closePath];
    [micHighlightPath moveToPoint:CGPointMake(45.88, 43.07)];
    [micHighlightPath addCurveToPoint:CGPointMake(46.21, 44.71) controlPoint1:CGPointMake(46.59, 43.86) controlPoint2:CGPointMake(46.54, 44.37)];
    [micHighlightPath addCurveToPoint:CGPointMake(44.79, 44.71) controlPoint1:CGPointMake(45.82, 45.1) controlPoint2:CGPointMake(45.18, 45.1)];
    [micHighlightPath addCurveToPoint:CGPointMake(44.79, 43.29) controlPoint1:CGPointMake(44.4, 44.32) controlPoint2:CGPointMake(44.4, 43.68)];
    [micHighlightPath addCurveToPoint:CGPointMake(45.88, 43.07) controlPoint1:CGPointMake(45.09, 43) controlPoint2:CGPointMake(45.52, 42.93)];
    [micHighlightPath closePath];
    [micHighlightPath moveToPoint:CGPointMake(40.69, 43.02)];
    [micHighlightPath addCurveToPoint:CGPointMake(41.21, 44.71) controlPoint1:CGPointMake(41.6, 43.68) controlPoint2:CGPointMake(41.6, 44.32)];
    [micHighlightPath addLineToPoint:CGPointMake(40.5, 45)];
    [micHighlightPath addLineToPoint:CGPointMake(40.5, 43)];
    [micHighlightPath addLineToPoint:CGPointMake(40.69, 43.02)];
    [micHighlightPath closePath];
    [micHighlightPath moveToPoint:CGPointMake(58.38, 44)];
    [micHighlightPath addCurveToPoint:CGPointMake(58.71, 45.5) controlPoint1:CGPointMake(59.09, 44.79) controlPoint2:CGPointMake(59.04, 45.17)];
    [micHighlightPath addCurveToPoint:CGPointMake(57.29, 45.5) controlPoint1:CGPointMake(58.32, 45.89) controlPoint2:CGPointMake(57.68, 45.89)];
    [micHighlightPath addCurveToPoint:CGPointMake(57.29, 44) controlPoint1:CGPointMake(56.9, 45.11) controlPoint2:CGPointMake(56.9, 44.39)];
    [micHighlightPath addCurveToPoint:CGPointMake(58.38, 44) controlPoint1:CGPointMake(57.59, 43.71) controlPoint2:CGPointMake(58.02, 43.85)];
    [micHighlightPath closePath];
    [micHighlightPath moveToPoint:CGPointMake(53.38, 44.07)];
    [micHighlightPath addCurveToPoint:CGPointMake(53.71, 45.71) controlPoint1:CGPointMake(54.09, 44.86) controlPoint2:CGPointMake(54.04, 45.37)];
    [micHighlightPath addCurveToPoint:CGPointMake(52.29, 45.71) controlPoint1:CGPointMake(53.32, 46.1) controlPoint2:CGPointMake(52.68, 46.1)];
    [micHighlightPath addCurveToPoint:CGPointMake(52.29, 44.29) controlPoint1:CGPointMake(51.9, 45.32) controlPoint2:CGPointMake(51.9, 44.68)];
    [micHighlightPath addCurveToPoint:CGPointMake(53.38, 44.07) controlPoint1:CGPointMake(52.59, 44) controlPoint2:CGPointMake(53.02, 43.93)];
    [micHighlightPath closePath];
    [micHighlightPath moveToPoint:CGPointMake(48.38, 44.07)];
    [micHighlightPath addCurveToPoint:CGPointMake(48.71, 45.71) controlPoint1:CGPointMake(49.09, 44.86) controlPoint2:CGPointMake(49.04, 45.37)];
    [micHighlightPath addCurveToPoint:CGPointMake(47.29, 45.71) controlPoint1:CGPointMake(48.32, 46.1) controlPoint2:CGPointMake(47.68, 46.1)];
    [micHighlightPath addCurveToPoint:CGPointMake(47.29, 44.29) controlPoint1:CGPointMake(46.9, 45.32) controlPoint2:CGPointMake(46.9, 44.68)];
    [micHighlightPath addCurveToPoint:CGPointMake(48.38, 44.07) controlPoint1:CGPointMake(47.59, 44) controlPoint2:CGPointMake(48.02, 43.93)];
    [micHighlightPath closePath];
    [micHighlightPath moveToPoint:CGPointMake(43.38, 44.07)];
    [micHighlightPath addCurveToPoint:CGPointMake(43.71, 45.71) controlPoint1:CGPointMake(44.09, 44.86) controlPoint2:CGPointMake(44.04, 45.37)];
    [micHighlightPath addCurveToPoint:CGPointMake(42.29, 45.71) controlPoint1:CGPointMake(43.32, 46.1) controlPoint2:CGPointMake(42.68, 46.1)];
    [micHighlightPath addCurveToPoint:CGPointMake(42.29, 44.29) controlPoint1:CGPointMake(41.9, 45.32) controlPoint2:CGPointMake(41.9, 44.68)];
    [micHighlightPath addCurveToPoint:CGPointMake(43.38, 44.07) controlPoint1:CGPointMake(42.59, 44) controlPoint2:CGPointMake(43.02, 43.93)];
    [micHighlightPath closePath];
    [micHighlightPath moveToPoint:CGPointMake(60.5, 44.5)];
    [micHighlightPath addLineToPoint:CGPointMake(60.5, 46.5)];
    [micHighlightPath addCurveToPoint:CGPointMake(59.79, 44.79) controlPoint1:CGPointMake(59.17, 45.15) controlPoint2:CGPointMake(59.53, 45.06)];
    [micHighlightPath addLineToPoint:CGPointMake(60.5, 44.5)];
    [micHighlightPath closePath];
    [micHighlightPath moveToPoint:CGPointMake(55.88, 45.07)];
    [micHighlightPath addCurveToPoint:CGPointMake(56.21, 46.71) controlPoint1:CGPointMake(56.59, 45.86) controlPoint2:CGPointMake(56.54, 46.37)];
    [micHighlightPath addCurveToPoint:CGPointMake(54.79, 46.71) controlPoint1:CGPointMake(55.82, 47.1) controlPoint2:CGPointMake(55.18, 47.1)];
    [micHighlightPath addCurveToPoint:CGPointMake(54.79, 45.29) controlPoint1:CGPointMake(54.4, 46.32) controlPoint2:CGPointMake(54.4, 45.68)];
    [micHighlightPath addCurveToPoint:CGPointMake(55.88, 45.07) controlPoint1:CGPointMake(55.09, 45) controlPoint2:CGPointMake(55.52, 44.93)];
    [micHighlightPath closePath];
    [micHighlightPath moveToPoint:CGPointMake(50.88, 45.07)];
    [micHighlightPath addCurveToPoint:CGPointMake(51.21, 46.71) controlPoint1:CGPointMake(51.59, 45.86) controlPoint2:CGPointMake(51.54, 46.37)];
    [micHighlightPath addCurveToPoint:CGPointMake(49.79, 46.71) controlPoint1:CGPointMake(50.82, 47.1) controlPoint2:CGPointMake(50.18, 47.1)];
    [micHighlightPath addCurveToPoint:CGPointMake(49.79, 45.29) controlPoint1:CGPointMake(49.4, 46.32) controlPoint2:CGPointMake(49.4, 45.68)];
    [micHighlightPath addCurveToPoint:CGPointMake(50.88, 45.07) controlPoint1:CGPointMake(50.09, 45) controlPoint2:CGPointMake(50.52, 44.93)];
    [micHighlightPath closePath];
    [micHighlightPath moveToPoint:CGPointMake(40.69, 45.52)];
    [micHighlightPath addCurveToPoint:CGPointMake(41.21, 47.21) controlPoint1:CGPointMake(41.58, 46.45) controlPoint2:CGPointMake(41.51, 46.9)];
    [micHighlightPath addLineToPoint:CGPointMake(40.5, 47.5)];
    [micHighlightPath addLineToPoint:CGPointMake(40.5, 45.5)];
    [micHighlightPath addLineToPoint:CGPointMake(40.69, 45.52)];
    [micHighlightPath closePath];
    [micHighlightPath moveToPoint:CGPointMake(45.88, 45.57)];
    [micHighlightPath addCurveToPoint:CGPointMake(46.21, 47.21) controlPoint1:CGPointMake(46.59, 46.36) controlPoint2:CGPointMake(46.54, 46.87)];
    [micHighlightPath addCurveToPoint:CGPointMake(44.79, 47.21) controlPoint1:CGPointMake(45.82, 47.6) controlPoint2:CGPointMake(45.18, 47.6)];
    [micHighlightPath addCurveToPoint:CGPointMake(44.79, 45.79) controlPoint1:CGPointMake(44.4, 46.82) controlPoint2:CGPointMake(44.4, 46.18)];
    [micHighlightPath addCurveToPoint:CGPointMake(45.88, 45.57) controlPoint1:CGPointMake(45.09, 45.5) controlPoint2:CGPointMake(45.52, 45.43)];
    [micHighlightPath closePath];
    [micHighlightPath moveToPoint:CGPointMake(58.38, 46.5)];
    [micHighlightPath addCurveToPoint:CGPointMake(58.71, 47.79) controlPoint1:CGPointMake(59.09, 47.29) controlPoint2:CGPointMake(59.04, 47.46)];
    [micHighlightPath addCurveToPoint:CGPointMake(57.29, 48.03) controlPoint1:CGPointMake(58.32, 48.18) controlPoint2:CGPointMake(57.68, 48.42)];
    [micHighlightPath addCurveToPoint:CGPointMake(57.29, 46.5) controlPoint1:CGPointMake(56.9, 47.64) controlPoint2:CGPointMake(56.9, 46.89)];
    [micHighlightPath addCurveToPoint:CGPointMake(58.38, 46.5) controlPoint1:CGPointMake(57.59, 46.21) controlPoint2:CGPointMake(58.02, 46.35)];
    [micHighlightPath closePath];
    [micHighlightPath moveToPoint:CGPointMake(53.38, 46.57)];
    [micHighlightPath addCurveToPoint:CGPointMake(53.71, 48.21) controlPoint1:CGPointMake(54.09, 47.36) controlPoint2:CGPointMake(54.04, 47.87)];
    [micHighlightPath addCurveToPoint:CGPointMake(52.29, 48.21) controlPoint1:CGPointMake(53.32, 48.6) controlPoint2:CGPointMake(52.68, 48.6)];
    [micHighlightPath addCurveToPoint:CGPointMake(52.29, 46.79) controlPoint1:CGPointMake(51.9, 47.82) controlPoint2:CGPointMake(51.9, 47.18)];
    [micHighlightPath addCurveToPoint:CGPointMake(53.38, 46.57) controlPoint1:CGPointMake(52.59, 46.5) controlPoint2:CGPointMake(53.02, 46.43)];
    [micHighlightPath closePath];
    [micHighlightPath moveToPoint:CGPointMake(48.38, 46.57)];
    [micHighlightPath addCurveToPoint:CGPointMake(48.71, 48.21) controlPoint1:CGPointMake(49.09, 47.36) controlPoint2:CGPointMake(49.04, 47.87)];
    [micHighlightPath addCurveToPoint:CGPointMake(47.29, 48.21) controlPoint1:CGPointMake(48.32, 48.6) controlPoint2:CGPointMake(47.68, 48.6)];
    [micHighlightPath addCurveToPoint:CGPointMake(47.29, 46.79) controlPoint1:CGPointMake(46.9, 47.82) controlPoint2:CGPointMake(46.9, 47.18)];
    [micHighlightPath addCurveToPoint:CGPointMake(48.38, 46.57) controlPoint1:CGPointMake(47.59, 46.5) controlPoint2:CGPointMake(48.02, 46.43)];
    [micHighlightPath closePath];
    [micHighlightPath moveToPoint:CGPointMake(43.38, 46.57)];
    [micHighlightPath addCurveToPoint:CGPointMake(43.71, 48.21) controlPoint1:CGPointMake(44.09, 47.36) controlPoint2:CGPointMake(44.04, 47.87)];
    [micHighlightPath addCurveToPoint:CGPointMake(42.29, 48.21) controlPoint1:CGPointMake(43.32, 48.6) controlPoint2:CGPointMake(42.68, 48.6)];
    [micHighlightPath addCurveToPoint:CGPointMake(42.29, 46.79) controlPoint1:CGPointMake(41.9, 47.82) controlPoint2:CGPointMake(41.9, 47.18)];
    [micHighlightPath addCurveToPoint:CGPointMake(43.38, 46.57) controlPoint1:CGPointMake(42.59, 46.5) controlPoint2:CGPointMake(43.02, 46.43)];
    [micHighlightPath closePath];
    [micHighlightPath moveToPoint:CGPointMake(60.49, 47.01)];
    [micHighlightPath addCurveToPoint:CGPointMake(60.2, 48.95) controlPoint1:CGPointMake(60.45, 47.67) controlPoint2:CGPointMake(60.67, 48.35)];
    [micHighlightPath addCurveToPoint:CGPointMake(59.79, 47.29) controlPoint1:CGPointMake(59.4, 48.32) controlPoint2:CGPointMake(59.4, 47.68)];
    [micHighlightPath addLineToPoint:CGPointMake(60.49, 47.01)];
    [micHighlightPath closePath];
    [micHighlightPath moveToPoint:CGPointMake(55.88, 47.57)];
    [micHighlightPath addCurveToPoint:CGPointMake(56.21, 49.21) controlPoint1:CGPointMake(56.59, 48.36) controlPoint2:CGPointMake(56.54, 48.87)];
    [micHighlightPath addCurveToPoint:CGPointMake(54.79, 49.21) controlPoint1:CGPointMake(55.82, 49.6) controlPoint2:CGPointMake(55.18, 49.6)];
    [micHighlightPath addCurveToPoint:CGPointMake(54.79, 47.79) controlPoint1:CGPointMake(54.4, 48.82) controlPoint2:CGPointMake(54.4, 48.18)];
    [micHighlightPath addCurveToPoint:CGPointMake(55.88, 47.57) controlPoint1:CGPointMake(55.09, 47.5) controlPoint2:CGPointMake(55.52, 47.43)];
    [micHighlightPath closePath];
    [micHighlightPath moveToPoint:CGPointMake(50.88, 47.57)];
    [micHighlightPath addCurveToPoint:CGPointMake(51.21, 49.21) controlPoint1:CGPointMake(51.59, 48.36) controlPoint2:CGPointMake(51.54, 48.87)];
    [micHighlightPath addCurveToPoint:CGPointMake(49.79, 49.21) controlPoint1:CGPointMake(50.82, 49.6) controlPoint2:CGPointMake(50.18, 49.6)];
    [micHighlightPath addCurveToPoint:CGPointMake(49.79, 47.79) controlPoint1:CGPointMake(49.4, 48.82) controlPoint2:CGPointMake(49.4, 48.18)];
    [micHighlightPath addCurveToPoint:CGPointMake(50.88, 47.57) controlPoint1:CGPointMake(50.09, 47.5) controlPoint2:CGPointMake(50.52, 47.43)];
    [micHighlightPath closePath];
    [micHighlightPath moveToPoint:CGPointMake(40.69, 48.02)];
    [micHighlightPath addCurveToPoint:CGPointMake(41.21, 49.71) controlPoint1:CGPointMake(41.6, 48.68) controlPoint2:CGPointMake(41.6, 49.32)];
    [micHighlightPath addCurveToPoint:CGPointMake(40.62, 48.03) controlPoint1:CGPointMake(40.86, 49.25) controlPoint2:CGPointMake(40.71, 48.65)];
    [micHighlightPath addLineToPoint:CGPointMake(40.69, 48.02)];
    [micHighlightPath closePath];
    [micHighlightPath moveToPoint:CGPointMake(45.88, 48.07)];
    [micHighlightPath addCurveToPoint:CGPointMake(46.21, 49.71) controlPoint1:CGPointMake(46.59, 48.86) controlPoint2:CGPointMake(46.54, 49.37)];
    [micHighlightPath addCurveToPoint:CGPointMake(44.79, 49.71) controlPoint1:CGPointMake(45.82, 50.1) controlPoint2:CGPointMake(45.18, 50.1)];
    [micHighlightPath addCurveToPoint:CGPointMake(44.79, 48.29) controlPoint1:CGPointMake(44.4, 49.32) controlPoint2:CGPointMake(44.4, 48.68)];
    [micHighlightPath addCurveToPoint:CGPointMake(45.88, 48.07) controlPoint1:CGPointMake(45.09, 48) controlPoint2:CGPointMake(45.52, 47.93)];
    [micHighlightPath closePath];
    [micHighlightPath moveToPoint:CGPointMake(58.38, 49.07)];
    [micHighlightPath addCurveToPoint:CGPointMake(58.71, 50.5) controlPoint1:CGPointMake(59.09, 49.86) controlPoint2:CGPointMake(59.04, 50.17)];
    [micHighlightPath addCurveToPoint:CGPointMake(57.29, 50.57) controlPoint1:CGPointMake(58.32, 50.89) controlPoint2:CGPointMake(57.68, 50.96)];
    [micHighlightPath addCurveToPoint:CGPointMake(57.29, 49.21) controlPoint1:CGPointMake(56.9, 50.18) controlPoint2:CGPointMake(56.9, 49.6)];
    [micHighlightPath addCurveToPoint:CGPointMake(58.38, 49.07) controlPoint1:CGPointMake(57.59, 48.91) controlPoint2:CGPointMake(58.02, 48.93)];
    [micHighlightPath closePath];
    [micHighlightPath moveToPoint:CGPointMake(53.38, 49.07)];
    [micHighlightPath addCurveToPoint:CGPointMake(53.71, 50.71) controlPoint1:CGPointMake(54.09, 49.86) controlPoint2:CGPointMake(54.04, 50.37)];
    [micHighlightPath addCurveToPoint:CGPointMake(52.29, 50.71) controlPoint1:CGPointMake(53.32, 51.1) controlPoint2:CGPointMake(52.68, 51.1)];
    [micHighlightPath addCurveToPoint:CGPointMake(52.29, 49.29) controlPoint1:CGPointMake(51.9, 50.32) controlPoint2:CGPointMake(51.9, 49.68)];
    [micHighlightPath addCurveToPoint:CGPointMake(53.38, 49.07) controlPoint1:CGPointMake(52.59, 49) controlPoint2:CGPointMake(53.02, 48.93)];
    [micHighlightPath closePath];
    [micHighlightPath moveToPoint:CGPointMake(48.38, 49.07)];
    [micHighlightPath addCurveToPoint:CGPointMake(48.71, 50.71) controlPoint1:CGPointMake(49.09, 49.86) controlPoint2:CGPointMake(49.04, 50.37)];
    [micHighlightPath addCurveToPoint:CGPointMake(47.29, 50.71) controlPoint1:CGPointMake(48.32, 51.1) controlPoint2:CGPointMake(47.68, 51.1)];
    [micHighlightPath addCurveToPoint:CGPointMake(47.29, 49.29) controlPoint1:CGPointMake(46.9, 50.32) controlPoint2:CGPointMake(46.9, 49.68)];
    [micHighlightPath addCurveToPoint:CGPointMake(48.38, 49.07) controlPoint1:CGPointMake(47.59, 49) controlPoint2:CGPointMake(48.02, 48.93)];
    [micHighlightPath closePath];
    [micHighlightPath moveToPoint:CGPointMake(43.38, 49.07)];
    [micHighlightPath addCurveToPoint:CGPointMake(43.71, 50.71) controlPoint1:CGPointMake(44.09, 49.86) controlPoint2:CGPointMake(44.04, 50.37)];
    [micHighlightPath addCurveToPoint:CGPointMake(42.29, 50.71) controlPoint1:CGPointMake(43.32, 51.1) controlPoint2:CGPointMake(42.68, 51.1)];
    [micHighlightPath addCurveToPoint:CGPointMake(42.29, 49.29) controlPoint1:CGPointMake(41.9, 50.32) controlPoint2:CGPointMake(41.9, 49.68)];
    [micHighlightPath addCurveToPoint:CGPointMake(43.38, 49.07) controlPoint1:CGPointMake(42.59, 49) controlPoint2:CGPointMake(43.02, 48.93)];
    [micHighlightPath closePath];
    [micHighlightPath moveToPoint:CGPointMake(55.88, 50.07)];
    [micHighlightPath addCurveToPoint:CGPointMake(56.21, 51.71) controlPoint1:CGPointMake(56.59, 50.86) controlPoint2:CGPointMake(56.54, 51.37)];
    [micHighlightPath addCurveToPoint:CGPointMake(54.79, 51.71) controlPoint1:CGPointMake(55.82, 52.1) controlPoint2:CGPointMake(55.18, 52.1)];
    [micHighlightPath addCurveToPoint:CGPointMake(54.79, 50.29) controlPoint1:CGPointMake(54.4, 51.32) controlPoint2:CGPointMake(54.4, 50.68)];
    [micHighlightPath addCurveToPoint:CGPointMake(55.88, 50.07) controlPoint1:CGPointMake(55.09, 50) controlPoint2:CGPointMake(55.52, 49.93)];
    [micHighlightPath closePath];
    [micHighlightPath moveToPoint:CGPointMake(50.88, 50.07)];
    [micHighlightPath addCurveToPoint:CGPointMake(51.21, 51.71) controlPoint1:CGPointMake(51.59, 50.86) controlPoint2:CGPointMake(51.54, 51.37)];
    [micHighlightPath addCurveToPoint:CGPointMake(49.79, 51.71) controlPoint1:CGPointMake(50.82, 52.1) controlPoint2:CGPointMake(50.18, 52.1)];
    [micHighlightPath addCurveToPoint:CGPointMake(49.79, 50.29) controlPoint1:CGPointMake(49.4, 51.32) controlPoint2:CGPointMake(49.4, 50.68)];
    [micHighlightPath addCurveToPoint:CGPointMake(50.88, 50.07) controlPoint1:CGPointMake(50.09, 50) controlPoint2:CGPointMake(50.52, 49.93)];
    [micHighlightPath closePath];
    [micHighlightPath moveToPoint:CGPointMake(45.88, 50.57)];
    [micHighlightPath addCurveToPoint:CGPointMake(46.21, 52.21) controlPoint1:CGPointMake(46.59, 51.36) controlPoint2:CGPointMake(46.54, 51.87)];
    [micHighlightPath addCurveToPoint:CGPointMake(44.79, 52.21) controlPoint1:CGPointMake(45.82, 52.6) controlPoint2:CGPointMake(45.18, 52.6)];
    [micHighlightPath addCurveToPoint:CGPointMake(44.79, 50.79) controlPoint1:CGPointMake(44.4, 51.82) controlPoint2:CGPointMake(44.4, 51.18)];
    [micHighlightPath addCurveToPoint:CGPointMake(45.88, 50.57) controlPoint1:CGPointMake(45.09, 50.5) controlPoint2:CGPointMake(45.52, 50.43)];
    [micHighlightPath closePath];
    [micHighlightPath moveToPoint:CGPointMake(57.5, 52.5)];
    [micHighlightPath addCurveToPoint:CGPointMake(57.29, 51.5) controlPoint1:CGPointMake(56.65, 51.69) controlPoint2:CGPointMake(57.07, 51.72)];
    [micHighlightPath addCurveToPoint:CGPointMake(58.38, 51.5) controlPoint1:CGPointMake(57.59, 51.2) controlPoint2:CGPointMake(58.01, 51.28)];
    [micHighlightPath addCurveToPoint:CGPointMake(57.5, 52.5) controlPoint1:CGPointMake(58.38, 51.5) controlPoint2:CGPointMake(57.93, 52.91)];
    [micHighlightPath closePath];
    [micHighlightPath moveToPoint:CGPointMake(43.38, 51.57)];
    [micHighlightPath addCurveToPoint:CGPointMake(43.71, 53.21) controlPoint1:CGPointMake(44.09, 52.36) controlPoint2:CGPointMake(44.04, 52.87)];
    [micHighlightPath addCurveToPoint:CGPointMake(42.14, 51.99) controlPoint1:CGPointMake(42.88, 53) controlPoint2:CGPointMake(42.48, 52.51)];
    [micHighlightPath addCurveToPoint:CGPointMake(43.37, 51.58) controlPoint1:CGPointMake(42.55, 51.55) controlPoint2:CGPointMake(43.01, 51.44)];
    [micHighlightPath addLineToPoint:CGPointMake(43.38, 51.57)];
    [micHighlightPath closePath];
    [micHighlightPath moveToPoint:CGPointMake(53.38, 51.57)];
    [micHighlightPath addCurveToPoint:CGPointMake(53.71, 53.21) controlPoint1:CGPointMake(54.09, 52.36) controlPoint2:CGPointMake(54.04, 52.87)];
    [micHighlightPath addCurveToPoint:CGPointMake(52.29, 53.21) controlPoint1:CGPointMake(53.32, 53.6) controlPoint2:CGPointMake(52.68, 53.6)];
    [micHighlightPath addCurveToPoint:CGPointMake(52.29, 51.79) controlPoint1:CGPointMake(51.9, 52.82) controlPoint2:CGPointMake(51.9, 52.18)];
    [micHighlightPath addCurveToPoint:CGPointMake(53.38, 51.57) controlPoint1:CGPointMake(52.59, 51.5) controlPoint2:CGPointMake(53.02, 51.43)];
    [micHighlightPath closePath];
    [micHighlightPath moveToPoint:CGPointMake(48.38, 51.57)];
    [micHighlightPath addCurveToPoint:CGPointMake(48.71, 53.21) controlPoint1:CGPointMake(49.09, 52.36) controlPoint2:CGPointMake(49.04, 52.87)];
    [micHighlightPath addCurveToPoint:CGPointMake(47.29, 53.21) controlPoint1:CGPointMake(48.32, 53.6) controlPoint2:CGPointMake(47.68, 53.6)];
    [micHighlightPath addCurveToPoint:CGPointMake(47.29, 51.79) controlPoint1:CGPointMake(46.9, 52.82) controlPoint2:CGPointMake(46.9, 52.18)];
    [micHighlightPath addCurveToPoint:CGPointMake(48.38, 51.57) controlPoint1:CGPointMake(47.59, 51.5) controlPoint2:CGPointMake(48.02, 51.43)];
    [micHighlightPath closePath];
    [micHighlightPath moveToPoint:CGPointMake(55.88, 52.57)];
    [micHighlightPath addCurveToPoint:CGPointMake(56.21, 54.21) controlPoint1:CGPointMake(56.59, 53.36) controlPoint2:CGPointMake(56.54, 53.87)];
    [micHighlightPath addCurveToPoint:CGPointMake(54.79, 54.21) controlPoint1:CGPointMake(55.34, 54.53) controlPoint2:CGPointMake(55.03, 54.44)];
    [micHighlightPath addCurveToPoint:CGPointMake(54.79, 52.79) controlPoint1:CGPointMake(54.4, 53.82) controlPoint2:CGPointMake(54.4, 53.18)];
    [micHighlightPath addCurveToPoint:CGPointMake(55.88, 52.57) controlPoint1:CGPointMake(55.09, 52.5) controlPoint2:CGPointMake(55.52, 52.43)];
    [micHighlightPath closePath];
    [micHighlightPath moveToPoint:CGPointMake(50.88, 52.57)];
    [micHighlightPath addCurveToPoint:CGPointMake(51.21, 54.21) controlPoint1:CGPointMake(51.59, 53.36) controlPoint2:CGPointMake(51.54, 53.87)];
    [micHighlightPath addCurveToPoint:CGPointMake(49.79, 54.21) controlPoint1:CGPointMake(50.82, 54.6) controlPoint2:CGPointMake(50.18, 54.6)];
    [micHighlightPath addCurveToPoint:CGPointMake(49.79, 52.79) controlPoint1:CGPointMake(49.4, 53.82) controlPoint2:CGPointMake(49.4, 53.18)];
    [micHighlightPath addCurveToPoint:CGPointMake(50.88, 52.57) controlPoint1:CGPointMake(50.09, 52.5) controlPoint2:CGPointMake(50.52, 52.43)];
    [micHighlightPath closePath];
    [micHighlightPath moveToPoint:CGPointMake(45.88, 53.07)];
    [micHighlightPath addCurveToPoint:CGPointMake(46.21, 54.71) controlPoint1:CGPointMake(46.59, 53.86) controlPoint2:CGPointMake(46.54, 54.37)];
    [micHighlightPath addCurveToPoint:CGPointMake(45.1, 54.91) controlPoint1:CGPointMake(45.91, 55.01) controlPoint2:CGPointMake(45.46, 55.08)];
    [micHighlightPath addCurveToPoint:CGPointMake(44.79, 53.29) controlPoint1:CGPointMake(44.4, 54.32) controlPoint2:CGPointMake(44.4, 53.68)];
    [micHighlightPath addCurveToPoint:CGPointMake(45.88, 53.07) controlPoint1:CGPointMake(45.09, 53) controlPoint2:CGPointMake(45.52, 52.93)];
    [micHighlightPath closePath];
    [micHighlightPath moveToPoint:CGPointMake(53.38, 54.07)];
    [micHighlightPath addCurveToPoint:CGPointMake(53.71, 55.71) controlPoint1:CGPointMake(54.09, 54.86) controlPoint2:CGPointMake(54.04, 55.37)];
    [micHighlightPath addCurveToPoint:CGPointMake(52.29, 55.71) controlPoint1:CGPointMake(53.32, 56.1) controlPoint2:CGPointMake(52.68, 56.1)];
    [micHighlightPath addCurveToPoint:CGPointMake(52.29, 54.29) controlPoint1:CGPointMake(51.9, 55.32) controlPoint2:CGPointMake(51.9, 54.68)];
    [micHighlightPath addCurveToPoint:CGPointMake(53.38, 54.07) controlPoint1:CGPointMake(52.59, 54) controlPoint2:CGPointMake(53.02, 53.93)];
    [micHighlightPath closePath];
    [micHighlightPath moveToPoint:CGPointMake(48.38, 54.07)];
    [micHighlightPath addCurveToPoint:CGPointMake(48.71, 55.71) controlPoint1:CGPointMake(49.09, 54.86) controlPoint2:CGPointMake(49.04, 55.37)];
    [micHighlightPath addCurveToPoint:CGPointMake(47.29, 55.71) controlPoint1:CGPointMake(48.32, 56.1) controlPoint2:CGPointMake(47.68, 56.1)];
    [micHighlightPath addCurveToPoint:CGPointMake(47.29, 54.29) controlPoint1:CGPointMake(46.9, 55.32) controlPoint2:CGPointMake(46.9, 54.68)];
    [micHighlightPath addCurveToPoint:CGPointMake(48.38, 54.07) controlPoint1:CGPointMake(47.59, 54) controlPoint2:CGPointMake(48.02, 53.93)];
    [micHighlightPath closePath];
    [micHighlightPath moveToPoint:CGPointMake(50.88, 55.07)];
    [micHighlightPath addCurveToPoint:CGPointMake(51.39, 56.46) controlPoint1:CGPointMake(51.54, 55.77) controlPoint2:CGPointMake(51.55, 56.15)];
    [micHighlightPath addLineToPoint:CGPointMake(50.5, 56.5)];
    [micHighlightPath addLineToPoint:CGPointMake(49.99, 56.49)];
    [micHighlightPath addCurveToPoint:CGPointMake(49.79, 55.29) controlPoint1:CGPointMake(49.42, 56.08) controlPoint2:CGPointMake(49.48, 55.61)];
    [micHighlightPath addCurveToPoint:CGPointMake(50.88, 55.07) controlPoint1:CGPointMake(50.09, 55) controlPoint2:CGPointMake(50.52, 54.93)];
    [micHighlightPath closePath];
    [micHighlightPath moveToPoint:CGPointMake(59, 51.5)];
    [micHighlightPath addLineToPoint:CGPointMake(60, 49.5)];
    [micHighlightPath addLineToPoint:CGPointMake(60, 50.5)];
    [micHighlightPath addLineToPoint:CGPointMake(59, 51.5)];
    [micHighlightPath closePath];
    [micHighlightPath moveToPoint:CGPointMake(58.71, 35.57)];
    [micHighlightPath addCurveToPoint:CGPointMake(58.71, 34.29) controlPoint1:CGPointMake(59.1, 35.18) controlPoint2:CGPointMake(59.1, 34.68)];
    [micHighlightPath addCurveToPoint:CGPointMake(57.29, 34.29) controlPoint1:CGPointMake(58.32, 33.9) controlPoint2:CGPointMake(57.68, 33.9)];
    [micHighlightPath addCurveToPoint:CGPointMake(57.29, 35.79) controlPoint1:CGPointMake(56.9, 34.68) controlPoint2:CGPointMake(56.9, 35.4)];
    [micHighlightPath addCurveToPoint:CGPointMake(58.71, 35.57) controlPoint1:CGPointMake(57.68, 36.18) controlPoint2:CGPointMake(58.32, 35.96)];
    [micHighlightPath closePath];
    [micColor setFill];
    [micHighlightPath fill];
    
    ////// Mic Highlight Inner Shadow
    CGRect micHighlightBorderRect = CGRectInset([micHighlightPath bounds], -insetHighlightBlurRadius, -insetHighlightBlurRadius);
    micHighlightBorderRect = CGRectOffset(micHighlightBorderRect, -insetHighlightOffset.width, -insetHighlightOffset.height);
    micHighlightBorderRect = CGRectInset(CGRectUnion(micHighlightBorderRect, [micHighlightPath bounds]), -1, -1);
    
    UIBezierPath * micHighlightNegativePath = [UIBezierPath bezierPathWithRect:micHighlightBorderRect];
    [micHighlightNegativePath appendPath:micHighlightPath];
    micHighlightNegativePath.usesEvenOddFillRule = YES;
    
    CGContextSaveGState(context);
    {
        CGFloat xOffset = insetHighlightOffset.width + round(micHighlightBorderRect.size.width);
        CGFloat yOffset = insetHighlightOffset.height;
        CGContextSetShadowWithColor(context,
                                    CGSizeMake(xOffset + copysign(0.1, xOffset), yOffset + copysign(0.1, yOffset)),
                                    insetHighlightBlurRadius,
                                    insetHighlight);
        
        [micHighlightPath addClip];
        CGAffineTransform transform = CGAffineTransformMakeTranslation(-round(micHighlightBorderRect.size.width), 0);
        [micHighlightNegativePath applyTransform:transform];
        [[UIColor grayColor] setFill];
        [micHighlightNegativePath fill];
    }
    CGContextRestoreGState(context);
    
    
    
    
    //// Mic Top Shine Drawing
    UIBezierPath * micTopShinePath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(40.5, 16.5, 20, 40) cornerRadius:10];
    CGContextSaveGState(context);
    [micTopShinePath addClip];
    CGContextDrawLinearGradient(context, shineGradient, CGPointMake(63.4, 42.51), CGPointMake(37.6, 30.49), 0);
    CGContextRestoreGState(context);
    
    ////// Mic Top Shine Inner Shadow
    CGRect micTopShineBorderRect = CGRectInset([micTopShinePath bounds], -insetHighlightBlurRadius, -insetHighlightBlurRadius);
    micTopShineBorderRect = CGRectOffset(micTopShineBorderRect, -insetHighlightOffset.width, -insetHighlightOffset.height);
    micTopShineBorderRect = CGRectInset(CGRectUnion(micTopShineBorderRect, [micTopShinePath bounds]), -1, -1);
    
    UIBezierPath * micTopShineNegativePath = [UIBezierPath bezierPathWithRect:micTopShineBorderRect];
    [micTopShineNegativePath appendPath:micTopShinePath];
    micTopShineNegativePath.usesEvenOddFillRule = YES;
    
    CGContextSaveGState(context);
    {
        CGFloat xOffset = insetHighlightOffset.width + round(micTopShineBorderRect.size.width);
        CGFloat yOffset = insetHighlightOffset.height;
        CGContextSetShadowWithColor(context,
                                    CGSizeMake(xOffset + copysign(0.1, xOffset), yOffset + copysign(0.1, yOffset)),
                                    insetHighlightBlurRadius,
                                    insetHighlight);
        
        [micTopShinePath addClip];
        CGAffineTransform transform = CGAffineTransformMakeTranslation(-round(micTopShineBorderRect.size.width), 0);
        [micTopShineNegativePath applyTransform:transform];
        [[UIColor grayColor] setFill];
        [micTopShineNegativePath fill];
    }
    CGContextRestoreGState(context);
    
    
    
    //// Cleanup
    CGGradientRelease(chromeRadialGradient);
    CGGradientRelease(flareGradient);
    CGGradientRelease(shineGradient);
    CGColorSpaceRelease(colorSpace);
}

@end
