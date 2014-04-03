//
//  MVVMEditEntryViewController.m
//  MVVMDemo
//
//  Created by Robert Brown on 3/25/14.
//  Copyright (c) 2014 Robert Brown. All rights reserved.
//

#import "MVVMEditEntryViewController.h"
#import "MVVMEntryDetailViewModel.h"
#import "NSManagedObjectContext+MVVM.h"
#import "Entry.h"


@interface MVVMEditEntryViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UITextField * titleTextField;
@property (weak, nonatomic) IBOutlet UIImageView * imageView;
@property (weak, nonatomic) IBOutlet UITextView * textEntryView;
@property (weak, nonatomic) IBOutlet UIButton * imageButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem * saveButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem * cancelButton;
@property (nonatomic, strong) MVVMEntryDetailViewModel * viewModel;

@end


@implementation MVVMEditEntryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.viewModel) {
        self.navigationItem.title = @"Edit";
    }
    else {
        self.navigationItem.title = @"Create";
        self.viewModel = [MVVMEntryDetailViewModel new];
    }
    
    RAC(self, viewModel.title) = self.titleTextField.rac_textSignal;
    RAC(self, viewModel.text) = self.textEntryView.rac_textSignal;
    RAC(self, viewModel.image) = RACObserve(self, imageView.image);
    
    self.imageButton.rac_command = [self photoCommand];
    self.cancelButton.rac_command = [self cancelCommand];
    self.saveButton.rac_command = [self saveCommand];
}

- (RACCommand *)saveCommand {
    
    __weak typeof(self) weakSelf = self;
    
    return [[RACCommand alloc] initWithEnabled:self.viewModel.canSaveSignal
                                   signalBlock:^RACSignal *(id input) {
                                       
                                       return [[[[weakSelf.viewModel saveSignal] deliverOn:[RACScheduler mainThreadScheduler]] doError:^(NSError * error) {
                                           
                                           [[[UIAlertView alloc] initWithTitle:@"Error"
                                                                       message:@"An error occurred while saving. :("
                                                                      delegate:nil
                                                             cancelButtonTitle:@"OK"
                                                             otherButtonTitles:nil] show];
                                           NSLog(@"Error saving: %@", error);
                                           
                                       }] doNext:^(id x) {
                                           [weakSelf dismissViewControllerAnimated:YES completion:NULL];
                                       }];
                                   }];
}

- (RACCommand *)cancelCommand {
    
    __weak typeof(self) weakSelf = self;
    
    return [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        return [[RACSignal empty] doCompleted:^{
            [weakSelf dismissViewControllerAnimated:YES completion:NULL];
        }];
    }];
}

- (RACCommand *)photoCommand {
    
    __weak typeof(self) weakSelf = self;
    
    return [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        
        return [[RACSignal empty] doCompleted:^{
            
            // Presents the image picker.
            UIImagePickerController * imagePicker = [UIImagePickerController new];
            imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            
            // Sets up a delegate signal.
            RACSignal * pickerSignal = [weakSelf rac_signalForSelector:@selector(imagePickerController:didFinishPickingMediaWithInfo:)
                                                          fromProtocol:@protocol(UIImagePickerControllerDelegate)];
            RACSignal * imageSignal = [[pickerSignal map:^id(RACTuple * tuple) {
                
                // Extracts the image.
                // The delegate returns two arguments.
                // So the info dictionary is extracted from a tuple.
                NSDictionary * info = tuple.second;
                return info[UIImagePickerControllerOriginalImage];
                
            }] doNext:^(id x) {
                [weakSelf dismissViewControllerAnimated:YES completion:NULL];
            }];
            
            RAC(weakSelf, imageView.image) = imageSignal;
            
            // The delegate must be set after the signal is created.
            imagePicker.delegate = weakSelf;
            
            // Finally shows the image picker.
            [self presentViewController:imagePicker animated:YES completion:NULL];
        }];
    }];
}

@end
