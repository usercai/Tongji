//
//  VolleyBallSection+CoreDataProperties.h
//  VolleyballVoice
//
//  Created by Florence on 2017/6/19.
//  Copyright © 2017年 thc. All rights reserved.
//

#import "VolleyBallSection+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface VolleyBallSection (CoreDataProperties)

+ (NSFetchRequest<VolleyBallSection *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *competitionID;
@property (nullable, nonatomic, copy) NSString *competitionSectionID;
@property (nullable, nonatomic, copy) NSString *firstPositionA;
@property (nullable, nonatomic, copy) NSString *firstPositionB;
@property (nullable, nonatomic, copy) NSString *sectionEndTime;
@property (nullable, nonatomic, copy) NSString *sectionName;
@property (nullable, nonatomic, copy) NSString *sectionStartTime;
@property (nullable, nonatomic, copy) NSString *sectionTime;
@property (nullable, nonatomic, copy) NSString *servingSide;
@property (nullable, nonatomic, copy) NSString *startSide;
@property (nullable, nonatomic, copy) NSString *teamAID;
@property (nullable, nonatomic, copy) NSString *teamAMatchScore;
@property (nullable, nonatomic, copy) NSString *teamAName;
@property (nullable, nonatomic, copy) NSString *teamAPoint;
@property (nullable, nonatomic, copy) NSString *teamASubstitution;
@property (nullable, nonatomic, copy) NSString *teamASuspend;
@property (nullable, nonatomic, copy) NSString *teamBID;
@property (nullable, nonatomic, copy) NSString *teamBMatchScore;
@property (nullable, nonatomic, copy) NSString *teamBName;
@property (nullable, nonatomic, copy) NSString *teamBPoint;
@property (nullable, nonatomic, copy) NSString *teamBSubstitution;
@property (nullable, nonatomic, copy) NSString *teamBSuspend;

@end

NS_ASSUME_NONNULL_END
