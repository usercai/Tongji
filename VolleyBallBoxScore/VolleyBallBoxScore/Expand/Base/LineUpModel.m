//
//  LineUpModel.m
//  VolleyballVoice
//
//  Created by Florence on 2017/6/19.
//  Copyright © 2017年 thc. All rights reserved.
//

#import "LineUpModel.h"

@implementation LineUpModel


-(id)initWithLineDic:(NSDictionary *)dic{

    self = [super init];
    
    if (self) {
     
        self.playerID1 = [NSString stringWithFormat:@"%@",dic[@"playerID1"]];
        self.playerID2 = [NSString stringWithFormat:@"%@",dic[@"playerID2"]];
        self.playerID3 = [NSString stringWithFormat:@"%@",dic[@"playerID3"]];
        self.playerID4 = [NSString stringWithFormat:@"%@",dic[@"playerID4"]];
        self.playerID5 = [NSString stringWithFormat:@"%@",dic[@"playerID5"]];
        self.playerID6 = [NSString stringWithFormat:@"%@",dic[@"playerID6"]];
        
        
        self.playerName1 = [NSString stringWithFormat:@"%@",dic[@"playerName1"]];
        self.playerName2 = [NSString stringWithFormat:@"%@",dic[@"playerName2"]];
        self.playerName3 = [NSString stringWithFormat:@"%@",dic[@"playerName3"]];
        self.playerName4 = [NSString stringWithFormat:@"%@",dic[@"playerName4"]];
        self.playerName5 = [NSString stringWithFormat:@"%@",dic[@"playerName5"]];
        self.playerName6 = [NSString stringWithFormat:@"%@",dic[@"playerName6"]];
        
        
        self.playerRole1 = [NSString stringWithFormat:@"%@",dic[@"playerRole1"]];
        self.playerRole2 = [NSString stringWithFormat:@"%@",dic[@"playerRole2"]];
        self.playerRole3 = [NSString stringWithFormat:@"%@",dic[@"playerRole3"]];
        self.playerRole4 = [NSString stringWithFormat:@"%@",dic[@"playerRole4"]];
        self.playerRole5 = [NSString stringWithFormat:@"%@",dic[@"playerRole5"]];
        self.playerRole6 = [NSString stringWithFormat:@"%@",dic[@"playerRole6"]];
        
        
        self.position1 = [NSString stringWithFormat:@"%@",dic[@"position1"]];
        self.position2 = [NSString stringWithFormat:@"%@",dic[@"position2"]];
        self.position3 = [NSString stringWithFormat:@"%@",dic[@"position3"]];
        self.position4 = [NSString stringWithFormat:@"%@",dic[@"position4"]];
        self.position5 = [NSString stringWithFormat:@"%@",dic[@"position5"]];
        self.position6 = [NSString stringWithFormat:@"%@",dic[@"position6"]];
        
        self.substitution1 = [NSString stringWithFormat:@"%@",dic[@"substitution1"]];
        self.substitution2 = [NSString stringWithFormat:@"%@",dic[@"substitution2"]];
        self.substitution3 = [NSString stringWithFormat:@"%@",dic[@"substitution3"]];
        self.substitution4 = [NSString stringWithFormat:@"%@",dic[@"substitution4"]];
        self.substitution5 = [NSString stringWithFormat:@"%@",dic[@"substitution5"]];
        self.substitution6 = [NSString stringWithFormat:@"%@",dic[@"substitution6"]];
        
        self.teamID = [NSString stringWithFormat:@"%@",dic[@"teamID"]];
        self.teamName = [NSString stringWithFormat:@"%@",dic[@"teamName"]];
        self.sectionName = [NSString stringWithFormat:@"%@",dic[@"sectionName"]];
        
    }
    return self;
}


@end
