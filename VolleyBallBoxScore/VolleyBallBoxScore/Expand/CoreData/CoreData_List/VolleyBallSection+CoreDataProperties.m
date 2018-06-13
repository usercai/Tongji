//
//  VolleyBallSection+CoreDataProperties.m
//  VolleyballVoice
//
//  Created by Florence on 2017/6/19.
//  Copyright © 2017年 thc. All rights reserved.
//

#import "VolleyBallSection+CoreDataProperties.h"

@implementation VolleyBallSection (CoreDataProperties)

+ (NSFetchRequest<VolleyBallSection *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"VolleyBallSection"];
}

@dynamic competitionID;
@dynamic competitionSectionID;
@dynamic firstPositionA;
@dynamic firstPositionB;
@dynamic sectionEndTime;
@dynamic sectionName;
@dynamic sectionStartTime;
@dynamic sectionTime;
@dynamic servingSide;
@dynamic startSide;
@dynamic teamAID;
@dynamic teamAMatchScore;
@dynamic teamAName;
@dynamic teamAPoint;
@dynamic teamASubstitution;
@dynamic teamASuspend;
@dynamic teamBID;
@dynamic teamBMatchScore;
@dynamic teamBName;
@dynamic teamBPoint;
@dynamic teamBSubstitution;
@dynamic teamBSuspend;

@end
