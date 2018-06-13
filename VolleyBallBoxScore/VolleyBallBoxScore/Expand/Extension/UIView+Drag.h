//
//  UIView+Drag.h
//  VolleyballVoice
//
//  Created by mac on 2017/6/2.
//  Copyright © 2017年 thc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Drag)
+ (UIView *)viewContainingPoint:(CGPoint)point evaluateViews:(NSArray *)views;
+ (UIView *)viewContainingRect:(CGRect)rect evaluateViews:(NSArray *)views;
+ (NSUInteger)indexOfRectContainingPoint:(CGPoint)point evaluateRects:(NSArray *)evaluate;
+ (NSUInteger)indexOfRectContainingRect:(CGRect)rect evaluateRects:(NSArray *)evaluate;
+ (NSArray *)frameRectValuesForViews:(NSArray *)views;
- (NSArray *)frameRectValuesForSubviews;
@end
