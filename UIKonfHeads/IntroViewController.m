//
//  IntroViewController.m
//  UIKonfHeads
//
//  Created by Oliver Michalak on 23.04.13.
//  Copyright (c) 2013 Oliver Michalak. All rights reserved.
//

#import "IntroViewController.h"
#import "PlayViewController.h"
#import "Twitter/Twitter.h"

@interface IntroViewController ()
@property (assign, nonatomic) int headCounter;
@end

@implementation IntroViewController

- (void) viewDidLoad {
	[super viewDidLoad];
	self.title = @"Heads";
	self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(export)];

	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
 	NSString *infoFileName = [[paths objectAtIndex:0] stringByAppendingPathComponent: kInfoFileName];
	NSArray *headList = [NSJSONSerialization JSONObjectWithData: [NSData dataWithContentsOfFile:infoFileName] options:0 error:nil];
	_headCounter = headList.count;
	_textView.text = [NSString stringWithFormat: _textView.text, _headCounter];
	if (!headList.count)
		_startButton.hidden = YES;
}

- (void) viewWillAppear:(BOOL) animated {
	[super viewWillAppear:animated];
	self.navigationController.navigationBarHidden = NO;
	int headCounter = [[NSUserDefaults standardUserDefaults] integerForKey:@"headCounter"];
	int headCorrect = [[NSUserDefaults standardUserDefaults] integerForKey:@"headCorrect"];
	if (headCounter)
		_indexView.text = [NSString stringWithFormat:@"%.0f%%", 100.0 * (headCorrect/(float)kCountdown) / (float)headCounter];
	else
		_indexView.text = @"0%";
}

- (void) viewDidUnload {
	_indexView = nil;
	_textView = nil;
	_startButton = nil;
	[super viewDidUnload];
}

- (void) export {
	if (kMinHeadCounter > [[NSUserDefaults standardUserDefaults] integerForKey:@"headCounter"])
		[[[UIAlertView alloc] initWithTitle:@"Warning" message:[NSString stringWithFormat:@"You need at least %d guesses to post your index!", kMinHeadCounter] delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles: nil] show];
	else if (![TWTweetComposeViewController canSendTweet])
		[[[UIAlertView alloc] initWithTitle:@"Warning" message: @"Please setup a Twitter account to tweet your index!" delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles: nil] show];
	else {
		int headCounter = [[NSUserDefaults standardUserDefaults] integerForKey:@"headCounter"];
		int headCorrect = [[NSUserDefaults standardUserDefaults] integerForKey:@"headCorrect"];
		NSString *message = [NSString stringWithFormat: @"My \"Heads Index\" is %.0f%% at %d heads for #UIKonf", 100.0 * (headCorrect/(float)kCountdown) / (float)headCounter, _headCounter];
		TWTweetComposeViewController *twitterViewController = [[TWTweetComposeViewController alloc] init];
		[twitterViewController setInitialText: message];
		[self presentModalViewController:twitterViewController animated:YES];
	}
}

- (IBAction) start {
	[self.navigationController pushViewController:[[PlayViewController alloc] initWithNibName:@"PlayViewController" bundle:nil] animated:YES];
}
@end
