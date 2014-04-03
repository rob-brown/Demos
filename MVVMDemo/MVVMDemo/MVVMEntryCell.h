//
//  MVVMEntryCell.h
//  MVVMDemo
//
//  Created by Robert Brown on 3/25/14.
//  Copyright (c) 2014 Robert Brown. All rights reserved.
//

#import "RBSmartTableViewCell.h"

@class Entry;


@interface MVVMEntryCell : RBSmartTableViewCell

+ (id)cellForTableView:(UITableView *)tableView withEntry:(Entry *)entry;

@end
