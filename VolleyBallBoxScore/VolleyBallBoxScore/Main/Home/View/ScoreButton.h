//
//  ScoreButton.h
//  VolleyballVoice
//
//  Created by mac on 2017/6/2.
//  Copyright © 2017年 thc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScoreButton : UIButton

@property (nonatomic,strong)UIImageView * norimage;

-(void)shiwu;

-(void)sendMessage;

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title;


@end
