//
//  NSString+Category.m
//  VolleyballVoice
//
//  Created by mac on 2017/6/8.
//  Copyright © 2017年 thc. All rights reserved.
//

#import "NSString+Category.h"

@implementation NSString (Category)
/*!
 * @brief 把格式化的JSON格式的字符串转换成字典
 * @return 返回字典
 */
- (NSDictionary *)dictionaryWithJsonString{
    NSError *error = nil;
    NSData *jsonData = [self dataUsingEncoding:NSUTF8StringEncoding];
    
    NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers | NSJSONReadingAllowFragments error:&error];
    
    if (jsonDict == nil) {
        NSLog(@"解析失败 error: %@", error);
        
        return nil;
    }
    return jsonDict;
}
@end
