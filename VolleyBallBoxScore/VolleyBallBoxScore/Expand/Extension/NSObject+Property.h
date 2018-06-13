//
//  NSObject+Property.h
//  VolleyballVoice
//
//  Created by mac on 2017/6/7.
//  Copyright © 2017年 thc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Property)

-(void)setProperty:(id)model;

/** 获取属性列表 */
-(void)getProperties;


/** 修改变量 */
- (id)updateVariable;

-(void)setPropertyWithDic:(NSDictionary*)dict;


-(NSString *)toString;
@end
