//
//  Photo.m
//  MVVMDemo
//
//  Created by Robert Brown on 3/25/14.
//  Copyright (c) 2014 Robert Brown. All rights reserved.
//

#import "Photo.h"


@implementation Photo

@dynamic photo;
@dynamic entry;

- (void)setImage:(UIImage *)image {
    
    [self willChangeValueForKey:@"image"];
    
    if (image) {
        self.photo = UIImagePNGRepresentation(image);
    }
    else {
        self.photo = nil;
    }
    
    [self didChangeValueForKey:@"image"];
}

- (UIImage *)image {
    
    if (self.photo) {
        return [UIImage imageWithData:self.photo];
    }
    else {
        return nil;
    }
}

@end
