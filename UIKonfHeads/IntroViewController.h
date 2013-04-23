//
//  IntroViewController.h
//  UIKonfHeads
//
//  Created by Oliver Michalak on 23.04.13.
//  Copyright (c) 2013 Oliver Michalak. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IntroViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *textView;
@property (strong, nonatomic) IBOutlet UILabel *indexView;
@property (strong, nonatomic) IBOutlet UIButton *startButton;

- (IBAction) start;

@end
