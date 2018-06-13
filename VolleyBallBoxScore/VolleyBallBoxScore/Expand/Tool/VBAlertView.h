//
//  VBAlertView.h
//  VolleyballVoice
//
//  Created by mac on 2017/6/20.
//  Copyright © 2017年 thc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VBAlertView : UIView

- (instancetype)initWithTitle:(NSString*)title text1:(NSString *)text1 text2:(NSString *)text2;

-(void)Show;

@end
