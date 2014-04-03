//
//  NSManagedObjectContext+MVVM.m
//  MVVMDemo
//
//  Created by Robert Brown on 3/25/14.
//  Copyright (c) 2014 Robert Brown. All rights reserved.
//

#import "NSManagedObjectContext+MVVM.h"

@implementation NSManagedObjectContext (MVVM)

- (RACSignal *)saveContextSignal {
    
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        [self performBlock:^{
            
            NSError * error = nil;
            BOOL success = [self save:&error];
            
            if (success) {
                [subscriber sendNext:self];
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
