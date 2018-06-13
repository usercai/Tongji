//
//  NSString+Category.h
//  VolleyballVoice
//
//  Created by mac on 2017/6/8.
//  Copyright © 2017年 thc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Category)
/*!
 * @brief 把格式化的JSON格式的字符串转换成字典
 * @param jsonString JSON格式的字符串
 * @return 返回字典
 */
- (NSDictionary *)dictionaryWithJsonString;
@end
