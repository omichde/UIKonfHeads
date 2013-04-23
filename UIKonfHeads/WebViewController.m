//
//  WebViewController.m
//  UIKonfHeads
//
//  Created by Oliver Michalak on 23.04.13.
//  Copyright (c) 2013 Oliver Michalak. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()

@end

@implementation WebViewController

- (void) viewDidLoad {
	[super viewDidLoad];
	[_webView loadRequest: [NSURLRequest requestWithURL:_url]];
}

- (void) viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	self.navigationController.navigationBarHidden = NO;
}

- (void) viewDidUnload {
	_webView = nil;
	[super viewDidUnload];
}
@end
