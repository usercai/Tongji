//
//  UIGestureRecognizer+Drag.h
//  VolleyballVoice
//
//  Created by mac on 2017/6/2.
//  Copyright © 2017年 thc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIGestureRecognizer (Drag)
@property (assign, nonatomic) CGPoint startPoint;
@property (strong, nonatomic) NSArray *rectValues;

/**
 拖动到某个控件中

 @param view 手势控件的父控件
 @param views 手势控件的目标控件
 @param overlappingBlock 手势动的过程中
 @param completionBlock 结束手势
 */
- (void)dragViewWithinView:(UIView *)view evaluateViewsForOverlap:(NSArray *)views containedByOverlappingViewBlock:(void (^)(UIView *overlappingView))overlappingBlock completion:(void (^)(UIView *overlappingView))completionBlock;

// Animate recognizer's decorated view with touch. Execute overlap block with the index of an evaluated rect that fully contains the rect of the gesture's view.
- (void)dragViewWithinView:(UIView *)view evaluateRectsForOverlap:(NSArray *)rects containedByOverlappingRectBlock:(void (^)(NSUInteger overlappingIndex))containsBlock completion:(void (^)(NSUInteger overlappingIndex))completionBlock;

// Animate the passed layer with the recognizer's position, evaluate overlapping views.
- (void)dragLayer:(CALayer *)layer withinView:(UIView *)view evaluateRectsForOverlaps:(NSArray *)rects containedByOverlappingRectBlock:(void (^)(NSUInteger overlappingIndex))containsBlock completion:(void (^)(NSUInteger overlappingIndex))completionBlock;

@end
