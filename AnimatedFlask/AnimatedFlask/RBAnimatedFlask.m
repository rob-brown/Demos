//
//  RBAnimatedFlask.m
//  AnimatedFlask
//
//  Created by Robert Brown on 7/24/12.
//  Copyright (c) 2012 Robert Brown. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

#import "RBAnimatedFlask.h"
#import "UIImage+BBlock.h"


const CGFloat kBubbleFrequency = 4.0f;
const NSUInteger kBubbleStartXVariance = 10u;
const NSUInteger kBubbleEndXVariance = 30u;


@interface RBAnimatedFlask ()

@property (nonatomic, strong) NSMutableArray * bubbleArray;

@property (nonatomic, assign) CGPoint spawnPoint;

@property (nonatomic, assign, getter=isAnimating, readwrite) BOOL animating;

@end


@implementation RBAnimatedFlask


#pragma mark - View life time

- (id)initWithFrame:(CGRect)frame {
    
    if ((self = [super initWithFrame:frame])) {
        
        [self sharedSetup];
    }
    
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self sharedSetup];
}

- (void)sharedSetup {
    [self setAnimating:NO];
    [self setBubbleArray:[NSMutableArray array]];
    [self setupSubviews];
}

- (void)setupSubviews {
    
    UIImageView * flaskImage = [[UIImageView alloc] initWithImage:[self flaskImage]];
    
    CGRect parentFrame = [self frame];
    CGRect frame = [flaskImage frame];
    
    frame.origin.x = (parentFrame.size.width - frame.size.width) / 2.0f;
    frame.origin.y = parentFrame.size.height - frame.size.height - 10.0f;
    
    [flaskImage setFrame:frame];
    
    self.spawnPoint = CGPointMake(parentFrame.size.width / 2.0f,
                                  parentFrame.size.height - frame.size.height - 10.0f);
    
    [self addSubview:flaskImage];
}


#pragma mark - Helper methods

- (CAAnimation *)curveAnimationFromPoint:(CGPoint)fromPoint toPoint:(CGPoint)toPoint {
    
    CAKeyframeAnimation * moveAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    moveAnimation.calculationMode = kCAAnimationLinear;
    moveAnimation.fillMode = kCAFillModeForwards;
    moveAnimation.removedOnCompletion = NO;
    
    CGMutablePathRef curvedPath = CGPathCreateMutable();
    CGPathMoveToPoint(curvedPath, NULL, fromPoint.x, fromPoint.y);
    CGPathAddCurveToPoint(curvedPath,
                          NULL,
                          fromPoint.x, toPoint.y,
                          fromPoint.x, toPoint.y,
                          toPoint.x, toPoint.y);
    moveAnimation.path = curvedPath;
    CGPathRelease(curvedPath);
    
    return moveAnimation;
}

- (CAAnimation *)scaleAnimation {
    
    CAKeyframeAnimation * scaleAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.values   = @[@0.0f, @1.0f, @1.0f, @0.0f];
    scaleAnimation.keyTimes = @[@0.0f, @0.1f, @0.6f, @1.0f];
    
    return scaleAnimation;
}

- (CAAnimation *)bubbleAnimationFromPoint:(CGPoint)fromPoint toPoint:(CGPoint)toPoint {
    
    CAAnimationGroup * groupAnimation = [CAAnimationGroup animation];
    groupAnimation.animations = @[[self curveAnimationFromPoint:fromPoint toPoint:toPoint], [self scaleAnimation]];
    groupAnimation.duration = 0.6f;
    
    return groupAnimation;
}

- (CGFloat)randomOffsetWithVariance:(NSUInteger)variance {
    
    NSInteger randomNumber = (CGFloat)((arc4random() % variance));
    CGFloat offset = (CGFloat)randomNumber;
    offset *= (randomNumber % 2 == 0 ? 1.0f : -1.0f);
    
    return offset;
}


#pragma mark - Public methods

- (void)startAnimating {
    
    if ([self isAnimating])
        return;
    
    [self setAnimating:YES];
    
    [self animate];
}

- (void)stopAnimating {
    
    [self setAnimating:NO];
}

- (void)toggleAnimating {
    
    if ([self isAnimating])
        [self stopAnimating];
    else
        [self startAnimating];
}


#pragma mark - Animation methods

- (void)animate {
    
    UIImageView * bubbleImage = [[UIImageView alloc] initWithImage:[self bubbleImage]];
    
    [self addSubview:bubbleImage];
    
    // Generates a couple random numbers to make the animation more realistic.
    CGFloat startXOffset = [self randomOffsetWithVariance:kBubbleEndXVariance];
    CGFloat endXOffset = [self randomOffsetWithVariance:kBubbleStartXVariance];
    
    // Applies the animation.
    CGPoint spawnPoint = self.spawnPoint;
    CAAnimation * bubbleAnimation = [self bubbleAnimationFromPoint:CGPointMake(spawnPoint.x + endXOffset, spawnPoint.y)
                                                           toPoint:CGPointMake(spawnPoint.x + startXOffset, 20.0f)];
    bubbleAnimation.delegate = self;
    
    [[bubbleImage layer] addAnimation:bubbleAnimation forKey:@"bubble"];
    [[self bubbleArray] insertObject:bubbleImage atIndex:0];
    
    if ([self isAnimating]) {
        
        // Adds another bubble.
        NSTimeInterval delayInSeconds = 1.0 / kBubbleFrequency;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            
            [self animate];
        });
    }
}


#pragma mark - Drawing methods

- (UIImage *)flaskImage {
    
    return [UIImage imageForSize:CGSizeMake(72.0f, 79.0f)
                withDrawingBlock:
            ^{
                //// General Declarations
                CGContextRef context = UIGraphicsGetCurrentContext();
                
                //// Shadow Declarations
                UIColor* flaskShadow = [UIColor darkGrayColor];
                CGSize flaskShadowOffset = CGSizeMake(3, 3);
                CGFloat flaskShadowBlurRadius = 5;
                
                //// Flask Drawing
                UIBezierPath* flaskPath = [UIBezierPath bezierPath];
                [flaskPath moveToPoint: CGPointMake(15.93, 11.53)];
                [flaskPath addLineToPoint: CGPointMake(22, 11.5)];
                [flaskPath addLineToPoint: CGPointMake(23.7, 12.15)];
                [flaskPath addLineToPoint: CGPointMake(24, 13.5)];
                [flaskPath addLineToPoint: CGPointMake(24, 32.3)];
                [flaskPath addLineToPoint: CGPointMake(2.5, 65.5)];
                [flaskPath addLineToPoint: CGPointMake(0.54, 70.92)];
                [flaskPath addLineToPoint: CGPointMake(2.04, 76.13)];
                [flaskPath addLineToPoint: CGPointMake(7.72, 78)];
                [flaskPath addLineToPoint: CGPointMake(15, 78.5)];
                [flaskPath addLineToPoint: CGPointMake(58.5, 78.5)];
                [flaskPath addLineToPoint: CGPointMake(65.28, 78)];
                [flaskPath addLineToPoint: CGPointMake(70.05, 76.13)];
                [flaskPath addLineToPoint: CGPointMake(71.5, 71.42)];
                [flaskPath addLineToPoint: CGPointMake(69.5, 65.5)];
                [flaskPath addLineToPoint: CGPointMake(48.35, 32.3)];
                [flaskPath addLineToPoint: CGPointMake(48, 13.5)];
                [flaskPath addLineToPoint: CGPointMake(48.85, 12.15)];
                [flaskPath addLineToPoint: CGPointMake(50, 11.5)];
                [flaskPath addLineToPoint: CGPointMake(56.59, 11.65)];
                [flaskPath addLineToPoint: CGPointMake(56.59, 0.41)];
                [flaskPath addLineToPoint: CGPointMake(15.93, 0.41)];
                [flaskPath addLineToPoint: CGPointMake(15.93, 11.53)];
                [flaskPath closePath];
                flaskPath.lineCapStyle = kCGLineCapRound;
                flaskPath.lineJoinStyle = kCGLineJoinRound;
                [[UIColor lightGrayColor] setFill];
                [flaskPath fill];
                
                ////// Flask Inner Shadow
                CGRect flaskBorderRect = CGRectInset([flaskPath bounds], -flaskShadowBlurRadius, -flaskShadowBlurRadius);
                flaskBorderRect = CGRectOffset(flaskBorderRect, -flaskShadowOffset.width, -flaskShadowOffset.height);
                flaskBorderRect = CGRectInset(CGRectUnion(flaskBorderRect, [flaskPath bounds]), -1, -1);
                
                UIBezierPath* flaskNegativePath = [UIBezierPath bezierPathWithRect: flaskBorderRect];
                [flaskNegativePath appendPath: flaskPath];
                flaskNegativePath.usesEvenOddFillRule = YES;
                
                CGContextSaveGState(context);
                {
                    CGFloat xOffset = flaskShadowOffset.width + round(flaskBorderRect.size.width);
                    CGFloat yOffset = flaskShadowOffset.height;
                    CGContextSetShadowWithColor(context,
                                                CGSizeMake(xOffset + copysign(0.1, xOffset), yOffset + copysign(0.1, yOffset)),
                                                flaskShadowBlurRadius,
                                                flaskShadow.CGColor);
                    
                    [flaskPath addClip];
                    CGAffineTransform transform = CGAffineTransformMakeTranslation(-round(flaskBorderRect.size.width), 0);
                    [flaskNegativePath applyTransform: transform];
                    [[UIColor grayColor] setFill];
                    [flaskNegativePath fill];
                }
                CGContextRestoreGState(context);
                
                [[UIColor darkGrayColor] setStroke];
                flaskPath.lineWidth = 0.5;
                [flaskPath stroke];
            }];
}

- (UIImage *)bubbleImage {
    
    return [UIImage imageForSize:CGSizeMake(29.0f, 29.0f)
                withDrawingBlock:
            ^{
                //// General Declarations
                CGContextRef context = UIGraphicsGetCurrentContext();
                
                //// Shadow Declarations
                UIColor* bubbleShadow = [UIColor darkGrayColor];
                CGSize bubbleShadowOffset = CGSizeMake(3, 3);
                CGFloat bubbleShadowBlurRadius = 4;
                
                //// Bubble Drawing
                UIBezierPath* bubblePath = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(0.5, 0, 28, 28)];
                [[UIColor lightGrayColor] setFill];
                [bubblePath fill];
                
                ////// Bubble Inner Shadow
                CGRect bubbleBorderRect = CGRectInset([bubblePath bounds], -bubbleShadowBlurRadius, -bubbleShadowBlurRadius);
                bubbleBorderRect = CGRectOffset(bubbleBorderRect, -bubbleShadowOffset.width, -bubbleShadowOffset.height);
                bubbleBorderRect = CGRectInset(CGRectUnion(bubbleBorderRect, [bubblePath bounds]), -1, -1);
                
                UIBezierPath* bubbleNegativePath = [UIBezierPath bezierPathWithRect: bubbleBorderRect];
                [bubbleNegativePath appendPath: bubblePath];
                bubbleNegativePath.usesEvenOddFillRule = YES;
                
                CGContextSaveGState(context);
                {
                    CGFloat xOffset = bubbleShadowOffset.width + round(bubbleBorderRect.size.width);
                    CGFloat yOffset = bubbleShadowOffset.height;
                    CGContextSetShadowWithColor(context,
                                                CGSizeMake(xOffset + copysign(0.1, xOffset), yOffset + copysign(0.1, yOffset)),
                                                bubbleShadowBlurRadius,
                                                bubbleShadow.CGColor);
                    
                    [bubblePath addClip];
                    CGAffineTransform transform = CGAffineTransformMakeTranslation(-round(bubbleBorderRect.size.width), 0);
                    [bubbleNegativePath applyTransform: transform];
                    [[UIColor grayColor] setFill];
                    [bubbleNegativePath fill];
                }
                CGContextRestoreGState(context);
                
                [[UIColor darkGrayColor] setStroke];
                bubblePath.lineWidth = 0.5;
                [bubblePath stroke];
            }];
}


#pragma mark - CAAnimation delegate methods

- (void)animationDidStop:(CAAnimation *)animation finished:(BOOL)flag {
    
    UIImageView * bubbleView = [[self bubbleArray] lastObject];
    [bubbleView removeFromSuperview];
    [[self bubbleArray] removeLastObject];
}

@end
