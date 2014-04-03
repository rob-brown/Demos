//
//  MVVMEntriesViewController.m
//  MVVMDemo
//
//  Created by Robert Brown on 3/25/14.
//  Copyright (c) 2014 Robert Brown. All rights reserved.
//

#import "MVVMEntriesViewController.h"
#import "MVVMEntriesViewModel.h"
#import "MVVMEntryCell.h"
#import "MVVMEntryDetailViewModel.h"
#import "MVVMEntryDetailViewController.h"


@interface MVVMEntriesViewController ()

@property (weak, nonatomic) IBOutlet UITableView * tableView;

@property (nonatomic, strong) MVVMEntriesViewModel * viewModel;

@end


@implementation MVVMEntriesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.viewModel = [[MVVMEntriesViewModel alloc] initWithCellCreator:^UITableViewCell *(UITableView * tableView, NSIndexPath * indexPath, id object) {
        return [MVVMEntryCell cellForTableView:tableView withEntry:object];
    }];
    
    self.tableView.dataSource = self.viewModel.dataSource;
    
    [self.viewModel.dataUpdatedSignal subscribeNext:^(id x) {
        [self.tableView reloadData];
    }];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow]
                                  animated:YES];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([[segue identifier] isEqualToString:@"ViewEntrySegue"]) {
        
        NSIndexPath * indexPath = [self.tableView indexPathForSelectedRow];
        MVVMEntryDetailViewModel * detailViewModel = [self.viewModel detailViewModelForIndexPath:indexPath];
        
        MVVMEntryDetailViewController * viewController = (MVVMEntryDetailViewController *)segue.destinationViewController;
        viewController.viewModel = detailViewModel;
    }
}

@end
