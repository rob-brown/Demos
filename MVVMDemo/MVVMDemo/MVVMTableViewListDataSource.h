//
//  MVVMTableViewListDataSource.h
//  MVVMDemo
//
//  Created by Robert Brown on 3/25/14.
//  Copyright (c) 2014 Robert Brown. All rights reserved.
//

@import Foundation;
@import UIKit;


typedef UITableViewCell *(^MVVMCellCreatorBlock)(UITableView * tableView, NSIndexPath * indexPath, id object);


@interface MVVMTableViewListDataSource : NSObject <UITableViewDataSource>

- (id)initWithObjects:(NSArray *)objects cellCreator:(MVVMCellCreatorBlock)block;

@property (nonatomic, copy) NSArray * objects;

@property (nonatomic, strong, readonly) RACSignal * objectsUpdateSignal;

@end
