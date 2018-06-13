//
//  VolleyBallPlayers+CoreDataProperties.h
//  
//
//  Created by Florence on 2017/6/20.
//
//

#import "VolleyBallPlayers+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface VolleyBallPlayers (CoreDataProperties)

+ (NSFetchRequest<VolleyBallPlayers *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *competitionID;
@property (nullable, nonatomic, copy) NSString *competitionPlayerID;
@property (nullable, nonatomic, copy) NSString *errorNum;
@property (nullable, nonatomic, copy) NSString *isDelete;
@property (nullable, nonatomic, copy) NSString *isOnBench;
@property (nullable, nonatomic, copy) NSString *isSelect;
@property (nullable, nonatomic, copy) NSString *playerBirthday;
@property (nullable, nonatomic, copy) NSString *playerCode;
@property (nullable, nonatomic, copy) NSString *playerGender;
@property (nullable, nonatomic, copy) NSString *playerID;
@property (nullable, nonatomic, copy) NSString *playerName;
@property (nullable, nonatomic, copy) NSString *playerRole;
@property (nullable, nonatomic, copy) NSString *scoreNum;
@property (nullable, nonatomic, copy) NSString *teamID;
@property (nullable, nonatomic, copy) NSString *validNum;
@property (nullable, nonatomic, copy) NSString *commonNum;

@end

NS_ASSUME_NONNULL_END
