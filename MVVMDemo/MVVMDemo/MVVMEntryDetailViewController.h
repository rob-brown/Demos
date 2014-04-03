//
//  MVVMEntryDetailViewController.h
//  MVVMDemo
//
//  Created by Robert Brown on 3/25/14.
//  Copyright (c) 2014 Robert Brown. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MVVMEntryDetailViewModel;


@interface MVVMEntryDetailViewController : UIViewController

@property (nonatomic, strong) MVVMEntryDetailViewModel * viewModel;

@end
