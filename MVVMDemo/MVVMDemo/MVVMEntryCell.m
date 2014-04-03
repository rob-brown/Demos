//
//  MVVMEntryCell.m
//  MVVMDemo
//
//  Created by Robert Brown on 3/25/14.
//  Copyright (c) 2014 Robert Brown. All rights reserved.
//

#import "MVVMEntryCell.h"
#import "Entry.h"


@interface MVVMEntryCell ()

@property (weak, nonatomic) IBOutlet UILabel * titleLabel;

@property (nonatomic, strong) Entry * entry;

@end


@implementation MVVMEntryCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    RAC(self, titleLabel.text) = [RACObserve(self, entry) map:^id(Entry * entry) {
        return entry.title;
    }];
}

+ (id)cellForTableView:(UITableView *)tableView withEntry:(Entry *)entry {
    
    NSParameterAssert(entry);
    
    MVVMEntryCell * cell = [super cellForTableView:tableView];
    cell.entry = entry;
    
    return cell;
}

@end
