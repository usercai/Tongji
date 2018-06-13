//
//  DataManager+Tool.h
//  VolleyballVoice
//
//  Created by mac on 2017/6/6.
//  Copyright © 2017年 thc. All rights reserved.
//

#import "DataManager.h"
#import "VolleyBallTechnical+CoreDataClass.h"
@interface DataManager (Tool)

typedef void (^Success)(id request);
typedef void (^Error)(NSString *error);

typedef enum _ChangeType {
    ChangeTypeAdd = 0,
    ChangeTypeDelete,
    ChangeTypeUpdate
} ChangeType;


/**
 查询
 
 @param entityName 表名
 @param key 属性名
 @param value 属性值
 @param suc 成功回调
 @param err 失败回调
 */
-(void)CheckWithEntityName:(NSString*)entityName Key:(NSString*)key Value:(NSString*)value Success:(Success)suc error:(Error)err;
/**
 查询表所有的数据
 
 @param entityName 表明
 @param suc 成功回调
 @param err 失败回调
 */
-(void)CheckWithEntityName:(NSString*)entityName Success:(Success)suc error:(Error)err;

-(void)adddict:(NSDictionary *)dict ListName:(NSString*)entityname Success:(Success)success Fail:(Error)fail;






#pragma mark ------- VolleyBallPlayers --------


/**
 运动员分数+1

 @param playerCode 运动员的编号
 @param suc 成功
 @param err 失败
 */
-(void)updateScoreWithPlayerCode:(NSString *)playerCode ChangeType:(ChangeType)changeType Success:(Success)suc error:(Error)err;

/**
 运动员有效+1

 @param playerCode 运动员编号
 @param suc 成功
 @param err 失败
 */
-(void)updateValidWithPlayerCode:(NSString *)playerCode ChangeType:(ChangeType)changeType Success:(Success)suc error:(Error)err;

/**
 运动员失误+1

 @param playerCode 运动员的编号
 @param suc 成功
 @param err 失败
 */
-(void)updateErrorWithPlayerCode:(NSString *)playerCode ChangeType:(ChangeType)changeType Success:(Success)suc error:(Error)err;


/**
 运动员一般+1

 @param playerID 运动员ID
 @param changeType 类型
 @param suc 成功
 @param err 失败
 */
-(void)updateCommonWithPlayerCode:(NSString *)playerID ChangeType:(ChangeType)changeType Success:(Success)suc error:(Error)err;



/**
 根据teamID查询表中的数据

 @param teamID 队伍iD
 @param suc 成功
 @param err 失败
 */
-(void)queryWithTeamID:(NSString *)teamID Success:(Success)suc error:(Error)err;



#pragma mark ------ VolleyBallTechnical -------------


/**
 像日志表添加一条数据

 @param reasult 结果
 @param item 动作
 */
-(void)addTechnicaDataWithReasult:(NSString *)reasult item:(NSString *)item;
/**
 将日志的最后一条删除
 */
-(void)deleteTechnicaData;


/**
 获取最后一条

 @return model
 */
-(VolleyBallTechnical *)selectLastDataWithTechnical;











//清表
- (void)removeData:(NSString*)name;
@end
