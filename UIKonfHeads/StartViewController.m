//
//  ViewController.m
//  UIKonfHeads
//
//  Created by Oliver Michalak on 23.04.13.
//  Copyright (c) 2013 Oliver Michalak. All rights reserved.
//

#import "StartViewController.h"
#import "WebViewController.h"
#import "IntroViewController.h"
#import "NSString+MD5.h"
#import "AFNetworking.h"

@interface StartViewController ()
@property (strong, nonatomic) NSOperationQueue *queue;
@end

@implementation StartViewController

- (void) viewDidLoad {
	[super viewDidLoad];
	_queue = [[NSOperationQueue alloc] init];
	_queue.maxConcurrentOperationCount = 1;
	_menuContainer.hidden = YES;
}

- (void) viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	self.navigationController.navigationBarHidden = YES;
}

- (void) viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
	NSFileManager *fileManager = [[NSFileManager alloc] init];
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
 	NSString *infoFileName = [[paths objectAtIndex:0] stringByAppendingPathComponent: kInfoFileName];
	NSDictionary *attrs = [fileManager attributesOfItemAtPath: infoFileName error:nil];
	NSDate *updated = [attrs objectForKey: NSFileCreationDate];
	NSDate *updatedLimit = [NSDate dateWithTimeIntervalSinceNow:UPDATE_LIMIT];
	
	if (![fileManager fileExistsAtPath: infoFileName] || !updated || NSOrderedAscending == [updated compare:updatedLimit]) {
		NSURLRequest *request = [NSURLRequest requestWithURL: [NSURL URLWithString: [NSString stringWithFormat: @"%@%@", kServerURL, kInfoFileName]] cachePolicy:NSURLCacheStorageNotAllowed timeoutInterval: kServerTimeout];
		NSArray *cachePaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
		NSString *tempFileName = [[cachePaths objectAtIndex:0] stringByAppendingPathComponent: kInfoFileName];
		[fileManager removeItemAtPath: tempFileName error:nil];
		DLog(@"%@", request);
		AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
			[fileManager removeItemAtPath: infoFileName error:nil];
			[fileManager moveItemAtPath: tempFileName toPath: infoFileName error:nil];

			NSArray *headList = [NSJSONSerialization JSONObjectWithData: [NSData dataWithContentsOfFile:infoFileName] options:0 error:nil];
			for (NSDictionary *headDict in headList) {
				NSString *imageURL = headDict[@"image"];
				NSString *imageName = [[imageURL md5] stringByAppendingPathExtension: [imageURL pathExtension]];
				NSString *imageFileName = [[paths objectAtIndex:0] stringByAppendingPathComponent: imageName];
				DLog(@"%@", imageFileName);
				if (![fileManager fileExistsAtPath: imageFileName]) {
					NSURLRequest *imageRequest = [NSURLRequest requestWithURL: [NSURL URLWithString: imageURL] cachePolicy:NSURLCacheStorageNotAllowed timeoutInterval: kServerTimeout];
					NSString *tempImageFileName = [[cachePaths objectAtIndex:0] stringByAppendingPathComponent: imageName];
					[fileManager removeItemAtPath: tempImageFileName error:nil];
					AFImageRequestOperation *imageOperation = [[AFImageRequestOperation alloc] initWithRequest: imageRequest];
					imageOperation.outputStream = [NSOutputStream outputStreamToFileAtPath: tempImageFileName append:NO];
					[imageOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
						[fileManager removeItemAtPath: imageFileName error: nil];
						[fileManager moveItemAtPath: tempImageFileName toPath: imageFileName error: nil];
						DLog(@"%@ -> %@", tempImageFileName, imageFileName);
					} failure:^(AFHTTPRequestOperation *operation, NSError *error) {
						DLog(@"FAIL %@ %@", error.localizedDescription, error.userInfo)
					}];
					[_queue addOperation: imageOperation];
				}
			}
			dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1.0 * NSEC_PER_SEC), dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
				[_queue waitUntilAllOperationsAreFinished];
				DLog(@"WAIT FINISHED");
				dispatch_async(dispatch_get_main_queue(), ^{
					[self proceed];
				});
			});
		} failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
			dispatch_async(dispatch_get_main_queue(), ^{
				[self proceed];
			});
		}];
		operation.outputStream = [NSOutputStream outputStreamToFileAtPath: tempFileName append:NO];
		[_queue addOperation: operation];
	}
	else
		[self proceed];
}

- (void) viewDidUnload {
	_loadingView = nil;
	_menuContainer = nil;
	_queue = nil;
	[super viewDidUnload];
}

- (void) proceed {
	_loadingView.hidden = YES;
	_menuContainer.hidden = NO;
}

- (IBAction) webstart {
	[self loadWebView: [NSURL URLWithString:@"http://www.uikonf.com"] withTitle:@"UIKonf"];
}

- (IBAction) program {
	[self loadWebView: [NSURL URLWithString:@"http://www.uikonf.com/program.html"] withTitle:@"Program"];
}

- (IBAction) tickets {
	[self loadWebView: [NSURL URLWithString:@"http://tickets.uikonf.com/"] withTitle:@"Tickets"];
}

- (IBAction) venue {
	[self loadWebView: [NSURL URLWithString:@"http://www.uikonf.com/venue.html"] withTitle:@"Venue"];
}

- (void) loadWebView:(NSURL*) url withTitle:(NSString*) title {
	WebViewController *webVC = [[WebViewController alloc] initWithNibName:@"WebViewController" bundle:nil];
	webVC.title = title;
	webVC.url = url;
	[self.navigationController pushViewController: webVC animated:YES];
}

- (IBAction) heads {
	[self.navigationController pushViewController: [[IntroViewController alloc] initWithNibName:@"IntroViewController" bundle:nil] animated:YES];
}

@end
