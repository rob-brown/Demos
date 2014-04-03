//
//  MVVMEntriesViewModel.m
//  MVVMDemo
//
//  Created by Robert Brown on 3/25/14.
//  Copyright (c) 2014 Robert Brown. All rights reserved.
//

#import <RBCoreDataStack/RBCoreDataStack.h>
#import <RBCoreDataStack/NSManagedObject+RBCoreDataStack.h>

#import "MVVMEntriesViewModel.h"
#import "NSManagedObject+MVVM.h"
#import "Entry.h"
#import "MVVMEntryDetailViewModel.h"


@interface MVVMEntriesViewModel ()

@property (nonatomic, strong, readwrite) MVVMTableViewListDataSource * dataSource;

@property (nonatomic, strong, readwrite) RACSignal * dataUpdatedSignal;

@property (nonatomic, strong) NSManagedObjectContext * context;

@end


@implementation MVVMEntriesViewModel

- (instancetype)initWithCellCreator:(MVVMCellCreatorBlock)block {
    
    if ((self = [super init])) {
        _dataSource = [[MVVMTableViewListDataSource alloc] initWithObjects:@[] cellCreator:block];
        _dataUpdatedSignal = _dataSource.objectsUpdateSignal;
        _context = [[RBCoreDataStack defaultStack] createMainContext];
        
        NSNotificationCenter * notificationCenter = [NSNotificationCenter defaultCenter];
        RACSignal * saveSignal = [notificationCenter rac_addObserverForName:NSManagedObjectContextDidSaveNotification
                                                                     object:nil];
        RACSignal * fetchSignal = [saveSignal flattenMap:^RACStream *(id value) {
            return [Entry fetchAllSignalInContext:self.context];
        }];
        
        RAC(self, dataSource.objects) = fetchSignal;
        
        // Forces the data to reload.
        // Signals are lazy, so the fetch must be made eager.
        [self reloadData];
    }
    
    return self;
}

- (void)reloadData {
    self.dataSource.objects = [Entry fetchAllInContext:self.context];
}

- (MVVMEntryDetailViewModel *)detailViewModelForIndexPath:(NSIndexPath *)indexPath {
    
    NSParameterAssert(indexPath);
    
    Entry * entry = self.dataSource.objects[indexPath.row];
    
    return [[MVVMEntryDetailViewModel alloc] initWithEntry:entry inContext:self.context];
}

@end
