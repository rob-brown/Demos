//
//  MVVMEntriesViewModel.h
//  MVVMDemo
//
//  Created by Robert Brown on 3/25/14.
//  Copyright (c) 2014 Robert Brown. All rights reserved.
//

#import "RVMViewModel.h"
#import "MVVMTableViewListDataSource.h"

@class MVVMEntryDetailViewModel;


@interface MVVMEntriesViewModel : RVMViewModel

@property (nonatomic, strong, readonly) MVVMTableViewListDataSource * dataSource;

@property (nonatomic, strong, readonly) RACSignal * dataUpdatedSignal;

- (instancetype)initWithCellCreator:(MVVMCellCreatorBlock)block;

- (MVVMEntryDetailViewModel *)detailViewModelForIndexPath:(NSIndexPath *)indexPath;

@end
