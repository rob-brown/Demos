//
// GCDSampleiPhoneViewController.m
//
// Copyright (c) 2011 Robert Brown
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
//

#import <dispatch/dispatch.h>

#import "GCDSampleiPhoneViewController.h"


@implementation GCDSampleiPhoneViewController

@synthesize progress, randomLabel, randomButton, bigTaskButton;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	// The second parameter is unused, so just pass in null. This parameter may have future use.
	progressQueue = dispatch_queue_create("edu.byu.cocoaheads.gcdprogressqueue", NULL);
	
	// Our "big task" is "critically important," so we want it to run at high priority.
	dispatch_queue_t target = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
	dispatch_set_target_queue(progressQueue, target);
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}

- (IBAction) displayRandomNumber {
    
    // The random number display is just to demonstrate how multithreading, or 
    // lack thereof, affects other concurrent tasks.
	[randomLabel setText:[NSString stringWithFormat:@"%d", arc4random() % 100]];
}


- (IBAction) runBigTask {
	
	// __block keyword is not needed to modify "running" because it's in global memory space.
	static BOOL running = NO;
	
	// Only allows one block running at a time.  
	if(!running) {
		
		// This should be before the block starts since we don't know when the block will actually start running.
		running = YES;
		
        // This block is dispatched to the queue we created in the initializer;
        // however, this could be dispatched directly to a global queue using:
        // dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // Note that these two forms of dispatching have different behaviors.
		dispatch_async(progressQueue, ^{

			// UI updates must be done on the main thread.
			dispatch_async(dispatch_get_main_queue(), ^{
		
				[progress setProgress:0.0];
			
			});
		
            // Simulates a big task by running several smaller tasks.
			for (int i = 0; i < 100; i++) {
			
				// Simulates a smaller task with a delay. 
				[NSThread sleepForTimeInterval:0.1];
			
				// UI updates must be done on the main thread.
				dispatch_async(dispatch_get_main_queue(), ^{
			
					[progress setProgress:[progress progress] + 0.01];
							   
				});
			}
			
			// "Running" must be reset within the block since this block is run by dispatch_async.
			running = NO;
		});
	}
}




- (void)dealloc {
	[progress release];
	[randomLabel release];
	[randomButton release];
	[bigTaskButton release];
	
	// Notice that GCD objects are C objects and must be released with a C function call.
	dispatch_release(progressQueue);
    
    [super dealloc];
}

@end
