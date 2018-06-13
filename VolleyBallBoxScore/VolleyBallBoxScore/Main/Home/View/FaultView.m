//
//  FaultView.m
//  VolleyballVoice
//
//  Created by mac on 2017/6/2.
//  Copyright © 2017年 thc. All rights reserved.
//

#import "FaultView.h"

@interface FaultView()

@property (nonatomic,strong)CAShapeLayer *maskLayer;
@property (nonatomic,strong)UILabel * shiwuLabel;
@property (nonatomic,strong)UIImageView * cha1;
@property (nonatomic,strong)UIImageView * cha2;
@end

@implementation FaultView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}

-(void)initView{

    
    self.maskLayer = [self drawMask:self.height/2];
    self.maskLayer.fillColor = VB_BACK.CGColor;
    self.maskLayer.strokeColor = [UIColor clearColor].CGColor;
    self.maskLayer.lineWidth = 2;
    [self.layer addSublayer:self.maskLayer];
    
    self.shiwuLabel = [[UILabel alloc] initWithFrame:CGRectMake(12, self.height/2 - 25, 20, 50)];
    self.backgroundColor = [UIColor clearColor];
    self.shiwuLabel.textColor = [UIColor colorWithRed:167/255.0 green:159/255.0 blue:159/255.0 alpha:1];
    self.shiwuLabel.text = @"失\n误";
    self.shiwuLabel.numberOfLines = 2;
    self.shiwuLabel.hidden = YES;
    [self addSubview:self.shiwuLabel];
    
    self.cha1 = [[UIImageView alloc] initWithFrame:CGRectMake(30, 30, 50, 50)];
    self.cha1.image = [UIImage imageNamed:@"cha1"];
    [self addSubview:self.cha1];
    self.cha1.hidden = YES;
    
    
    self.cha2 = [[UIImageView alloc] initWithFrame:CGRectMake(30, self.height - 30 - 50, 50, 50)];
    self.cha2.image = [UIImage imageNamed:@"cha2"];
    [self addSubview:self.cha2];
    self.cha2.hidden = YES;
    
    
}


-(CAShapeLayer *)drawMask:(CGFloat)x{
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.frame = self.bounds;
    shapeLayer.path = [self drawBezierPath:x].CGPath;
    return shapeLayer;
}

-(UIBezierPath *)drawBezierPath:(CGFloat)x{
    CGFloat radius = self.bounds.size.height/2 - 10;
    CGFloat right = self.bounds.size.width-x;
    CGFloat left = x;
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    bezierPath.lineJoinStyle = kCGLineJoinRound;
    bezierPath.lineCapStyle = kCGLineCapRound;
    //右边圆弧
//    [bezierPath addArcWithCenter:CGPointMake(right, self.bounds.size.height/2) radius:radius startAngle:-M_PI/2 endAngle:M_PI/2 clockwise:YES];
//    //左边圆弧
    [bezierPath addArcWithCenter:CGPointMake(left + (self.width - left - 20), self.bounds.size.height/2) radius:radius startAngle:M_PI*0.4 endAngle:-M_PI * 0.4 clockwise:YES];
    //闭合弧线
    [bezierPath closePath];
    self.PATH = bezierPath;
    return bezierPath;
}

-(void)setIsSelect:(BOOL)isSelect{

    if (isSelect) {
        
        self.backgroundColor = [UIColor colorWithRed:82/255.0 green:62/255.0 blue:61/255.0 alpha:1];
        
    }else{
    
        self.backgroundColor = VB_BACK;
    }
    
    self.shiwuLabel.hidden = !isSelect;
    self.cha2.hidden = !isSelect;
    self.cha1.hidden = !isSelect;
}



@end
