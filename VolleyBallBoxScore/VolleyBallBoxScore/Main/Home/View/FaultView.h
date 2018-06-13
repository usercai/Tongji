//
//  FaultView.h
//  VolleyballVoice
//
//  Created by mac on 2017/6/2.
//  Copyright © 2017年 thc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FaultView : UIButton


- (instancetype)initWithFrame:(CGRect)frame;

@property (nonatomic,strong)UIBezierPath *PATH;

@property (nonatomic,assign)BOOL isSelect;
@end
