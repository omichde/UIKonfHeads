//
//  const.h
//  UIKonfHeads
//
//  Created by Oliver Michalak on 23.04.13.
//  Copyright (c) 2013 Oliver Michalak. All rights reserved.
//

#ifndef UIKonfHeads_const_h
#define UIKonfHeads_const_h

#ifdef DEBUG
#define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#define DLog(...)
#endif

#define kServerURL @"http://app.werk01.de/uikonfheads/"
#define kInfoFileName @"info.json"

#define kServerTimeout (30)
#define UPDATE_LIMIT (-60*60*2)	// every 2 hours...

#define kDuration (0.3)
#define kMinHeadCounter (10)
#define kCountdown (10)

/*
 NSUserDefaults:
 headCounter - int - total number of guesses
 headCorrect - int - number of correct guesses
*/

#endif
