//
//  ViewController.h
//  UIKonfHeads
//
//  Created by Oliver Michalak on 23.04.13.
//  Copyright (c) 2013 Oliver Michalak. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StartViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *loadingView;
@property (strong, nonatomic) IBOutlet UIView *menuContainer;

- (IBAction) webstart;
- (IBAction) program;
- (IBAction) tickets;
- (IBAction) venue;
- (IBAction) heads;

@end
