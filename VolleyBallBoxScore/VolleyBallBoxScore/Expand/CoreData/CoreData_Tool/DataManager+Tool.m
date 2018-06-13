//
//  DataManager+Tool.m
//  VolleyballVoice
//
//  Created by mac on 2017/6/6.
//  Copyright © 2017年 thc. All rights reserved.
//

#import "DataManager+Tool.h"
#import "VolleyBallPlayers+CoreDataClass.h"

@implementation DataManager (Tool)

-(void)adddict:(NSDictionary *)dict ListName:(NSString*)entityname Success:(Success)success Fail:(Error)fail{

    id player  = [NSEntityDescription insertNewObjectForEntityForName:entityname inManagedObjectContext:[DataManager shareIntance].managedObjectContext];
    [player setPropertyWithDic:dict];
    //保存到永久层
    [[DataManager shareIntance] saveContext];
    
}

/**
 查询

 @param entityName 表名
 @param key 属性名
 @param value 属性值
 @param suc 成功回调
 @param err 失败回调
 */
-(void)CheckWithEntityName:(NSString*)entityName Key:(NSString*)key Value:(NSString*)value Success:(Success)suc error:(Error)err{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        // 初始化一个查询请求
        //  NSFetchRequest *request = [[NSFetchRequest alloc] init];
        // 设置要查询的实体
        // request.entity = [NSEntityDescription entityForName:@"Student" inManagedObjectContext:self.managedContext];
        
        //以上代码简写成下边
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:entityName];
        
//        // 设置排序（按照age降序）
        NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:key ascending:NO];
        request.sortDescriptors = [NSArray arrayWithObject:sort];
//         设置条件过滤(搜索name中包含字符串"zhang"的记录，注意：设置条件过滤时，数据库SQL语句中的%要用*来代替，所以%Itcast-1%应该写成*zhang*)
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%@ like %@", key,[NSString stringWithFormat:@"*%@*",value]];
        request.predicate = predicate;
        
        // 执行请求
        NSError *error = nil;
        NSArray *objs = [[DataManager shareIntance].managedObjectContext executeFetchRequest:request error:&error];
        if (error) {
            [NSException raise:@"查询错误" format:@"%@", [error localizedDescription]];
            err([error localizedDescription]);
        }
        
        if (objs.count != 0) {
            
            suc(objs);
        }else{
            err(@"搜索结果为空");
        }

        
    });
}


/**
 查询表所有的数据

 @param entityName 表明
 @param suc 成功回调
 @param err 失败回调
 */
-(void)CheckWithEntityName:(NSString*)entityName Success:(Success)suc error:(Error)err{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        // 初始化一个查询请求
        //  NSFetchRequest *request = [[NSFetchRequest alloc] init];
        // 设置要查询的实体
        // request.entity = [NSEntityDescription entityForName:@"Student" inManagedObjectContext:self.managedContext];
        
        //以上代码简写成下边
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:entityName];
        

        //         设置条件过滤(搜索name中包含字符串"zhang"的记录，注意：设置条件过滤时，数据库SQL语句中的%要用*来代替，所以%Itcast-1%应该写成*zhang*)
//        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"select * from %@", entityName];
//        request.predicate = predicate;
        
        // 执行请求
        NSError *error = nil;
        NSArray *objs = [[DataManager shareIntance].managedObjectContext executeFetchRequest:request error:&error];
        if (error) {
            [NSException raise:@"查询错误" format:@"%@", [error localizedDescription]];
            err([error localizedDescription]);
        }
        
        if (objs.count != 0) {
            
            suc(objs);
        }else{
            err(@"搜索结果为空");
        }
    });
}



#pragma mark ------- VolleyBallPlayers --------


-(void)updateScoreWithPlayerCode:(NSString *)playerCode ChangeType:(ChangeType)changeType Success:(Success)suc error:(Error)err{

    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"VolleyBallPlayers"];

    NSPredicate *pre = [NSPredicate predicateWithFormat:@"playerID = %@",playerCode];
    request.predicate = pre;

    NSError *error = nil;
    NSArray *objs = [[DataManager shareIntance].managedObjectContext executeFetchRequest:request error:&error];
    if (error) {
        [NSException raise:@"查询错误" format:@"%@", [error localizedDescription]];
    }
    
    if (objs.count != 0) {
        VolleyBallPlayers *model = objs[0];
        NSInteger scorenum = [model.scoreNum integerValue];
        
        if (changeType == ChangeTypeUpdate) {
            scorenum = scorenum+1;
        }else if(changeType == ChangeTypeDelete){
            if (scorenum != 0) {
                scorenum = scorenum-1;
            }
        }
        NSString *newScore = [NSString stringWithFormat:@"%ld",(long)scorenum];
        model.scoreNum = newScore;
        
        suc(@"修改成功");
      
    }else{
        err(@"搜索结果为空");
    }

    BOOL success = [[DataManager shareIntance].managedObjectContext save:&error];
    
    if (!success) {
        [NSException raise:@"访问数据库错误" format:@"%@",[error localizedDescription]];
        err(@"访问数据库错误");
    }else{
    
        [kNotificationCenter postNotificationName:@"messageInfo" object:nil userInfo:nil];
    
    }
}
-(void)updateValidWithPlayerCode:(NSString *)playerCode ChangeType:(ChangeType)changeType Success:(Success)suc error:(Error)err{
    
        NSLog(@"pla--------------------%@",playerCode);
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"VolleyBallPlayers"];
        
        NSPredicate *pre = [NSPredicate predicateWithFormat:@"playerID = %@",playerCode];
        request.predicate = pre;
        
        NSError *error = nil;
        NSArray *objs = [[DataManager shareIntance].managedObjectContext executeFetchRequest:request error:&error];
        if (error) {
            [NSException raise:@"查询错误" format:@"%@", [error localizedDescription]];
        }
        
        if (objs.count != 0) {
            VolleyBallPlayers *model = objs[0];
            NSInteger scorenum = [model.validNum integerValue];
            
            if (changeType == ChangeTypeUpdate) {
                scorenum = scorenum+1;
            }else if(changeType == ChangeTypeDelete){
                if (scorenum != 0) {
                    scorenum = scorenum-1;
                }
            }
            NSString *newScore = [NSString stringWithFormat:@"%ld",(long)scorenum];
            model.validNum = newScore;
            
            suc(@"修改成功");
            
        }else{
            err(@"搜索结果为空");
        }
        
        BOOL success = [[DataManager shareIntance].managedObjectContext save:&error];
        
        if (!success) {
            [NSException raise:@"访问数据库错误" format:@"%@",[error localizedDescription]];
            err(@"访问数据库错误");
        }else{
            
            [kNotificationCenter postNotificationName:@"messageInfo" object:nil userInfo:nil];
            
        }
    
    
}

-(void)updateErrorWithPlayerCode:(NSString *)playerCode ChangeType:(ChangeType)changeType Success:(Success)suc error:(Error)err{
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"VolleyBallPlayers"];
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"playerID = %@",playerCode];
    request.predicate = pre;
    NSError *error = nil;
    NSArray *objs = [[DataManager shareIntance].managedObjectContext executeFetchRequest:request error:&error];
    if (error) {
        [NSException raise:@"查询错误" format:@"%@", [error localizedDescription]];
    }
    
    if (objs.count != 0) {
        VolleyBallPlayers *model = objs[0];
        NSInteger errnum = [model.errorNum integerValue];
        
        if (changeType == ChangeTypeUpdate) {
            errnum = errnum+1;
        }else if(changeType == ChangeTypeDelete){
            if (errnum != 0) {
                errnum = errnum-1;
            }
        }
        NSString *newerr = [NSString stringWithFormat:@"%ld",(long)errnum];
        model.errorNum = newerr;
        
        suc(@"修改成功");
        
    }else{
        err(@"搜索结果为空");
    }
    
    BOOL success = [[DataManager shareIntance].managedObjectContext save:&error];
    
    if (!success) {
        [NSException raise:@"访问数据库错误" format:@"%@",[error localizedDescription]];
        err(@"访问数据库错误");
    }else{
        
        [kNotificationCenter postNotificationName:@"messageInfo" object:nil userInfo:nil];
        
    }
}
-(void)updateCommonWithPlayerCode:(NSString *)playerID ChangeType:(ChangeType)changeType Success:(Success)suc error:(Error)err{

    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"VolleyBallPlayers"];
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"playerID = %@",playerID];
    request.predicate = pre;
    NSError *error = nil;
    NSArray *objs = [[DataManager shareIntance].managedObjectContext executeFetchRequest:request error:&error];
    if (error) {
        [NSException raise:@"查询错误" format:@"%@", [error localizedDescription]];
    }
    
    if (objs.count != 0) {
        VolleyBallPlayers *model = objs[0];
        NSInteger commonNum = [model.commonNum integerValue];
        
        if (changeType == ChangeTypeUpdate) {
            commonNum = commonNum+1;
        }else if(changeType == ChangeTypeDelete){
            if (commonNum != 0) {
                commonNum = commonNum-1;
            }
        }
        NSString *newerr = [NSString stringWithFormat:@"%ld",(long)commonNum];
        model.commonNum = newerr;
        
        suc(@"修改成功");
        
    }else{
        err(@"搜索结果为空");
    }
    
    BOOL success = [[DataManager shareIntance].managedObjectContext save:&error];
    
    if (!success) {
        [NSException raise:@"访问数据库错误" format:@"%@",[error localizedDescription]];
        err(@"访问数据库错误");
    }else{
        
        [kNotificationCenter postNotificationName:@"messageInfo" object:nil userInfo:nil];
        
    }
}
-(void)queryWithTeamID:(NSString *)teamID Success:(Success)suc error:(Error)err{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"VolleyBallPlayers"];
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"teamID = %@",teamID];
    request.predicate = pre;
    NSError *error = nil;
    NSArray *objs = [[DataManager shareIntance].managedObjectContext executeFetchRequest:request error:&error];
    if (error) {
        [NSException raise:@"查询错误" format:@"%@", [error localizedDescription]];
    }
    
    if (objs.count != 0) {
       
        NSMutableArray *lineupArr = [NSMutableArray array];
        
        NSDictionary *lineUp = [kUserDefault objectForKey:@"lineUpModel"];

        for (VolleyBallPlayers *model in objs) {
        
            NSLog(@"%@",model.playerCode);
            
            
            if ([model.playerID isEqualToString:[NSString stringWithFormat:@"%@",lineUp[@"playerID1"]]]) {
                NSLog(@"----%@",lineUp[@"position1"]);
                
                [lineupArr addObject:model];
            }
            if ([model.playerID isEqualToString:[NSString stringWithFormat:@"%@",lineUp[@"playerID2"]]]) {
                NSLog(@"----%@",lineUp[@"position2"]);
                
                [lineupArr addObject:model];
            }
            
            if ([model.playerID isEqualToString:[NSString stringWithFormat:@"%@",lineUp[@"playerID3"]]]) {
                NSLog(@"----%@",lineUp[@"position3"]);
                
                [lineupArr addObject:model];
            }
            
            if ([model.playerID isEqualToString:[NSString stringWithFormat:@"%@",lineUp[@"playerID4"]]]) {
                NSLog(@"----%@",lineUp[@"position4"]);
                
                [lineupArr addObject:model];
            }
            
            if ([model.playerID isEqualToString:[NSString stringWithFormat:@"%@",lineUp[@"playerID5"]]]) {
                NSLog(@"----%@",lineUp[@"position5"]);
                
                [lineupArr addObject:model];
            }
            
            if ([model.playerID isEqualToString:[NSString stringWithFormat:@"%@",lineUp[@"playerID6"]]]) {
                NSLog(@"----%@",lineUp[@"position6"]);
                
                [lineupArr addObject:model];
            }
        
        }
        suc(lineupArr);
        
    }else{
        err(@"搜索结果为空");
    }
}

#pragma mark ---------- VolleyBallTechnical -----------------
-(void)addTechnicaDataWithReasult:(NSString *)reasult item:(NSString *)item{
    

    if (kUserInfo.playerID) {
        NSMutableDictionary *dic = [@{
                                      @"technicalID":@"1",
                                      @"teamFightID":kUserInfo.teamFightID,
                                      @"section":kUserInfo.section,
                                      @"score":@"1",
                                      @"reasult":reasult,
                                      @"playerId":kUserInfo.playerID,
                                      @"playerCode":kUserInfo.playerCode,
                                      @"item":item,
                                      @"desc":@"hahah"
                                      } mutableCopy];
        
        [self addDataWithTechnicalDic:dic];
        
    }else{
    
        [VBHUD showHUDWithText:@"请先获取球员数据"];
    }
    

    
}

-(void)addDataWithTechnicalDic:(NSDictionary *)dict{
    id technical  = [NSEntityDescription insertNewObjectForEntityForName:@"VolleyBallTechnical" inManagedObjectContext:[DataManager shareIntance].managedObjectContext];
    [technical setPropertyWithDic:dict];
    //保存到永久层
    NSString *result = dict[@"reasult"];
    if ([result isEqualToString:@"得分"]) {
        [[DataManager shareIntance] updateScoreWithPlayerCode:dict[@"playerId"] ChangeType:ChangeTypeUpdate Success:^(id request) {
            [kNotificationCenter postNotificationName:@"playerInfochange" object:nil userInfo:nil];
            
        } error:^(NSString *error) {
            
        }];
    }else if ([result isEqualToString:@"有效"]){
    
        
        [[DataManager shareIntance] updateValidWithPlayerCode:dict[@"playerId"] ChangeType:ChangeTypeUpdate Success:^(id request) {
            [kNotificationCenter postNotificationName:@"playerInfochange" object:nil userInfo:nil];
            
        } error:^(NSString *error) {
            
        }];
    
    }else if([result isEqualToString:@"失误"]){
        [[DataManager shareIntance] updateErrorWithPlayerCode:dict[@"playerId"] ChangeType:ChangeTypeUpdate Success:^(id request) {
            [kNotificationCenter postNotificationName:@"playerInfochange" object:nil userInfo:nil];
            
        } error:^(NSString *error) {
            
        }];
    }else{
    
        [[DataManager shareIntance] updateCommonWithPlayerCode:dict[@"playerId"] ChangeType:ChangeTypeUpdate Success:^(id request) {
            [kNotificationCenter postNotificationName:@"playerInfochange" object:nil userInfo:nil];
        } error:^(NSString *error) {
            
        }];
    }
    [[DataManager shareIntance] saveContext];
}

-(void)deleteTechnicaData{

    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"VolleyBallTechnical"];
    
    [request setIncludesPropertyValues:NO];
    //请求数据
    NSArray *objs = [[DataManager shareIntance].managedObjectContext executeFetchRequest:request error:nil];
    
    
    NSLog(@"%@",objs);
    
    
    if (objs.count!=0) {
        
        
        VolleyBallTechnical *model = objs.lastObject;
        NSLog(@"%@",model.reasult);
        if ([model.reasult isEqualToString:@"得分"]) {
         
            [[DataManager shareIntance] updateScoreWithPlayerCode:model.playerId ChangeType:ChangeTypeDelete Success:^(id request) {
                [kNotificationCenter postNotificationName:@"playerInfochange" object:nil userInfo:nil];
                
                [[DataManager shareIntance].managedObjectContext deleteObject:model];
            } error:^(NSString *error) {
                
            }];
            
        }else if ([model.reasult isEqualToString:@"有效"]){
        
            [[DataManager shareIntance] updateValidWithPlayerCode:model.playerId ChangeType:ChangeTypeDelete Success:^(id request) {
                [kNotificationCenter postNotificationName:@"playerInfochange" object:nil userInfo:nil];
                [[DataManager shareIntance].managedObjectContext deleteObject:model];
            } error:^(NSString *error) {
                
            }];
        
        }else if([model.reasult isEqualToString:@"失误"]){
            [[DataManager shareIntance] updateErrorWithPlayerCode:model.playerId ChangeType:ChangeTypeDelete Success:^(id request) {
                [kNotificationCenter postNotificationName:@"playerInfochange" object:nil userInfo:nil];
                [[DataManager shareIntance].managedObjectContext deleteObject:model];
            } error:^(NSString *error) {
                
            }];
        }else{
            [[DataManager shareIntance] updateCommonWithPlayerCode:model.playerId ChangeType:ChangeTypeDelete Success:^(id request) {
                [kNotificationCenter postNotificationName:@"playerInfochange" object:nil userInfo:nil];
                [[DataManager shareIntance].managedObjectContext deleteObject:model];
            } error:^(NSString *error) {
                
            }];
        }
    }
    [[DataManager shareIntance] saveContext];
}


-(VolleyBallTechnical *)selectLastDataWithTechnical{

    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"VolleyBallTechnical"];
    
    [request setIncludesPropertyValues:NO];
    //请求数据
    NSArray *objs = [[DataManager shareIntance].managedObjectContext executeFetchRequest:request error:nil];
    
    if (objs.count == 0) {
        return nil;
    }else{
        VolleyBallTechnical *model = objs.lastObject;
        return model;
    }
}







//清表
- (void)removeData:(NSString*)name{
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:name];
    
//    //查到到你要删除的数据库中的对象
//    NSPredicate *predic = [NSPredicate predicateWithFormat:@"name like %@",@"*name*"];
//    request.predicate = predic;

    [request setIncludesPropertyValues:NO];
    //请求数据
    NSArray *objs = [[DataManager shareIntance].managedObjectContext executeFetchRequest:request error:nil];
    
    if (objs.count!=0) {
        for (id stu in objs) {
            [[DataManager shareIntance].managedObjectContext deleteObject:stu];
        }
    }
    
    [[DataManager shareIntance] saveContext];
}

@end
