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

	self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	self.viewController = [[UINavigationController alloc] initWithRootViewController:[[StartViewController alloc] initWithNibName:@"StartViewController" bundle:nil]];
	self.viewController.navigationBarHidden = YES;
	self.viewController.navigationBar.barStyle = UIBarStyleBlack;
	self.window.rootViewController = self.viewController;
	[self.window makeKeyAndVisible];
	return YES;
}

@end
