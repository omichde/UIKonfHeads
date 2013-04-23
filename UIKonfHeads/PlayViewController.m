//
//  PlayViewController.m
//  UIKonfHeads
//
//  Created by Oliver Michalak on 23.04.13.
//  Copyright (c) 2013 Oliver Michalak. All rights reserved.
//

#import "PlayViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "Twitter/Twitter.h"
#import "NSString+MD5.h"

@interface PlayViewController ()
@property (strong, nonatomic) AVAudioPlayer *bgSound;
@property (strong, nonatomic) AVAudioPlayer *lostSound;
@property (strong, nonatomic) AVAudioPlayer *rightSound;
@property (strong, nonatomic) NSArray *peopleList;
@property (strong, nonatomic) NSMutableArray *guessList;
@property (assign, nonatomic) int correctGuessIndex;
@property (strong, nonatomic) NSNumber *previousGuess;
@property (strong, nonatomic) NSArray *playButtonList;
@property (assign, nonatomic) int timer;
@property (strong, nonatomic) NSTimer *sysTimer;
@end

@implementation PlayViewController

- (void) viewDidLoad {
	[super viewDidLoad];
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
 	NSString *infoFileName = [[paths objectAtIndex:0] stringByAppendingPathComponent: kInfoFileName];
	_peopleList = [NSJSONSerialization JSONObjectWithData: [NSData dataWithContentsOfFile:infoFileName] options:0 error: nil];
	_guessList = [[NSMutableArray alloc] init];
	_playButtonList = @[_button1, _button2, _button3, _button4];
	_bgSound = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource: @"bgsound" ofType:@"wav"]] error:nil];
	_lostSound = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource: @"lost" ofType:@"wav"]] error:nil];
	_rightSound = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource: @"right" ofType:@"wav"]] error:nil];
	[_bgSound prepareToPlay];
	_bgSound.numberOfLoops = 10;
	[_lostSound prepareToPlay];
	[_rightSound prepareToPlay];
	_nextButton.hidden = YES;
	_previousGuess = [NSNumber numberWithInt: -1];
}

- (void) viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	self.navigationController.navigationBarHidden = NO;
	[self viewUpdateTitle];
	[self start];
}

- (void) viewWillDisappear:(BOOL) animated {
	[super viewWillDisappear:animated];
	[_bgSound stop];
	[_lostSound stop];
	[_rightSound stop];
	if (_sysTimer)
		[_sysTimer invalidate];
}

- (void) viewDidUnload {
	_imageView = nil;
	_timerView = nil;
	_button1 = nil;
	_button2 = nil;
	_button3 = nil;
	_button4 = nil;
	_nextButton = nil;
	[_bgSound stop];
	_bgSound = nil;
	[_lostSound stop];
	_lostSound = nil;
	[_rightSound stop];
	_rightSound = nil;
	_peopleList = nil;
	_guessList = nil;
	_previousGuess = nil;
	_playButtonList = nil;
	[_sysTimer invalidate];
	_sysTimer = nil;

	[super viewDidUnload];
}

- (void) viewUpdateTitle {
	int headCounter = [[NSUserDefaults standardUserDefaults] integerForKey:@"headCounter"];
	int headCorrect = [[NSUserDefaults standardUserDefaults] integerForKey:@"headCorrect"];
	if (headCounter)
		self.title = [NSString stringWithFormat:@"Index: %.0f%%", 100.0 * (float)headCorrect / (float)headCounter];
	else
		self.title = @"0%";
}

- (void) start {
	UIColor *blueColor = [UIColor colorWithRed:0.045 green:0.166 blue:0.352 alpha:1.000];
	[_guessList removeAllObjects];
	while (_guessList.count < 4) {
		NSNumber *guess = [NSNumber numberWithInt: random() % _peopleList.count];
		if (![_guessList containsObject: guess] && ![guess isEqual: _previousGuess])
			[_guessList addObject: guess];
	}
	_correctGuessIndex = random() % 4;
	_previousGuess = _guessList[_correctGuessIndex];
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *imageURL = _peopleList[_previousGuess.integerValue][@"image"];
	NSString *imageName = [[imageURL md5] stringByAppendingPathExtension: [imageURL pathExtension]];
	NSString *imageFileName = [[paths objectAtIndex:0] stringByAppendingPathComponent: imageName];
	_imageView.image = [UIImage imageWithContentsOfFile: imageFileName];
	DLog(@"%d - %@", _correctGuessIndex, _guessList);
	[_playButtonList enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
		NSDictionary *dict = _peopleList[[_guessList[idx] integerValue]];
		UIButton *button = (UIButton*) obj;
		button.enabled = YES;
		[button setTitleColor:blueColor forState:UIControlStateNormal];
		[button setTitle: dict[@"name"] forState:UIControlStateNormal];
	}];
	self.navigationItem.rightBarButtonItem = nil;
	_timerView.progress = 1.0;
	_timer = kCountdown;
	_timerView.hidden = NO;
	_sysTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(update) userInfo:nil repeats: YES];
	_bgSound.currentTime = 0.0;
	[_bgSound play];

//	[UIView transitionFromView:viewHot toView:viewCold duration:kDuration options:UIViewAnimationOptionTransitionFlipFromLeft completion:nil];
}

- (void) end:(int) index {
	[_sysTimer invalidate];
	_sysTimer = nil;
	_timerView.hidden = YES;
	[_bgSound stop];
	
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	[defaults setInteger:1+[defaults integerForKey:@"headCounter"] forKey:@"headCounter"];
	if (index == _correctGuessIndex) {
		[_rightSound play];
		[defaults setInteger:1+[defaults integerForKey:@"headCorrect"] forKey:@"headCorrect"];
	}
	else
		[_lostSound play];
	[defaults synchronize];
	[self viewUpdateTitle];

	[_playButtonList enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
		UIButton *button = (UIButton*) obj;
		if (idx == index && index != _correctGuessIndex)
			[button setTitleColor: [UIColor redColor] forState:UIControlStateNormal];
		else if (idx == _correctGuessIndex)
			[button setTitleColor: [UIColor greenColor] forState:UIControlStateNormal];
		else
			[button setTitleColor: [UIColor grayColor] forState:UIControlStateNormal];
		button.enabled = NO;
		[UIView animateWithDuration:kDuration animations:^{
			if (idx == _correctGuessIndex)
				button.transform = CGAffineTransformMakeScale(1.1, 1.1);
			else
				button.transform = CGAffineTransformMakeScale(0.9, 0.9);
		} completion:^(BOOL finished) {
			[UIView animateWithDuration:kDuration animations:^{
				button.transform = CGAffineTransformIdentity;
			}];
		}];
	}];
	dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^(void){
		self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(export)];
		_nextButton.alpha = 0;
    _nextButton.hidden = NO;
		[UIView animateWithDuration:kDuration animations:^{
			_nextButton.alpha = 1;
		}];
	});
}

- (void) update {
	_timer--;
	if (!_timer)
		[self end:-1];
	else
		_timerView.progress = 1.0 - (kCountdown - _timer)/(float)kCountdown;
}

- (IBAction) guess:(id) sender {
	[self end:((UIView*)sender).tag];
}

- (void) export {
	if (![TWTweetComposeViewController canSendTweet])
		[[[UIAlertView alloc] initWithTitle:@"Warning" message: @"Please setup a Twitter account to tweet your index!" delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles: nil] show];
	else {
		NSString *message;
		NSDictionary *dict = _peopleList[_previousGuess.integerValue];
		if (dict[@"twitter"])
			message = [NSString stringWithFormat: @"Hi @%@, see you at #UIKonf", dict[@"twitter"]];
		else
			message = [NSString stringWithFormat: @"Hi %@, see you at #UIKonf", dict[@"name"]];
		TWTweetComposeViewController *twitterViewController = [[TWTweetComposeViewController alloc] init];
		[twitterViewController setInitialText: message];
		[self presentModalViewController:twitterViewController animated:YES];
	}
}

- (IBAction) next {
	[UIView animateWithDuration:kDuration animations:^{
		_nextButton.alpha = 0;
	} completion:^(BOOL finished) {
		_nextButton.hidden = YES;
	}];
	[self start];
}

@end
