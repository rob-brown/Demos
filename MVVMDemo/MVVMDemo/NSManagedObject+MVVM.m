//
//  NSManagedObject+MVVM.m
//  MVVMDemo
//
//  Created by Robert Brown on 3/25/14.
//  Copyright (c) 2014 Robert Brown. All rights reserved.
//

#import "NSManagedObject+MVVM.h"
#import <RBCoreDataStack/NSManagedObject+RBCoreDataStack.h>

@implementation NSManagedObject (MVVM)

+ (RACSignal *)fetchAllSignalInContext:(NSManagedObjectContext *)context {
    return [self fetchAllSignalWithPredicate:nil inContext:context];
}

+ (RACSignal *)fetchAllSignalWithPredicate:(NSPredicate *)predicate inContext:(NSManagedObjectContext *)context {
    
    NSParameterAssert(context);
    
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        NSFetchRequest * request = [self fetchRequest];
        request.predicate = predicate;
        
        [context performBlock:^{
            
            NSError * error = nil;
            NSArray * results = [context executeFetchRequest:request error:&error];
            
            if (results) {
                [subscriber sendNext:results];
            }
            else {
                [subscriber sendError:error];
            }
            
            [subscriber sendCompleted];
        }];
        
        return [RACDisposable disposableWithBlock:^{}];
    }];
}

@end
