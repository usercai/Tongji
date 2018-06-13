//
//  UserInfo.m
//  VoiceTest
//
//  Created by Florence on 2017/6/2.
//  Copyright © 2017年 AllureTeartop. All rights reserved.
//

#import "UserInfo.h"
#import "NSObject+Property.h"
#import "VolleyBallPlayers+CoreDataClass.h"
@implementation UserInfo

+(UserInfo *)sharedInstance{
    
    static dispatch_once_t once = 0;
    static UserInfo *user;
    dispatch_once(&once, ^{
        user = [[UserInfo alloc] init];
    });
    return user;
}
-(void)getMatchInfo:(NSDictionary *)matchInfo{

    //将球员数据存取
    NSArray *playerBean = matchInfo[@"playerBean"];
    
    [[DataManager shareIntance] CheckWithEntityName:@"VolleyBallPlayers" Success:^(id request) {
        NSArray *playArr = (NSArray *)request;
        
        for (NSDictionary * dic in playerBean) {
            NSString *dicPlayerID = [NSString stringWithFormat:@"%@",dic[@"playerID"]];
            int i = 0;
            for (VolleyBallPlayers *model in playArr) {
                NSString *modelPlayerID = [NSString stringWithFormat:@"%@",model.playerID];
                if ([modelPlayerID isEqualToString:dicPlayerID]) {
                    i++;
                }
            }
            if (i == 0) {
                NSMutableDictionary *newPlayer = [NSMutableDictionary dictionary];
                newPlayer[@"competitionID"] = [NSString stringWithFormat:@"%@",dic[@"competitionID"]];
                newPlayer[@"competitionPlayerID"] = [NSString stringWithFormat:@"%@",dic[@"competitionPlayerID"]];
                newPlayer[@"isDelete"] = [NSString stringWithFormat:@"%@",dic[@"isDelete"]];
                newPlayer[@"isOnBench"] = [NSString stringWithFormat:@"%@",dic[@"isOnBench"]];
                newPlayer[@"playerBirthday"] = [NSString stringWithFormat:@"%@",dic[@"playerBirthday"]];
                newPlayer[@"playerCode"] = [NSString stringWithFormat:@"%@",dic[@"playerCode"]];
                newPlayer[@"playerID"] = [NSString stringWithFormat:@"%@",dic[@"playerID"]];
                newPlayer[@"playerName"] = [NSString stringWithFormat:@"%@",dic[@"playerName"]];
                newPlayer[@"playerRole"] = [NSString stringWithFormat:@"%@",dic[@"playerRole"]];
                newPlayer[@"teamID"] = [NSString stringWithFormat:@"%@",dic[@"teamID"]];
                newPlayer[@"playerGender"] = @"0";
                newPlayer[@"isSelect"] = @"false";
                newPlayer[@"validNum"] = @"0";
                newPlayer[@"errorNum"] = @"0";
                newPlayer[@"scoreNum"] = @"0";
                [[DataManager shareIntance] adddict:newPlayer ListName:@"VolleyBallPlayers" Success:^(id request) {
                    
                } Fail:^(NSString *error) {
                }];
            }
        }
        
    } error:^(NSString *error) {
        for (NSDictionary *dic in playerBean) {
            NSMutableDictionary *newPlayer = [NSMutableDictionary dictionary];
            newPlayer[@"competitionID"] = [NSString stringWithFormat:@"%@",dic[@"competitionID"]];
            newPlayer[@"competitionPlayerID"] = [NSString stringWithFormat:@"%@",dic[@"competitionPlayerID"]];
            newPlayer[@"isDelete"] = [NSString stringWithFormat:@"%@",dic[@"isDelete"]];
            newPlayer[@"isOnBench"] = [NSString stringWithFormat:@"%@",dic[@"isOnBench"]];
            newPlayer[@"playerBirthday"] = [NSString stringWithFormat:@"%@",dic[@"playerBirthday"]];
            newPlayer[@"playerCode"] = [NSString stringWithFormat:@"%@",dic[@"playerCode"]];
            newPlayer[@"playerID"] = [NSString stringWithFormat:@"%@",dic[@"playerID"]];
            newPlayer[@"playerName"] = [NSString stringWithFormat:@"%@",dic[@"playerName"]];
            newPlayer[@"playerRole"] = [NSString stringWithFormat:@"%@",dic[@"playerRole"]];
            newPlayer[@"teamID"] = [NSString stringWithFormat:@"%@",dic[@"teamID"]];
            newPlayer[@"playerGender"] = @"0";
            newPlayer[@"isSelect"] = @"false";
            newPlayer[@"validNum"] = @"0";
            newPlayer[@"errorNum"] = @"0";
            newPlayer[@"scoreNum"] = @"0";
            [[DataManager shareIntance] adddict:newPlayer ListName:@"VolleyBallPlayers" Success:^(id request) {
            } Fail:^(NSString *error) {
            }];
        }
    }];
    //获取两个球队
    NSDictionary *teamBean = matchInfo[@"teamBean"];
    NSString *teamBID = [NSString stringWithFormat:@"%@",teamBean[@"teamBID"]];
    NSString *teamAID = [NSString stringWithFormat:@"%@",teamBean[@"teamAID"]];
    NSString *teamAName = [NSString stringWithFormat:@"%@",teamBean[@"teamAName"]];
    NSString *teamBName = [NSString stringWithFormat:@"%@",teamBean[@"teamBName"]];

    
    [kUserDefault setObject:teamBID forKey:@"teamBID"];
    [kUserDefault setObject:teamAID forKey:@"teamAID"];
    [kUserDefault setObject:teamAName forKey:@"teamAName"];
    [kUserDefault setObject:teamBName forKey:@"teamBName"];
    
    //两个队的上场球员数据
    //A队
    NSDictionary *lineUpBeanA = matchInfo[@"lineUpBeanA"];
    [kUserDefault setObject:lineUpBeanA forKey:@"lineUpBeanA"];
    //B队
    NSDictionary *lineUpBeanB = matchInfo[@"lineUpBeanB"];
    [kUserDefault setObject:lineUpBeanB forKey:@"lineUpBeanB"];
    
    //section信息
    NSDictionary *sectionBean = matchInfo[@"sectionBean"];
    self.section = [NSString stringWithFormat:@"%@",sectionBean[@"sectionName"]];
    
    [kUserDefault setObject:[NSString stringWithFormat:@"%@",sectionBean[@"sectionName"]] forKey:@"section"];

}

-(void)getLineUpInfo:(NSDictionary *)lineUp{

    NSString *teamID = [NSString stringWithFormat:@"%@",lineUp[@"teamID"]];
    NSString *teamAID = [kUserDefault objectForKey:@"teamAID"];
    if ([teamID isEqualToString:teamAID]) {
        [kUserDefault setObject:teamID forKey:@"teamAID"];
        [kUserDefault setObject:lineUp forKey:@"lineUpBeanA"];
    }else{
        
        [kUserDefault setObject:teamID forKey:@"teamBID"];
        [kUserDefault setObject:lineUp forKey:@"lineUpBeanB"];
    }

    if ([[kUserDefault objectForKey:@"teamID"] isEqualToString:teamID]) {
        [kUserDefault setObject:lineUp forKey:@"lineUpModel"];
        [kNotificationCenter postNotificationName:@"reload" object:nil userInfo:@{@"teamID":teamID,@"lineUpModel":lineUp}];
    }
}


@end
