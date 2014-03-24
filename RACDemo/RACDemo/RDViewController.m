//
//  RDViewController.m
//  RACDemo
//
//  Created by Robert Brown on 3/17/14.
//  Copyright (c) 2014 Robert Brown. All rights reserved.
//

#import <ReactiveCocoa/ReactiveCocoa.h>

#import "RDViewController.h"
#import "UIColor+Extras.h"


@interface RDViewController ()

@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UITextField *confirmPasswordField;
@property (weak, nonatomic) IBOutlet UIButton *submitButton;
@property (weak, nonatomic) IBOutlet UIImageView *usernameValidIcon;
@property (weak, nonatomic) IBOutlet UIImageView *passwordValidIcon;
@property (weak, nonatomic) IBOutlet UIImageView *confirmValidIcon;

@end


@implementation RDViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    RACSignal * usernameSignal = [self validateUsernameSignal:self.usernameField.rac_textSignal];
    RACSignal * passwordSignal = [self validatePasswordSignal:self.passwordField.rac_textSignal];
    RACSignal * confirmSignal = [self validatePasswordSignal:self.passwordField.rac_textSignal
                                       confirmPasswordSignal:self.confirmPasswordField.rac_textSignal];
    
    RAC(self, usernameField.textColor) = [self textColorSignalWithSignal:usernameSignal];
    RAC(self, usernameValidIcon.image) = [self validationImageWithSignal:usernameSignal];
    RAC(self, passwordField.textColor) = [self textColorSignalWithSignal:passwordSignal];
    RAC(self, passwordValidIcon.image) = [self validationImageWithSignal:passwordSignal];
    RAC(self, confirmPasswordField.textColor) = [self textColorSignalWithSignal:confirmSignal];
    RAC(self, confirmValidIcon.image) = [self validationImageWithSignal:confirmSignal];
    
    RACSignal * enabledSignal = [RACSignal combineLatest:@[usernameSignal, passwordSignal, confirmSignal]
                                                  reduce:^id(NSNumber * usernameValid, NSNumber * passwordValid, NSNumber * confirmValid) {
                                                      
                                                      // Checks that all fields are valid.
                                                      return @([usernameValid boolValue] && [passwordValid boolValue] && [confirmValid boolValue]);
                                                  }];
    
    self.submitButton.rac_command = [[RACCommand alloc] initWithEnabled:enabledSignal
                                                            signalBlock:^RACSignal *(id input) {
                                                                
                                                                // Returns a signal that completes immediately.
                                                                // When the signal completes, a message is logged.
                                                                return [[RACSignal empty] doCompleted:^{
                                                                    NSLog(@"Tapped submit button.");
                                                                }];
                                                            }];
}

- (RACSignal *)validationImageWithSignal:(RACSignal *)signal {
    
    NSParameterAssert(signal);
    
    // Maps `YES` and `NO` to their respective images.
    return [signal map:^id(NSNumber * value) {
        return ([value boolValue] ? [UIImage imageNamed:@"valid"] : [UIImage imageNamed:@"invalid"]);
    }];
}

- (RACSignal *)textColorSignalWithSignal:(RACSignal *)signal {
    
    NSParameterAssert(signal);
    
    // Maps `YES` and `NO` to their respective colors.
    return [signal map:^id(NSNumber * value) {
        return ([value boolValue] ? [UIColor inputValidColor] : [UIColor inputInvalidColor]);
    }];
}

- (RACSignal *)validateUsernameSignal:(RACSignal *)usernameSignal {
    
    NSParameterAssert(usernameSignal);
    
    return [[[usernameSignal flattenMap:^RACStream *(NSString * username) {
        return [self checkUsernameAvailabilitySignal:username];
    }] doError:^(NSError * error) {
        NSLog(@"Error validating username: %@", error);
    }] deliverOn:[RACScheduler mainThreadScheduler]];
}

- (RACSignal *)checkUsernameAvailabilitySignal:(NSString *)username {
    
    NSParameterAssert(username);
    
    NSString * urlString = [NSString stringWithFormat:@"http://www.reddit.com/api/username_available.json?user=%@", username];
    NSURL * url = [NSURL URLWithString:urlString];
    
    return [[self fetchJSONFromURL:url] map:^id(id json) {
        
        // Normally the result is just `true` or `false`.
        // If an error is returned, assumes the name is not valid.
        if ([json isKindOfClass:[NSNumber class]]) {
            return json;
        }
        else {
            return @NO;
        }
    }];
}

- (RACSignal *)fetchJSONFromURL:(NSURL *)url {
    
    NSParameterAssert(url);
    
    return [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        NSURLSession * session = [NSURLSession sharedSession];
        NSURLSessionDataTask * dataTask = [session dataTaskWithURL:url completionHandler:^(NSData * data, NSURLResponse * response, NSError * error) {
            
            if (data) {
                NSError * jsonError = nil;
                id json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&jsonError];
                
                if (json) {
                    [subscriber sendNext:json];
                }
                else {
                    [subscriber sendError:jsonError];
                }
            }
            else {
                [subscriber sendError:error];
            }
            
            [subscriber sendCompleted];
        }];
        
        [dataTask resume];
        
        return [RACDisposable disposableWithBlock:^{
            [dataTask cancel];
        }];
        
    }] doError:^(NSError * error) {
        NSLog(@"%@", error);
    }];
}

- (RACSignal *)validatePasswordSignal:(RACSignal *)passwordSignal {
    
    NSParameterAssert(passwordSignal);
    
    // Confirms the password is long enough.
    // Additional logic may be added, such as requiring numbers and/or symbols.
    return [RACSignal combineLatest:@[passwordSignal]
                             reduce:^id(NSString * password) {
                                 return @([password length] > 8u);
                             }];
}

- (RACSignal *)validatePasswordSignal:(RACSignal *)passwordSignal confirmPasswordSignal:(RACSignal *)confirmSignal {
    
    NSParameterAssert(passwordSignal && confirmSignal);
    
    // Confirms the two passwords are equal and non-empty.
    return [RACSignal combineLatest:@[passwordSignal, confirmSignal]
                             reduce:^id(NSString * password1, NSString * password2) {
                                 return @([password1 length] > 0u && [password1 isEqualToString:password2]);
                             }];
}

@end
