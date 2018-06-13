//
//  NSData+Category.m
//  VolleyballVoice
//
//  Created by mac on 2017/6/16.
//  Copyright © 2017年 thc. All rights reserved.
//

#import "NSData+Category.h"

@implementation NSData (Category)

-(NSDictionary*)JsonDic{

    NSError *err;

    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:self
                                                        options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
    
}
@end
