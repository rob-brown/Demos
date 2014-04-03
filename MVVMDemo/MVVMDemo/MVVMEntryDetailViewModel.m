//
//  MVVMEntryDetailViewModel.m
//  MVVMDemo
//
//  Created by Robert Brown on 3/25/14.
//  Copyright (c) 2014 Robert Brown. All rights reserved.
//

#import <RBCoreDataStack/RBCoreDataStack.h>
#import <RBCoreDataStack/NSManagedObject+RBCoreDataStack.h>

#import "MVVMEntryDetailViewModel.h"
#import "NSManagedObjectContext+MVVM.h"
#import "Entry.h"
#import "Photo.h"


@interface MVVMEntryDetailViewModel ()

@property (nonatomic, strong, readwrite) RACSignal * canSaveSignal;

@property (nonatomic, strong) Entry * entry;

@property (nonatomic, strong) NSManagedObjectContext * context;

@end


@implementation MVVMEntryDetailViewModel

- (id)init {
    return [self initWithEntry:nil inContext:nil];
}

- (instancetype)initWithEntry:(Entry *)entry inContext:(NSManagedObjectContext *)context {
    
    if ((self = [super init])) {
        
        _canSaveSignal = [RACSignal combineLatest:@[RACObserve(self, title), RACObserve(self, text)]
                                           reduce:^id(NSString * title, NSString * text) {
                                               return @(title.length > 0u && text.length > 0u);
                                           }];
        _context = context ?: [[RBCoreDataStack defaultStack] createMainContext];
        _entry = entry ?: [Entry createInContext:_context];
        
        // Ensures the entry has a photo object.
        // This simplifies the signal code.
        _entry.photo = _entry.photo ?: [Photo createInContext:_context];
        
        // Creates a two-way binding with the model. The order here is important.
        // The properties on the right will set the initial values for properties on the left.
        RACChannelTo(self, title) = RACChannelTo(self, entry.title);
        RACChannelTo(self, text) = RACChannelTo(self, entry.text);
        RACChannelTo(self, image) = RACChannelTo(self, entry.photo.image);
    }
    
    return self;
}

- (RACSignal *)saveSignal {
    return [self.context saveContextSignal];
}

@end
