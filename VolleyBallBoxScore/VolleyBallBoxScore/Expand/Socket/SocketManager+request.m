//
//  SocketManager+request.m
//  VolleyballVoice
//
//  Created by mac on 2017/6/16.
//  Copyright © 2017年 thc. All rights reserved.
//

#import "SocketManager+request.h"

@implementation SocketManager (request)

-(void)GetDataWithCode:(NSString *)code Msg:(NSString *)msg Success:(requestSuccess)success Error:(requestError)error{

    NSMutableDictionary* dicUserData = [NSMutableDictionary dictionary];
    [dicUserData setValue:code forKey:@"code"];

    [dicUserData setValue:msg forKey:@"msg"];
    [dicUserData setValue:@"" forKey:@"data"];
    [self.socket writeData:[[dicUserData JSONStringWithDic] dataUsingEncoding:NSUTF8StringEncoding] withTimeout:kMaxReconnection_time tag:0];
    NSLog(@"%@",[dicUserData JSONStringWithDic]);
    
    self.success = success;
    self.error = error;
}

-(void)GetTeamPlayerCode:(CodeNum)code Success:(requestSuccess)success Error:(requestError)Fail{


    NSString * codeStr;
    NSString * msg;
    switch (code) {
        case Confirm:
            codeStr = @"1";
            msg = @"4";
            break;
        case TeamPlayer:
            codeStr = @"2";
            msg = @"场上阵容";
            break;
        case PlayerInfo:
            codeStr = @"3";
            msg = @"球员数据";
            break;
        case GameInfo:
            msg = @"局数据";
            codeStr = @"5";
            break;
        case TeamInfo:
            codeStr = @"11";
            msg = @"球队数据";

            break;
        case All:
            codeStr = @"12";
            msg = @"比赛的所有数据";

            break;
        default:
            break;
    }
    
    [self GetDataWithCode:codeStr Msg:msg Success:^(NSDictionary *dic) {
        if (success) {
            success(dic);
        }
    } Error:^(NSString *error) {
        if (Fail) {
            Fail(error);
        }
    }];
    
}
@end
