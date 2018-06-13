//
//  VolleyBallPlayers+CoreDataProperties.m
//  
//
//  Created by Florence on 2017/6/20.
//
//

#import "VolleyBallPlayers+CoreDataProperties.h"

@implementation VolleyBallPlayers (CoreDataProperties)

+ (NSFetchRequest<VolleyBallPlayers *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"VolleyBallPlayers"];
}

@dynamic competitionID;
@dynamic competitionPlayerID;
@dynamic errorNum;
@dynamic isDelete;
@dynamic isOnBench;
@dynamic isSelect;
@dynamic playerBirthday;
@dynamic playerCode;
@dynamic playerGender;
@dynamic playerID;
@dynamic playerName;
@dynamic playerRole;
@dynamic scoreNum;
@dynamic teamID;
@dynamic validNum;
@dynamic commonNum;

@end
