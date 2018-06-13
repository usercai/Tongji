//
//  NSDictionary+Json.h
//  VolleyballVoice
//
//  Created by mac on 2017/6/8.
//  Copyright © 2017年 thc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Json)
//字典转换成JSON字符串

/**
 这个方法转成的string后面会加\n

 @return <#return value description#>
 */
- (NSString *)JSONStringWithDic;

@end
