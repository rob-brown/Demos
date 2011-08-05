//
//  RootViewController.m
//  RBFilePreviewerDemo
//
//  Created by Robert Brown on 8/5/11.
//  Copyright 2011 Robert Brown. All rights reserved.
//

#import "RootViewController.h"
#import "RBFilePreviewer.h"


@interface RootViewController ()

- (NSArray *)documentsAsURLs;

@end


@implementation RootViewController

@synthesize documents;

#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad {
    [super viewDidLoad];
	
    [[self navigationItem] setTitle:@"RBFilePreviewer"];
    
	[self setDocuments:[NSArray arrayWithObjects:@"HelloWorld.txt", @"Address.csv", @"WebPage.html", @"Icon.png", nil]];
}

- (NSArray *)documentsAsURLs {
    
    NSMutableArray * urls = [NSMutableArray array];
    
    for (NSString * file in [self documents]) {
        
        NSURL * url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:file ofType:nil]];
        [urls addObject:url];
    }
    
    return urls;
}

#pragma mark -
#pragma mark Table view data source

// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [documents count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString * CellIdentifier = @"Cell";
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
	// Configure the cell.
	cell.textLabel.text = [documents objectAtIndex:indexPath.row];
	
    return cell;
}


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    RBFilePreviewer * previewer = [[RBFilePreviewer alloc] initWithFiles:[self documentsAsURLs]];
    [previewer setCurrentPreviewItemIndex:indexPath.row];
    
    //    [previewer setShowActionButton:NO];  // You can choose to remove the action button. 
    
    // Use this code to present the previewer modally.
    UINavigationController * navController = [[UINavigationController alloc] initWithRootViewController:previewer];
    [self presentModalViewController:navController animated:YES];
    [navController release];
    
    // Use this code to push the view on the view stack.
//    [[self navigationController] pushViewController:previewer animated:YES];
    
    [previewer release];
}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    
	[documents release];
}


- (void)dealloc {
    [self setDocuments:nil];
    [super dealloc];
}


@end
