//
//  AppDelegate.m
//  UIKonfHeads
//
//  Created by Oliver Michalak on 23.04.13.
//  Copyright (c) 2013 Oliver Michalak. All rights reserved.
//

#import "AppDelegate.h"
#import "StartViewController.h"

@implementation AppDelegate

- (BOOL) application:(UIApplication*) application didFinishLaunchingWithOptions:(NSDictionary*) launchOptions {
	srandom(time(NULL));
	if (![[NSUserDefaults standardUserDefaults] objectForKey:@"headCounter"])
		[[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"headCounter"];
/*
	NSArray *list = @[@{@"name": @"Oliver Michalak", @"image": @"oliver.jpg", @"email": @"oliver@werk01.de" ,@"twitter": @"omichde"},
									 @{@"name": @"Ole Begemann", @"image": @"oleb.jpg", @"email": @"ole@begemann.de" ,@"twitter": @"oleb"}];
	NSData *data = [NSJSONSerialization dataWithJSONObject: list options:0 error:nil];
	[data writeToFile:@"/Users/omich/Desktop/info.json" atomically:YES];
*/
	self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	self.viewController = [[UINavigationController alloc] initWithRootViewController:[[StartViewController alloc] initWithNibName:@"StartViewController" bundle:nil]];
	self.viewController.navigationBarHidden = YES;
	self.viewController.navigationBar.barStyle = UIBarStyleBlack;
	self.window.rootViewController = self.viewController;
	[self.window makeKeyAndVisible];
	return YES;
}

@end
