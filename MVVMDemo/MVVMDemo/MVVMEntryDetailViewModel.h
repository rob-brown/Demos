//
//  MVVMEntryDetailViewModel.h
//  MVVMDemo
//
//  Created by Robert Brown on 3/25/14.
//  Copyright (c) 2014 Robert Brown. All rights reserved.
//

#import "RVMViewModel.h"

@class Entry;


@interface MVVMEntryDetailViewModel : RVMViewModel

@property (nonatomic, copy) NSString * title;

@property (nonatomic, copy) NSString * text;

@property (nonatomic, strong) UIImage * image;

@property (nonatomic, strong, readonly) RACSignal * canSaveSignal;

- (instancetype)initWithEntry:(Entry *)entry inContext:(NSManagedObjectContext *)context;

- (RACSignal *)saveSignal;

@end
