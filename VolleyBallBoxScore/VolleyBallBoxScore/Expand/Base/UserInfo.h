//
//  UserInfo.h
//  VoiceTest
//
//  Created by Florence on 2017/6/2.
//  Copyright © 2017年 AllureTeartop. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LineUpModel.h"
@interface UserInfo : NSObject

@property(nonatomic,copy)NSString *localgrammerId;

@property(nonatomic,copy)NSString *cloudGrammerid;

@property(nonatomic,copy)NSString *playerCode;
@property(nonatomic,copy)NSString *technicalID;
@property(nonatomic,copy)NSString *teamFightID;
@property(nonatomic,copy)NSString *section;
@property(nonatomic,copy)NSString *playerID;
@property(nonatomic,assign)NSInteger playerTag;


@property(nonatomic,copy)NSString *teamID;
@property(nonatomic,copy)NSString *teamAID;
@property(nonatomic,copy)NSString *teamAName;
@property(nonatomic,copy)NSString *teamBID;
@property(nonatomic,copy)NSString *teamBName;
@property(nonatomic,strong)NSDictionary *matchInfo;


@property(nonatomic,strong)NSDictionary *lineUpModelA;
@property(nonatomic,strong)NSDictionary *lineUpModelB;
@property(nonatomic,strong)NSDictionary *lineUpModel;

@property (nonatomic,assign)BOOL Wifi;

-(void)getMatchInfo:(NSDictionary *)matchInfo;


-(void)getLineUpInfo:(NSDictionary *)lineUp;










/**
 *  单粒
 *
 *  @return userinfo实例
 */
+(UserInfo *)sharedInstance;





@end
