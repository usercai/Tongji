//
//  LineUpModel.h
//  VolleyballVoice
//
//  Created by Florence on 2017/6/19.
//  Copyright © 2017年 thc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LineUpModel : NSObject

@property(nonatomic,copy)NSString *playerID1;

@property(nonatomic,copy)NSString *playerID2;
@property(nonatomic,copy)NSString *playerID3;
@property(nonatomic,copy)NSString *playerID4;
@property(nonatomic,copy)NSString *playerID5;
@property(nonatomic,copy)NSString *playerID6;

@property(nonatomic,copy)NSString *playerName1;
@property(nonatomic,copy)NSString *playerName2;
@property(nonatomic,copy)NSString *playerName3;
@property(nonatomic,copy)NSString *playerName4;
@property(nonatomic,copy)NSString *playerName5;
@property(nonatomic,copy)NSString *playerName6;

@property(nonatomic,copy)NSString *playerRole1;
@property(nonatomic,copy)NSString *playerRole2;
@property(nonatomic,copy)NSString *playerRole3;
@property(nonatomic,copy)NSString *playerRole4;
@property(nonatomic,copy)NSString *playerRole5;
@property(nonatomic,copy)NSString *playerRole6;

@property(nonatomic,copy)NSString *position2;
@property(nonatomic,copy)NSString *position3;
@property(nonatomic,copy)NSString *position1;
@property(nonatomic,copy)NSString *position4;
@property(nonatomic,copy)NSString *position5;
@property(nonatomic,copy)NSString *position6;


@property(nonatomic,copy)NSString *substitution1;
@property(nonatomic,copy)NSString *substitution2;
@property(nonatomic,copy)NSString *substitution4;
@property(nonatomic,copy)NSString *substitution3;
@property(nonatomic,copy)NSString *substitution5;
@property(nonatomic,copy)NSString *substitution6;

@property(nonatomic,copy)NSString *teamID;
@property(nonatomic,copy)NSString *teamName;
@property(nonatomic,copy)NSString *sectionName;


-(id)initWithLineDic:(NSDictionary *)dic;


@end
