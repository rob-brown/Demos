//
//  IDViewController.m
//  Siri Icon
//
//  Created by Robert Brown on 4/18/12.
//  Copyright (c) 2012 Robert Brown. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

#import "SIViewController.h"
#import "SiriView.h"


@interface SIViewController ()

@property (strong, nonatomic) IBOutlet SiriView * standardSiri;
@property (strong, nonatomic) IBOutlet SiriView * rotatedSiri;
@property (strong, nonatomic) IBOutlet SiriView * translatedSiri;
@property (strong, nonatomic) IBOutlet SiriView * scaledSiri;
@property (strong, nonatomic) IBOutlet SiriView * mixedSiri;

@end


@implementation SIViewController

@synthesize standardSiri   = _standardSiri;
@synthesize rotatedSiri    = _rotatedSiri;
@synthesize translatedSiri = _translatedSiri;
@synthesize scaledSiri     = _scaledSiri;
@synthesize mixedSiri      = _mixedSiri;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Transforms the Siri icons. 
    self.standardSiri.layer.borderWidth = 1.0f;
    self.standardSiri.aspectScale = 1.0f;
    
    self.rotatedSiri.layer.borderWidth = 1.0f;
    self.rotatedSiri.rotation = 90.0f;
    self.rotatedSiri.aspectScale = 1.0f;
    
    self.translatedSiri.layer.borderWidth = 1.0f;
    self.translatedSiri.translationX = 50.0f;
    self.translatedSiri.translationY = -50.0f;
    self.translatedSiri.aspectScale = 1.0f;
    
    self.scaledSiri.layer.borderWidth = 1.0f;
    self.scaledSiri.aspectScale = 2.0f;
    
    self.mixedSiri.layer.borderWidth = 1.0f;
    self.mixedSiri.aspectScale = 0.5f;
    self.mixedSiri.rotation = 180.0f;
    self.mixedSiri.translationX = 25.0f;
    self.mixedSiri.translationY = 25.0f;
}

- (void)viewDidUnload {
    [self setStandardSiri:nil];
    [self setRotatedSiri:nil];
    [self setTranslatedSiri:nil];
    [self setScaledSiri:nil];
    [self setMixedSiri:nil];
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
