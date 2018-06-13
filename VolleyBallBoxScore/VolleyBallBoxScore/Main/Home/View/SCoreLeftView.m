//
//  SCoreLeftView.m
//  VolleyballVoice
//
//  Created by mac on 2017/6/2.
//  Copyright © 2017年 thc. All rights reserved.
//

#import "SCoreLeftView.h"

@interface SCoreLeftView()
//外面大的区域
@property (nonatomic,strong)CAShapeLayer *maskLayer;
//白线
@property (nonatomic,strong)CAShapeLayer *maskLayer1;
//小的区域
@property (nonatomic,strong)CAShapeLayer *maskLayer2;

@property (nonatomic,strong)UILabel * label;

@property (nonatomic,strong)CAShapeLayer *smallLayer;



@end

@implementation SCoreLeftView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}


-(void)initView{
    
    self.backgroundColor = [UIColor clearColor];
    
    
    //小区域的半径跟中心点
    CGFloat radius1 = self.width/2;
    CGPoint center1 = CGPointMake(self.width, self.height/2);
    
//外围区域
    CGFloat radius = self.width;
    CGPoint center = CGPointMake(self.width, self.height/2);
    self.centerPoint = center;
    self.radius = radius;
    
    UIBezierPath *path = [[UIBezierPath alloc] init];
    [path addArcWithCenter:center
                    radius:radius
                startAngle:M_PI*0.40
                  endAngle:-M_PI*0.40
                 clockwise:YES];
    
    [path closePath];

    UIBezierPath * path2 = [path bezierPathByReversingPath];
    self.BigPATH = path2;
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.frame = CGRectMake(0, 0, self.width + 50, self.height);
    shapeLayer.path = path2.CGPath;
    self.maskLayer = shapeLayer;
    self.maskLayer.fillColor = VB_dark.CGColor;
    self.maskLayer.lineWidth = 1;
    [self.layer addSublayer:self.maskLayer];
    

    
    //划白线
    UIBezierPath *path1 = [[UIBezierPath alloc] init];
    [path1 addArcWithCenter:center1
                     radius:radius1
                 startAngle:M_PI*0.40
                   endAngle:-M_PI*0.40
                  clockwise:YES];
    
    
    self.maskLayer1 = [CAShapeLayer layer];
    self.maskLayer1.frame = CGRectMake(10, 0, self.width/2 + 10, self.height/2 + 10);
    self.maskLayer1.path = path1.CGPath;
    self.maskLayer1.fillColor = [UIColor clearColor].CGColor;
    self.maskLayer1.strokeColor = [UIColor whiteColor].CGColor;
    self.maskLayer1.lineWidth = 3;
    [self.layer addSublayer:self.maskLayer1];
    
    
    self.label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 35, 60)];
    self.label.center = CGPointMake(self.width/2 + 40, self.height/2);
    self.label.textColor = [UIColor whiteColor];
    self.label.text = @"得分有效";
    self.label.font = [UIFont systemFontOfSize:15];
    self.label.numberOfLines = 2;
    self.label.backgroundColor = [UIColor clearColor];
    [self addSubview:self.label];
    
    self.smallview = [[UIView alloc] initWithFrame:CGRectMake(0, 20, self.width + 20, self.width*2)];

    
    self.smallview.backgroundColor = [UIColor clearColor];
    
    
    [self addSubview:self.smallview];
    
    
//    //小区域
//    UIBezierPath *path2 = [[UIBezierPath alloc] init];
//    [path2 addArcWithCenter:center1
//                     radius:radius1
//                 startAngle:M_PI*0.40
//                   endAngle:-M_PI*0.40
//                  clockwise:YES];
//    
//    [path2 closePath];
//    self.SmallPATH = path2;
//    self.maskLayer2 = [CAShapeLayer layer];
//
//    self.maskLayer2.frame = CGRectMake(0, 0, self.width/2, self.height/2);
//    self.maskLayer2.path = path1.CGPath;
//    self.maskLayer2.fillColor = [UIColor clearColor].CGColor;
//    self.maskLayer2.lineWidth = 1;
//    [self.layer addSublayer:self.maskLayer2];

}


//点击出现白色圆形
-(void)clickAnimation:(CGPoint)point{
    
    
   
    
    CGFloat radius = self.width;
    CGPoint smallcenter = CGPointMake(self.width, self.height/2);
    UIBezierPath *smallpath = [[UIBezierPath alloc] init];
    [smallpath addArcWithCenter:smallcenter
                         radius:radius
                     startAngle:M_PI*0.40
                       endAngle:-M_PI*0.40
                      clockwise:YES];
    
    [smallpath closePath];
    CAShapeLayer *smallLayer = [CAShapeLayer layer];
    smallLayer.frame = CGRectMake(0, 0, self.smallview.width, self.smallview.height);
    smallLayer.path = smallpath.CGPath;
    smallLayer.fillColor = VB_WhiteColor.CGColor;
    [self.smallview.layer addSublayer:smallLayer];
    
    //放大变色圆形
    CABasicAnimation *basicAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    basicAnimation.duration = 0.2;
    basicAnimation.toValue = (__bridge id _Nullable)([self drawclickCircleBezierPath:10].CGPath);
    basicAnimation.removedOnCompletion = NO;
    basicAnimation.fillMode = kCAFillModeForwards;
    
    [smallLayer addAnimation:basicAnimation forKey:@"clickCicrleAnimation"];
    
    self.smallLayer = smallLayer;
    
    self.smallview.frame = CGRectMake((self.width+20)/2, self.width, 40, 40);
    self.smallview.center = point;

    //执行下一个动画
//    [self performSelector:@selector(clickNextAnimation) withObject:self afterDelay:basicAnimation.duration];
}

-(void)removeLayer{

    [self.smallLayer removeFromSuperlayer];
}

//画圆
-(UIBezierPath *)drawclickCircleBezierPath:(CGFloat)radius{
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    /**
     *  center: 弧线中心点的坐标
     radius: 弧线所在圆的半径
     startAngle: 弧线开始的角度值
     endAngle: 弧线结束的角度值
     clockwise: 是否顺时针画弧线
     *
     */
    [bezierPath addArcWithCenter:CGPointMake(20,20) radius:radius startAngle:0 endAngle:M_PI*2 clockwise:YES];
    return bezierPath;
}



-(void)setIsContectPoint:(BOOL)isContectPoint{

    if (isContectPoint) {
    
        self.bigColor = VB_WhiteColor;
        self.label.textColor = [UIColor whiteColor];
        self.maskLayer1.strokeColor = [UIColor whiteColor].CGColor;

    }else{
    
        self.bigColor = VB_dark;
        self.label.textColor = [UIColor whiteColor];
        self.maskLayer1.strokeColor = [UIColor whiteColor].CGColor;

    }
    
}


-(void)setBigColor:(UIColor *)bigColor{

    self.maskLayer.fillColor = bigColor.CGColor;
    self.maskLayer1.fillColor = bigColor.CGColor;

}

-(void)setSmallColor:(UIColor *)smallColor{

    self.maskLayer1.fillColor = smallColor.CGColor;
}
@end
