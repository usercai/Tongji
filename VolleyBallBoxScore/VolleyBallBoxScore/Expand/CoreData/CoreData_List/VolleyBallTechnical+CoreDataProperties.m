//
//  VolleyBallTechnical+CoreDataProperties.m
//  VolleyballVoice
//
//  Created by Florence on 2017/6/19.
//  Copyright © 2017年 thc. All rights reserved.
//

#import "VolleyBallTechnical+CoreDataProperties.h"

@implementation VolleyBallTechnical (CoreDataProperties)

+ (NSFetchRequest<VolleyBallTechnical *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"VolleyBallTechnical"];
}

@dynamic desc;
@dynamic item;
@dynamic playerCode;
@dynamic playerId;
@dynamic reasult;
@dynamic score;
@dynamic section;
@dynamic teamFightID;
@dynamic technicalID;

@end
