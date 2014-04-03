//
//  MVVMEntryDetailViewController.m
//  MVVMDemo
//
//  Created by Robert Brown on 3/25/14.
//  Copyright (c) 2014 Robert Brown. All rights reserved.
//

#import "MVVMEntryDetailViewController.h"
#import "MVVMEntryDetailViewModel.h"


@interface MVVMEntryDetailViewController ()

@property (weak, nonatomic) IBOutlet UILabel * titleLabel;
@property (weak, nonatomic) IBOutlet UITextView * textView;
@property (weak, nonatomic) IBOutlet UIImageView * imageView;

@end


@implementation MVVMEntryDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    RAC(self, titleLabel.text) = RACObserve(self, viewModel.title);
    RAC(self, textView.text) = RACObserve(self, viewModel.text);
    RAC(self, imageView.image) = RACObserve(self, viewModel.image);
}

@end
