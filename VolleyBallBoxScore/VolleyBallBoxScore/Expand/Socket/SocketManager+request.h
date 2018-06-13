//
//  SocketManager+request.h
//  VolleyballVoice
//
//  Created by mac on 2017/6/16.
//  Copyright © 2017年 thc. All rights reserved.
//

#import "SocketManager.h"

typedef enum : NSUInteger {
    Confirm,
    TeamPlayer,
    TeamInfo,
    PlayerInfo,
    GameInfo,
    All
} CodeNum;

@interface SocketManager (request)

/**
 获取数据

 @param code     
 Confirm确认身份
 TeamPlayer 阵容
 TeamInfo, 球队详情
 PlayerInfo, 球员详情
 GameInfo, 比赛详情
 All 所有的数据
 @param success 成功回调
 @param Fail 失败回调
 */
-(void)GetTeamPlayerCode:(CodeNum)code Success:(requestSuccess)success Error:(requestError)Fail;
@end
