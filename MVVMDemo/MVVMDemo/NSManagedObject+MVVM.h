//
//  NSManagedObject+MVVM.h
//  MVVMDemo
//
//  Created by Robert Brown on 3/25/14.
//  Copyright (c) 2014 Robert Brown. All rights reserved.
//

@import CoreData;

@interface NSManagedObject (MVVM)

+ (RACSignal *)fetchAllSignalInContext:(NSManagedObjectContext *)context;

+ (RACSignal *)fetchAllSignalWithPredicate:(NSPredicate *)predicate inContext:(NSManagedObjectContext *)context;

@end
