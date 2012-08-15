//
//  RBViewController.m
//  AnimatedFlask
//
//  Created by Robert Brown on 7/24/12.
//  Copyright (c) 2012 Robert Brown. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

#import "RBViewController.h"
#import "RBAnimatedFlask.h"


@interface RBViewController ()

@property (nonatomic, strong) RBAnimatedFlask * flask;

@end


@implementation RBViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    const CGFloat kFlaskWidth = 100.0f;
    const CGFloat kFlaskHeight = 200.0f;
    
    CGSize parentSize = self.view.frame.size;
    CGRect frame = CGRectMake((parentSize.width - kFlaskWidth) / 2.0f,
                              (parentSize.height - kFlaskHeight) / 2.0f,
                              kFlaskWidth,
                              kFlaskHeight);
    
    RBAnimatedFlask * flask = [[RBAnimatedFlask alloc] initWithFrame:frame];
    [flask startAnimating];
    [self.view addSubview:flask];
    self.flask = flask;
    
//    flask.layer.borderColor = [[UIColor blackColor] CGColor];
//    flask.layer.borderWidth = 1.0f;
}

- (void)viewDidUnload {
    
    [self setFlask:nil];
    
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [[self flask] toggleAnimating];
}

@end
