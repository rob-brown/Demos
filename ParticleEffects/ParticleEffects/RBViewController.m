//
//  RBViewController.m
//  ParticleEffects
//
//  Created by Robert Brown on 8/4/12.
//  Copyright (c) 2012 Robert Brown. All rights reserved.
//

#import "RBViewController.h"
#import "RBEmitterView.h"


@interface RBViewController ()

@property (nonatomic, weak) IBOutlet RBEmitterView * emitterView;

@end


@implementation RBViewController

@synthesize emitterView = _emitterView;


- (IBAction)handleTap:(UITapGestureRecognizer *)tapRecognizer {
    
    RBEmitterView * emitterView = [self emitterView];
    
    [emitterView setEmitterPosition:[tapRecognizer locationInView:emitterView]];
}

- (IBAction)handlePan:(UIPanGestureRecognizer *)panRecognizer {
    
    RBEmitterView * emitterView = [self emitterView];
    
    [emitterView setEmitterPosition:[panRecognizer locationInView:emitterView]];
}

- (IBAction)changedParticleType:(id)sender {
    
    RBEmitterView * emitterView = [self emitterView];
    
    [emitterView setType:[sender selectedSegmentIndex]];
}

- (IBAction)changedMode:(id)sender {
    
    RBEmitterView * emitterView = [self emitterView];
    
    [emitterView setMode:[sender selectedSegmentIndex]];
}

@end
