//
//  VolleyBallTechnical+CoreDataProperties.h
//  VolleyballVoice
//
//  Created by Florence on 2017/6/19.
//  Copyright © 2017年 thc. All rights reserved.
//

#import "VolleyBallTechnical+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface VolleyBallTechnical (CoreDataProperties)

+ (NSFetchRequest<VolleyBallTechnical *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *desc;
@property (nullable, nonatomic, copy) NSString *item;
@property (nullable, nonatomic, copy) NSString *playerCode;
@property (nullable, nonatomic, copy) NSString *playerId;
@property (nullable, nonatomic, copy) NSString *reasult;
@property (nullable, nonatomic, copy) NSString *score;
@property (nullable, nonatomic, copy) NSString *section;
@property (nullable, nonatomic, copy) NSString *teamFightID;
@property (nullable, nonatomic, copy) NSString *technicalID;

@end

NS_ASSUME_NONNULL_END
