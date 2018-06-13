//
//  SCoreLeftView.h
//  VolleyballVoice
//
//  Created by mac on 2017/6/2.
//  Copyright © 2017年 thc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SCoreLeftView : UIView
/**
 原点
 */
@property (nonatomic,assign)CGPoint centerPoint;
@property (nonatomic,assign)CGFloat radius;

@property (nonatomic,strong)UIBezierPath *BigPATH;
@property (nonatomic,strong)UIBezierPath *SmallPATH;

@property (nonatomic,strong)UIColor *bigColor;
@property (nonatomic,strong)UIColor *smallColor;

@property (nonatomic,assign)BOOL isContectPoint;

@property (nonatomic,strong)UIView * smallview;


- (instancetype)initWithFrame:(CGRect)frame;

//点击出现白色圆形
-(void)clickAnimation:(CGPoint)point;


-(void)removeLayer;

@end
