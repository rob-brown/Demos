//
//  MVVMTableViewListDataSource.m
//  MVVMDemo
//
//  Created by Robert Brown on 3/25/14.
//  Copyright (c) 2014 Robert Brown. All rights reserved.
//

#import "MVVMTableViewListDataSource.h"


@interface MVVMTableViewListDataSource ()

@property (nonatomic, strong, readwrite) RACSignal * objectsUpdateSignal;

@property (nonatomic, copy) MVVMCellCreatorBlock cellCreator;

@end


@implementation MVVMTableViewListDataSource

- (id)initWithObjects:(NSArray *)objects cellCreator:(MVVMCellCreatorBlock)block {
    
    NSParameterAssert(block);
    
    if ((self = [super init])) {
        _cellCreator = block;
        _objects = objects ?: @[];
        _objectsUpdateSignal = RACObserve(self, objects);
    }
    
    return self;
}


#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.objects count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSAssert(self.cellCreator, @"No cell creator.");
    
    return self.cellCreator(tableView, indexPath, self.objects[indexPath.row]);
}

@end
