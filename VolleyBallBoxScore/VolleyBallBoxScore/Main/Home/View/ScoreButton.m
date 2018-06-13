//
//  ScoreButton.m
//  VolleyballVoice
//
//  Created by mac on 2017/6/2.
//  Copyright © 2017年 thc. All rights reserved.
//

#import "ScoreButton.h"
#import <AudioToolbox/AudioToolbox.h>


@interface ScoreButton (){

    CGPoint startPoint;
    SystemSoundID soundFileObject;
}


@end
@implementation ScoreButton

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
        [self setTitle:title forState:UIControlStateNormal];
        if ([title isEqualToString:@"接发球"]) {
            [self setBackgroundImage:[UIImage imageNamed:@"jiefaqiu"] forState:UIControlStateSelected];
        }else if ([title isEqualToString:@"防守"]){
            [self setBackgroundImage:[UIImage imageNamed:@"fangshou"] forState:UIControlStateSelected];
        }else if ([title isEqualToString:@"传球"]){
            [self setBackgroundImage:[UIImage imageNamed:@"chuanqiu"] forState:UIControlStateSelected];
        }else if ([title isEqualToString:@"发球"]){
            [self setBackgroundImage:[UIImage imageNamed:@"faqiu"] forState:UIControlStateSelected];
        }else if ([title isEqualToString:@"扣球"]){
            [self setBackgroundImage:[UIImage imageNamed:@"kouqiu"] forState:UIControlStateSelected];
        }else if ([title isEqualToString:@"拦网"]){
            [self setBackgroundImage:[UIImage imageNamed:@"lanwang"] forState:UIControlStateSelected];
        }
    }
    return self;
}

-(void)initView{

    self.layer.cornerRadius = self.width/2;
    self.clipsToBounds = YES;
    self.layer.borderWidth = 2;
    self.layer.borderColor = [UIColor darkGrayColor].CGColor;
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self setTitleColor:[UIColor clearColor] forState:UIControlStateSelected];
    self.titleLabel.font = [UIFont systemFontOfSize:20 weight:4];
    self.backgroundColor = VB_dark;
    [self addTarget:self action:@selector(youxiao) forControlEvents:UIControlEventTouchUpInside];
    
    [self setExclusiveTouch:YES];
}


-(void)dianjiAnotimation{

    CGRect startframe = self.frame;
    [self playSound:@"dianji"];

    [UIView animateWithDuration:0.2 animations:^{
        self.frame = CGRectMake(startframe.origin.x + self.width/3, startframe.origin.y + self.width/3, self.width/3, self.height/3);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 animations:^{
            self.frame = startframe;
        }];
    }];
}


//得分动画
-(void)defenAnotimation{

    [self playSound:@"tuodong"];
    CGRect frame = [self convertRect:self.bounds toView:self.superview];
    UIImageView * image = [[UIImageView alloc] initWithFrame:CGRectMake(frame.origin.x, frame.origin.y - 50, self.width, self.width)];
    image.image = [UIImage imageNamed:@"defen"];
    [self.superview addSubview:image];
    
    [UIView animateWithDuration:0.5 animations:^{
        
        image.frame = CGRectMake(frame.origin.x + self.width/3, frame.origin.y - 60, self.width/3, self.width/3);
    } completion:^(BOOL finished) {
        [image removeFromSuperview];
    }];
}

/**
 点击有效
 */
-(void)youxiao{

    [self dianjiAnotimation];
    [[DataManager shareIntance] addTechnicaDataWithReasult:@"一般" item:self.titleLabel.text];
}

/**
 得分
 */
-(void)sendMessage{

    [self defenAnotimation];
    if ([self.titleLabel.text isEqualToString:@"发球"] || [self.titleLabel.text isEqualToString:@"拦网"] || [self.titleLabel.text isEqualToString:@"扣球"]) {
        [[DataManager shareIntance] addTechnicaDataWithReasult:@"得分" item:self.titleLabel.text];
    }else{
        [[DataManager shareIntance] addTechnicaDataWithReasult:@"有效" item:self.titleLabel.text];

    }
}

-(void)shiwu{

    [self playSound:@"tuodong"];
    [[DataManager shareIntance] addTechnicaDataWithReasult:@"失误" item:self.titleLabel.text];

}

-(void)playSound:(NSString *)name{

    //得到音效文件的地址
    
    NSString*soundFilePath =[[NSBundle mainBundle] pathForResource:name ofType:@"wav"];
    
    //将地址字符串转换成url
    NSURL*soundURL = [NSURL fileURLWithPath:soundFilePath];
    
    //生成系统音效id
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)soundURL, &soundFileObject);
    //播放系统音效
    AudioServicesPlaySystemSound(soundFileObject);
}
@end
