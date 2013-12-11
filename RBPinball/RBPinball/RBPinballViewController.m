//
//  RBPinballViewController.m
//  RBPinball
//
//  Created by Robert Brown on 11/23/13.
//  Copyright (c) 2013 RB. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

#import "RBPinballViewController.h"
#import "UIImage+BBlock.h"


const CGFloat flipperXOffset = 54.f;
const CGFloat flipperYOffset = 94.f;
const CGFloat flipperLength = 100.f;
const CGFloat flipperThickness = 20.f;


@interface RBPinballViewController () <UICollisionBehaviorDelegate, UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *ledgeView;

@property (nonatomic, strong) UIDynamicAnimator * animator;

@property (nonatomic, strong) UIView * leftFlipper;

@property (nonatomic, strong) UIView * rightFlipper;

@property (nonatomic, strong) UISnapBehavior * leftFlipperSnap;

@property (nonatomic, strong) UISnapBehavior * rightFlipperSnap;

@property (nonatomic, strong) UIAlertView * alert;

@end


@implementation RBPinballViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.ledgeView.image = [self ledgeImage];
    [self setupDynamics];
}

- (void)setupDynamics {
    
    const CGFloat width = CGRectGetWidth(self.view.frame);
    const CGFloat height = CGRectGetHeight(self.view.frame);
    
    UIDynamicAnimator * animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    
    // Creates the views.
    UIView * bumper1 = [self createBumperWithRect:CGRectMake(width / 3.f - 30.f, 100.f, 30.f, 30.f)];
    UIView * bumper2 = [self createBumperWithRect:CGRectMake(width * 2.f / 3.f, 100.f, 30.f, 30.f)];
    UIView * bumper3 = [self createBumperWithRect:CGRectMake(width / 2.f - 15.f, 150.f, 30.f, 30.f)];
    UIView * ball = [self createBall];
    self.leftFlipper = [self createLeftFlipper];
    self.rightFlipper = [self createRightFlipper];
    NSArray * views = @[self.leftFlipper, self.rightFlipper, ball, bumper1, bumper2, bumper3];
    NSArray * bumpers = @[bumper1, bumper2, bumper3];
    
    // Adds the views to the hierarchy.
    [views enumerateObjectsUsingBlock:^(UIView * view, NSUInteger idx, BOOL * stop) {
        [self.view insertSubview:view atIndex:0];
    }];
    
    // Add the bumper behavior.
    [bumpers enumerateObjectsUsingBlock:^(UIView * bumper, NSUInteger idx, BOOL * stop) {
        CGRect frame = bumper.frame;
        UIAttachmentBehavior * attachment = [[UIAttachmentBehavior alloc] initWithItem:bumper
                                                                      offsetFromCenter:UIOffsetZero
                                                                      attachedToAnchor:CGPointMake(CGRectGetMidX(frame),
                                                                                                   CGRectGetMidY(frame))];
        attachment.length = 2.f;
        attachment.damping = 10.f;
        
        [animator addBehavior:attachment];
    }];
    
    // Demonstrates some dynamic behaviors.
    UIDynamicItemBehavior * dynamics = [[UIDynamicItemBehavior alloc] initWithItems:@[bumper2]];
    [dynamics addAngularVelocity:20.f forItem:bumper2];
    [animator addBehavior:dynamics];
    dynamics = [[UIDynamicItemBehavior alloc] initWithItems:@[bumper3]];
    dynamics.allowsRotation = NO;
    [dynamics addLinearVelocity:CGPointMake(0.f, 100.f) forItem:bumper3];
    [animator addBehavior:dynamics];
    
    // Creates some boundaries.
    UICollisionBehavior * collisionBoundaries = [[UICollisionBehavior alloc] initWithItems:views];
    [collisionBoundaries addBoundaryWithIdentifier:@"LeftLedge" forPath:[self leftLedgePath]];
    [collisionBoundaries addBoundaryWithIdentifier:@"RightLedge" forPath:[self rightLedgePath]];
    [collisionBoundaries addBoundaryWithIdentifier:@"Wall" forPath:[self wallPath]];
    [collisionBoundaries addBoundaryWithIdentifier:@"GameOver" forPath:[self outOfBoundsPath]];
    collisionBoundaries.collisionDelegate = self;
    [animator addBehavior:collisionBoundaries];
    
    // Adds gravity.
    UIGravityBehavior * gravity = [[UIGravityBehavior alloc] initWithItems:@[ball]];
    [animator addBehavior:gravity];
    
    // Adds pivot points for the flippers.
    UIAttachmentBehavior * leftFlipperAttachment = [[UIAttachmentBehavior alloc] initWithItem:self.leftFlipper
                                                                             offsetFromCenter:UIOffsetMake(-flipperLength / 2.f, 0.f)
                                                                             attachedToAnchor:CGPointMake(flipperXOffset, height - flipperYOffset)];
    UIAttachmentBehavior * rightFlipperAttachment = [[UIAttachmentBehavior alloc] initWithItem:self.rightFlipper
                                                                              offsetFromCenter:UIOffsetMake(flipperLength / 2.f, 0.f)
                                                                              attachedToAnchor:CGPointMake(width - flipperXOffset, height - flipperYOffset)];
    [animator addBehavior:leftFlipperAttachment];
    [animator addBehavior:rightFlipperAttachment];
    self.animator = animator;
    
    // Starts the flippers in untriggered positions.
    [self triggerLeftFlipper:NO];
    [self triggerRightFlipper:NO];
}


#pragma mark - Flipper actions

- (void)triggerLeftFlipper:(BOOL)trigger {
    
    const CGFloat height = CGRectGetHeight(self.view.frame);
    
    if (self.leftFlipperSnap)
        [self.animator removeBehavior:self.leftFlipperSnap];
    
    if (trigger) {
        UISnapBehavior * snap = [[UISnapBehavior alloc] initWithItem:self.leftFlipper
                                                         snapToPoint:CGPointMake(153.f, height - 104.f)];
        [self.animator addBehavior:snap];
        self.leftFlipperSnap = snap;
    }
    else {
        UISnapBehavior * snap = [[UISnapBehavior alloc] initWithItem:self.leftFlipper
                                                         snapToPoint:CGPointMake(130.f, height - 30.f)];
        [self.animator addBehavior:snap];
        self.leftFlipperSnap = snap;
    }
}

- (void)triggerRightFlipper:(BOOL)trigger {
    
    const CGFloat height = CGRectGetHeight(self.view.frame);
    const CGFloat width = CGRectGetWidth(self.view.frame);
    
    if (self.rightFlipperSnap)
        [self.animator removeBehavior:self.rightFlipperSnap];
    
    if (trigger) {
        UISnapBehavior * snap = [[UISnapBehavior alloc] initWithItem:self.rightFlipper
                                                         snapToPoint:CGPointMake(width - 153.f, height - 104.f)];
        [self.animator addBehavior:snap];
        self.rightFlipperSnap = snap;
    }
    else {
        UISnapBehavior * snap = [[UISnapBehavior alloc] initWithItem:self.rightFlipper
                                                         snapToPoint:CGPointMake(width - 130.f, height - 30.f)];
        [self.animator addBehavior:snap];
        self.rightFlipperSnap = snap;
    }
}


#pragma mark - Dynamic views

- (UIView *)createLeftFlipper {
    
    const CGFloat height = CGRectGetHeight(self.view.frame);
    const CGRect rect = CGRectMake(flipperXOffset,
                                   height - flipperYOffset - 10.f,
                                   flipperLength,
                                   flipperThickness);
    return [self createFlipperWithRect:rect];
}

- (UIView *)createRightFlipper {
    
    const CGFloat height = CGRectGetHeight(self.view.frame);
    const CGFloat width = CGRectGetWidth(self.view.frame);
    const CGRect rect = CGRectMake(width - flipperXOffset - flipperLength,
                                   height - flipperYOffset - 10.f,
                                   flipperLength,
                                   flipperThickness);
    return [self createFlipperWithRect:rect];
}

- (UIView *)createFlipperWithRect:(CGRect)rect {
    
    UIView * flipper = [[UIView alloc] initWithFrame:rect];
    flipper.backgroundColor = [UIColor redColor];
    CALayer * layer = flipper.layer;
    layer.borderColor = CGColorRetain([[UIColor blackColor] CGColor]);
    layer.borderWidth = 2.f;
    
    return flipper;
}

- (UIView *)createBumperWithRect:(CGRect)rect {
    
    UIView * flipper = [[UIView alloc] initWithFrame:rect];
    flipper.backgroundColor = [UIColor blueColor];
    flipper.transform = CGAffineTransformMakeRotation(M_PI_4);
    CALayer * layer = flipper.layer;
    layer.borderColor = CGColorRetain([[UIColor blackColor] CGColor]);
    layer.borderWidth = 2.f;
    
    return flipper;
}

- (UIView *)createBall {
    
    UIView * ball = [[UIView alloc] initWithFrame:CGRectMake(10.f, 10.f, 20.f, 20.f)];
    ball.backgroundColor = [UIColor greenColor];
    CALayer * layer = ball.layer;
    layer.borderColor = CGColorRetain([[UIColor blackColor] CGColor]);
    layer.borderWidth = 2.f;
    
    return ball;
}


#pragma mark - Paths

- (UIBezierPath *)leftLedgePath {
    
    CGFloat height = CGRectGetHeight(self.view.frame);
    
    UIBezierPath * path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0.f, height)];
    [path addLineToPoint:CGPointMake(0.f, height - 160.f)];
    [path addLineToPoint:CGPointMake(45.f, height - 115.f)];
    [path addLineToPoint:CGPointMake(45.f, height)];
    [path closePath];
    
    return path;
}

- (UIBezierPath *)rightLedgePath {
    
    CGFloat height = CGRectGetHeight(self.view.frame);
    CGFloat width = CGRectGetWidth(self.view.frame);
    
    UIBezierPath * path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(width, height)];
    [path addLineToPoint:CGPointMake(width - 45.f, height)];
    [path addLineToPoint:CGPointMake(width - 45.f, height - 115.f)];
    [path addLineToPoint:CGPointMake(width, height - 160.f)];
    [path closePath];
    
    return path;
}

- (UIBezierPath *)wallPath {
    
    CGFloat height = CGRectGetHeight(self.view.frame);
    CGFloat width = CGRectGetWidth(self.view.frame);
    
    UIBezierPath * path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0.f, height * 2.f)];
    [path addLineToPoint:CGPointMake(0.f, 0.f)];
    [path addLineToPoint:CGPointMake(width, 0.f)];
    [path addLineToPoint:CGPointMake(width, height * 2.f)];
    
    return path;
}

- (UIBezierPath *)outOfBoundsPath {
    
    CGFloat height = CGRectGetHeight(self.view.frame);
    CGFloat width = CGRectGetWidth(self.view.frame);
    
    UIBezierPath * path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0.f, height + 50.f)];
    [path addLineToPoint:CGPointMake(width, height + 50.f)];
    [path addLineToPoint:CGPointMake(0.f, height + 50.f)];
    [path closePath];
    
    return path;
}


#pragma mark - IBActions

- (IBAction)leftTriggerTouchUpInside:(id)sender {
    [self triggerLeftFlipper:NO];
}

- (IBAction)leftTriggerTouchUpOutside:(id)sender {
    [self triggerLeftFlipper:NO];
}

- (IBAction)leftTriggerTouchDown:(id)sender {
    [self triggerLeftFlipper:YES];
}

- (IBAction)rightTriggerTouchUpInside:(id)sender {
    [self triggerRightFlipper:NO];
}

- (IBAction)rightTriggerTouchUpOutside:(id)sender {
    [self triggerRightFlipper:NO];
}

- (IBAction)rightTriggerTouchDown:(id)sender {
    [self triggerRightFlipper:YES];
}


#pragma mark - Drawing methods

- (UIImage *)ledgeImage {
    
    return [UIImage imageForSize:self.view.frame.size withDrawingBlock:^{
        
        [[UIColor redColor] setFill];
        [[UIColor blackColor] setStroke];
        
        UIBezierPath * path = [self rightLedgePath];
        path.lineWidth = 2.f;
        [path fill];
        [path stroke];
        
        path = [self leftLedgePath];
        path.lineWidth = 2.f;
        [path fill];
        [path stroke];
    }];
}


#pragma mark - UICollisionBehaviorDelegate

- (void)collisionBehavior:(UICollisionBehavior *)behavior beganContactForItem:(id<UIDynamicItem>)item withBoundaryIdentifier:(id<NSCopying>)identifier atPoint:(CGPoint)p {
    
    NSString * boundaryID = (NSString *)identifier;
    
    if ([boundaryID isEqualToString:@"GameOver"]) {
        
        if (self.alert == nil) {
            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Game Over"
                                                             message:@""
                                                            delegate:self
                                                   cancelButtonTitle:nil
                                                   otherButtonTitles:@"New Game", nil];
            [alert show];
            self.alert = alert;
        }
    }
}


#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    UINavigationController * navController = self.navigationController;
    [navController popViewControllerAnimated:NO];
    
    UIStoryboard * storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    RBPinballViewController * pinballVC = [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([self class])];
    
    [navController pushViewController:pinballVC animated:NO];
}

@end
