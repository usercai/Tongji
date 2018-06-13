//
//  VBHUD.m
//  VolleyballVoice
//
//  Created by Florence on 2017/6/20.
//  Copyright © 2017年 thc. All rights reserved.
//

#import "VBHUD.h"

@implementation VBHUD

+(void)showHUDWithText:(NSString *)text{

    [SVProgressHUD showImage:nil status:text];
    
    [SVProgressHUD dismissWithDelay:1.5];
}

@end
