//
//  VBAlertView.m
//  VolleyballVoice
//
//  Created by mac on 2017/6/20.
//  Copyright © 2017年 thc. All rights reserved.
//

#import "VBAlertView.h"

@interface VBAlertView ()

@property (nonatomic,strong)UIView * BlackView;
@property (nonatomic,strong)UIView * bigView;
@property (nonatomic,strong)UILabel * titleLabel;
@property (nonatomic,strong)UIButton * label1;
@property (nonatomic,strong)UIButton * label2;

@end

@implementation VBAlertView

- (instancetype)initWithTitle:(NSString*)title text1:(NSString *)text1 text2:(NSString *)text2
{
    self = [super init];
    if (self) {
        
        self.frame = CGRectMake(0, 0, KWIDTH, KHEIGHT);
        self.backgroundColor = [UIColor clearColor];
        [self addSubview:self.BlackView];
        self.titleLabel.text = title;
        [self.label1 setTitle:text1 forState:UIControlStateNormal];
        [self.label2 setTitle:text2 forState:UIControlStateNormal];

    }
    
    return self;
}

-(void)Show{

    [[UIApplication sharedApplication].keyWindow addSubview:self];
}

-(void)selectClick:(UIButton *)btn{

    
    if (btn == self.label1) {
        
        NSString *teamAID = [kUserDefault objectForKey:@"teamAID"];
        NSDictionary *lineUpModelA = [kUserDefault objectForKey:@"lineUpBeanA"];
        [kUserDefault setObject:teamAID forKey:@"teamID"];
        [kUserDefault setObject:lineUpModelA forKey:@"lineUpModel"];
        [kNotificationCenter postNotificationName:@"reload" object:nil userInfo:@{@"teamID":teamAID,@"lineUpModel":lineUpModelA}];
        
    }else{
        
        NSString *teamBID = [kUserDefault objectForKey:@"teamBID"];
        NSDictionary *lineUpModelB = [kUserDefault objectForKey:@"lineUpBeanB"];
        [kUserDefault setObject:teamBID forKey:@"teamID"];
        [kUserDefault setObject:lineUpModelB forKey:@"lineUpModel"];
        [kNotificationCenter postNotificationName:@"reload" object:nil userInfo:@{@"teamID":teamBID,@"lineUpModel":lineUpModelB}];
    }
    [self removeFromSuperview];
}

-(UIView*)BlackView{

    if (!_BlackView) {
        _BlackView = [[UIView alloc] initWithFrame:self.frame];
        _BlackView.backgroundColor = [UIColor blackColor];
        _BlackView.alpha = 0.4;
    }
    return _BlackView;
}

-(UIView*)bigView{

    if (!_bigView) {
        _bigView = [[UIView alloc] initWithFrame:CGRectMake(self.width/2, self.height/2, 400, 200)];
        _bigView.center = self.center;
        _bigView.backgroundColor = [UIColor whiteColor];
        _bigView.layer.cornerRadius = 10;
        _bigView.clipsToBounds = YES;
        [self addSubview:_bigView];
    }
    
    return _bigView;
}

-(UILabel *)titleLabel{

    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.bigView.width, self.bigView.height/3 - 2)];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont boldSystemFontOfSize:25];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.backgroundColor = VB_BACK;
        [self.bigView addSubview:_titleLabel];
    }
    return _titleLabel;
}

-(UIButton *)label1{
    
    if (!_label1) {
        _label1 = [[UIButton alloc] initWithFrame:CGRectMake(0, self.titleLabel.maxY + 2, self.bigView.width, self.bigView.height/3 - 2)];
        _label1.titleLabel.font = [UIFont boldSystemFontOfSize:25];
        [_label1 addTarget:self action:@selector(selectClick:) forControlEvents:UIControlEventTouchUpInside];
        [_label1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _label1.backgroundColor = VB_BACK;

        [self.bigView addSubview:_label1];
    }
    return _label1;
}

-(UIButton *)label2{
    
    if (!_label2) {
        _label2 = [[UIButton alloc] initWithFrame:CGRectMake(0, self.label1.maxY + 2, self.bigView.width, self.bigView.height/3)];
        _label2.titleLabel.font = [UIFont boldSystemFontOfSize:25];
        [_label2 addTarget:self action:@selector(selectClick:) forControlEvents:UIControlEventTouchUpInside];
        [_label2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _label2.backgroundColor = VB_BACK;

        [self.bigView addSubview:_label2];
    }
    return _label2;
}

@end
