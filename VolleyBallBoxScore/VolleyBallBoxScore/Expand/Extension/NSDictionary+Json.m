//
//  NSDictionary+Json.m
//  VolleyballVoice
//
//  Created by mac on 2017/6/8.
//  Copyright © 2017年 thc. All rights reserved.
//

#import "NSDictionary+Json.h"

@implementation NSDictionary (Json)
//字典转成成JSON字符串
- (NSString *)JSONStringWithDic{
    NSError *error = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self
                                                       options:0
                                                         error:&error];
    
    if (jsonData == nil) {
        NSLog(@"fail to get JSON from dictionary: %@, error: %@", self, error);
        return nil;
    }
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    return [NSString stringWithFormat:@"%@\n",jsonString];
}

@end
