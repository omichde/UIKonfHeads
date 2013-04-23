//
//  RealodButton.m
//  UIKonfHeads
//
//  Created by Oliver Michalak on 23.04.13.
//  Copyright (c) 2013 Oliver Michalak. All rights reserved.
//

#import "ReloadButton.h"

@implementation ReloadButton

- (void) drawRect:(CGRect) rect {
	//// Color Declarations
	UIColor* background = [UIColor colorWithRed: 1 green: 1 blue: 1 alpha: 0.5];
	
	//// Frames
	CGRect outerFrame = self.bounds;
	
	//// Subframes
	CGRect iconFrame = CGRectMake(CGRectGetMinX(outerFrame) + floor((CGRectGetWidth(outerFrame) - 38) * 0.50000 + 0.5), CGRectGetMinY(outerFrame) + floor((CGRectGetHeight(outerFrame) - 38) * 0.50000 + 0.5), 38, 38);
	
	
	//// Rectangle Drawing
	UIBezierPath* rectanglePath = [UIBezierPath bezierPathWithRect: CGRectMake(CGRectGetMinX(outerFrame), CGRectGetMinY(outerFrame), CGRectGetWidth(outerFrame), CGRectGetHeight(outerFrame))];
	[background setFill];
	[rectanglePath fill];
	
	
	//// Bezier 3 Drawing
	UIBezierPath* bezier3Path = [UIBezierPath bezierPath];
	[bezier3Path moveToPoint: CGPointMake(CGRectGetMinX(iconFrame) + 0.76316 * CGRectGetWidth(iconFrame), CGRectGetMinY(iconFrame) + 0.21053 * CGRectGetHeight(iconFrame))];
	[bezier3Path addLineToPoint: CGPointMake(CGRectGetMinX(iconFrame) + 0.50000 * CGRectGetWidth(iconFrame), CGRectGetMinY(iconFrame) + 0.42105 * CGRectGetHeight(iconFrame))];
	[bezier3Path addLineToPoint: CGPointMake(CGRectGetMinX(iconFrame) + 0.50000 * CGRectGetWidth(iconFrame), CGRectGetMinY(iconFrame) + 0.26387 * CGRectGetHeight(iconFrame))];
	[bezier3Path addCurveToPoint: CGPointMake(CGRectGetMinX(iconFrame) + 0.31392 * CGRectGetWidth(iconFrame), CGRectGetMinY(iconFrame) + 0.34024 * CGRectGetHeight(iconFrame)) controlPoint1: CGPointMake(CGRectGetMinX(iconFrame) + 0.41984 * CGRectGetWidth(iconFrame), CGRectGetMinY(iconFrame) + 0.26834 * CGRectGetHeight(iconFrame)) controlPoint2: CGPointMake(CGRectGetMinX(iconFrame) + 0.36036 * CGRectGetWidth(iconFrame), CGRectGetMinY(iconFrame) + 0.29379 * CGRectGetHeight(iconFrame))];
	[bezier3Path addCurveToPoint: CGPointMake(CGRectGetMinX(iconFrame) + 0.31392 * CGRectGetWidth(iconFrame), CGRectGetMinY(iconFrame) + 0.71240 * CGRectGetHeight(iconFrame)) controlPoint1: CGPointMake(CGRectGetMinX(iconFrame) + 0.21115 * CGRectGetWidth(iconFrame), CGRectGetMinY(iconFrame) + 0.44300 * CGRectGetHeight(iconFrame)) controlPoint2: CGPointMake(CGRectGetMinX(iconFrame) + 0.21115 * CGRectGetWidth(iconFrame), CGRectGetMinY(iconFrame) + 0.60963 * CGRectGetHeight(iconFrame))];
	[bezier3Path addCurveToPoint: CGPointMake(CGRectGetMinX(iconFrame) + 0.68608 * CGRectGetWidth(iconFrame), CGRectGetMinY(iconFrame) + 0.71240 * CGRectGetHeight(iconFrame)) controlPoint1: CGPointMake(CGRectGetMinX(iconFrame) + 0.41669 * CGRectGetWidth(iconFrame), CGRectGetMinY(iconFrame) + 0.81517 * CGRectGetHeight(iconFrame)) controlPoint2: CGPointMake(CGRectGetMinX(iconFrame) + 0.58331 * CGRectGetWidth(iconFrame), CGRectGetMinY(iconFrame) + 0.81517 * CGRectGetHeight(iconFrame))];
	[bezier3Path addCurveToPoint: CGPointMake(CGRectGetMinX(iconFrame) + 0.76316 * CGRectGetWidth(iconFrame), CGRectGetMinY(iconFrame) + 0.52632 * CGRectGetHeight(iconFrame)) controlPoint1: CGPointMake(CGRectGetMinX(iconFrame) + 0.73747 * CGRectGetWidth(iconFrame), CGRectGetMinY(iconFrame) + 0.66101 * CGRectGetHeight(iconFrame)) controlPoint2: CGPointMake(CGRectGetMinX(iconFrame) + 0.76316 * CGRectGetWidth(iconFrame), CGRectGetMinY(iconFrame) + 0.59366 * CGRectGetHeight(iconFrame))];
	[bezier3Path addLineToPoint: CGPointMake(CGRectGetMinX(iconFrame) + 0.89474 * CGRectGetWidth(iconFrame), CGRectGetMinY(iconFrame) + 0.52632 * CGRectGetHeight(iconFrame))];
	[bezier3Path addCurveToPoint: CGPointMake(CGRectGetMinX(iconFrame) + 0.77912 * CGRectGetWidth(iconFrame), CGRectGetMinY(iconFrame) + 0.80544 * CGRectGetHeight(iconFrame)) controlPoint1: CGPointMake(CGRectGetMinX(iconFrame) + 0.89474 * CGRectGetWidth(iconFrame), CGRectGetMinY(iconFrame) + 0.62734 * CGRectGetHeight(iconFrame)) controlPoint2: CGPointMake(CGRectGetMinX(iconFrame) + 0.85620 * CGRectGetWidth(iconFrame), CGRectGetMinY(iconFrame) + 0.72836 * CGRectGetHeight(iconFrame))];
	[bezier3Path addCurveToPoint: CGPointMake(CGRectGetMinX(iconFrame) + 0.22088 * CGRectGetWidth(iconFrame), CGRectGetMinY(iconFrame) + 0.80544 * CGRectGetHeight(iconFrame)) controlPoint1: CGPointMake(CGRectGetMinX(iconFrame) + 0.62497 * CGRectGetWidth(iconFrame), CGRectGetMinY(iconFrame) + 0.95959 * CGRectGetHeight(iconFrame)) controlPoint2: CGPointMake(CGRectGetMinX(iconFrame) + 0.37503 * CGRectGetWidth(iconFrame), CGRectGetMinY(iconFrame) + 0.95959 * CGRectGetHeight(iconFrame))];
	[bezier3Path addCurveToPoint: CGPointMake(CGRectGetMinX(iconFrame) + 0.22088 * CGRectGetWidth(iconFrame), CGRectGetMinY(iconFrame) + 0.24719 * CGRectGetHeight(iconFrame)) controlPoint1: CGPointMake(CGRectGetMinX(iconFrame) + 0.06672 * CGRectGetWidth(iconFrame), CGRectGetMinY(iconFrame) + 0.65128 * CGRectGetHeight(iconFrame)) controlPoint2: CGPointMake(CGRectGetMinX(iconFrame) + 0.06672 * CGRectGetWidth(iconFrame), CGRectGetMinY(iconFrame) + 0.40135 * CGRectGetHeight(iconFrame))];
	[bezier3Path addCurveToPoint: CGPointMake(CGRectGetMinX(iconFrame) + 0.50000 * CGRectGetWidth(iconFrame), CGRectGetMinY(iconFrame) + 0.13214 * CGRectGetHeight(iconFrame)) controlPoint1: CGPointMake(CGRectGetMinX(iconFrame) + 0.29257 * CGRectGetWidth(iconFrame), CGRectGetMinY(iconFrame) + 0.17550 * CGRectGetHeight(iconFrame)) controlPoint2: CGPointMake(CGRectGetMinX(iconFrame) + 0.38497 * CGRectGetWidth(iconFrame), CGRectGetMinY(iconFrame) + 0.13715 * CGRectGetHeight(iconFrame))];
	[bezier3Path addLineToPoint: CGPointMake(CGRectGetMinX(iconFrame) + 0.50000 * CGRectGetWidth(iconFrame), CGRectGetMinY(iconFrame) + 0.00000 * CGRectGetHeight(iconFrame))];
	[bezier3Path addLineToPoint: CGPointMake(CGRectGetMinX(iconFrame) + 0.76316 * CGRectGetWidth(iconFrame), CGRectGetMinY(iconFrame) + 0.21053 * CGRectGetHeight(iconFrame))];
	[bezier3Path closePath];
	[[UIColor darkGrayColor] setFill];
	[bezier3Path fill];
	
	

}

@end
