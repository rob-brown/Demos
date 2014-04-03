//
//  NSManagedObjectContext+MVVM.h
//  MVVMDemo
//
//  Created by Robert Brown on 3/25/14.
//  Copyright (c) 2014 Robert Brown. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface NSManagedObjectContext (MVVM)

- (RACSignal *)saveContextSignal;

@end
