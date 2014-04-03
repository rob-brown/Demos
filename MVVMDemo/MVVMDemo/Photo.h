//
//  Photo.h
//  MVVMDemo
//
//  Created by Robert Brown on 3/25/14.
//  Copyright (c) 2014 Robert Brown. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Photo : NSManagedObject

@property (nonatomic, retain) NSData * photo;
@property (nonatomic, retain) NSManagedObject *entry;

/// Handles the mapping from UIImage to NSData and vice versa.
@property (nonatomic, strong) UIImage * image;

@end
