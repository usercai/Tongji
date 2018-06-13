//
//  NSObject+Property.m
//  VolleyballVoice
//
//  Created by mac on 2017/6/7.
//  Copyright © 2017年 thc. All rights reserved.
//

#import "NSObject+Property.h"

@implementation NSObject (Property)


-(NSString *)toString{
    if (self == nil) {
        return @"";
    }else{
        NSString *str = [NSString stringWithFormat:@"%@",self];
        return str;
    }
}


-(void)setProperty:(id)model{

    u_int count;
    // 传递count的地址过去 &count
    objc_property_t *properties  =class_copyPropertyList([self class], &count);
    //arrayWithCapacity的效率稍微高那么一丢丢
    NSMutableArray *propertiesArray = [NSMutableArray arrayWithCapacity:count];
    
    NSDictionary * dic = [model ganPropertyand];
    for (int i = 0; i < count ; i++)
    {
        //此刻得到的propertyName为c语言的字符串
        const char* propertyName =property_getName(properties[i]);
        //此步骤把c语言的字符串转换为OC的NSString
        [propertiesArray addObject: [NSString stringWithUTF8String: propertyName]];
        NSString *key = [NSString stringWithUTF8String:propertyName];
        NSString *setKey = [NSString stringWithFormat:@"%@",key];
        setKey = setKey.capitalizedString;
        setKey = [NSString stringWithFormat:@"set%@:", setKey];           //拼接set方法字符串
        SEL setSel = NSSelectorFromString(setKey);
        //调用setter方法
        if ([self respondsToSelector:setSel])
        {
            id value = @"";
            if ([dic objectForKey:key]!=nil) {
                value = [dic objectForKey:key];
            }
            [self performSelectorOnMainThread:setSel withObject:value waitUntilDone:[NSThread isMainThread]];
        }
        NSLog(@"%s",propertyName);
    }
    //class_copyPropertyList底层为C语言，所以我们一定要记得释放properties
    // You must free the array with free().
    free(properties);

}


-(void)setPropertyWithDic:(NSDictionary*)dict{
    
    u_int count;
    // 传递count的地址过去 &count
    objc_property_t *properties  =class_copyPropertyList([self class], &count);
    //arrayWithCapacity的效率稍微高那么一丢丢
    NSMutableArray *propertiesArray = [NSMutableArray arrayWithCapacity:count];
    
    for (int i = 0; i < count ; i++){
        
        //此刻得到的propertyName为c语言的字符串
        const char* propertyName =property_getName(properties[i]);
        //此步骤把c语言的字符串转换为OC的NSString
        [propertiesArray addObject: [NSString stringWithUTF8String: propertyName]];
        
        NSString *key = [NSString stringWithUTF8String:propertyName];
        NSString *setKey = [NSString stringWithFormat:@"%@",key];
//        setKey = setKey.capitalizedString;
        
        setKey = [NSString stringWithFormat:@"set%@:", setKey];           //拼接set方法字符串
        NSString * setkey1 = [NSString stringWithFormat:@"set%@:",setKey.capitalizedString];
        SEL setSel = NSSelectorFromString(setKey);
        SEL setsel1 = NSSelectorFromString(setkey1);
        //调用setter方法
        if ([self respondsToSelector:setSel])
        {
            id value = @"";
            if ([dict objectForKey:key]!=nil) {
                value = [dict objectForKey:key];
            }
            [self performSelectorOnMainThread:setSel withObject:value waitUntilDone:[NSThread isMainThread]];
        }else if ([self respondsToSelector:setsel1]){
            id value = @"";
            if ([dict objectForKey:key]!=nil) {
                value = [dict objectForKey:key];
            }
            [self performSelectorOnMainThread:setSel withObject:value waitUntilDone:[NSThread isMainThread]];
        }
    }
    
    //class_copyPropertyList底层为C语言，所以我们一定要记得释放properties
    // You must free the array with free().
    free(properties);
    
}




-(NSDictionary*)ganPropertyand{

    u_int count;
    // 传递count的地址过去 &count
    objc_property_t *properties  =class_copyPropertyList([self class], &count);
    //arrayWithCapacity的效率稍微高那么一丢丢
    NSMutableDictionary * dict = [[NSMutableDictionary alloc] init];
    NSMutableArray *propertiesArray = [NSMutableArray arrayWithCapacity:count];
    
    for (int i = 2; i <= count ; i++)
    {
        //此刻得到的propertyName为c语言的字符串
        const char* propertyName =property_getName(properties[i]);
        
        //此步骤把c语言的字符串转换为OC的NSString
        NSString * property = [NSString stringWithUTF8String:propertyName];
        
        
        
        
        NSLog(@"%s",propertyName);
    }
    //class_copyPropertyList底层为C语言，所以我们一定要记得释放properties
    // You must free the array with free().
    free(properties);
    
    return dict;
}


/** 获取属性列表 */
-(void)getProperties{
    u_int count = 0;
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    
    for (int i = 0; i < count; i++) {
        const char *propertyName = property_getName(properties[i]);
        
        const char *attributes = property_getAttributes(properties[i]);
        NSString *str = [NSString stringWithCString:propertyName encoding:NSUTF8StringEncoding];
        NSString *attributesStr = [NSString stringWithCString:attributes encoding:NSUTF8StringEncoding];
        
        //获取成员内容的Ivar
        Ivar ivar = class_getInstanceVariable([self class], [str UTF8String]);
        
        if (ivar == nil) {
            ivar = class_getInstanceVariable([self class], [[NSString stringWithFormat:@"_%@",str] UTF8String]);
        }
        
        id propertyVal = object_getIvar(self, ivar);
        NSLog(@"propertyVal = %@ --值",propertyVal);
        
        
        
//        NSLog(@"propertyName : %@", str);
//        NSLog(@"attributesStr : %@", attributesStr);
    }
}

-(void)getIvars{

    unsigned int methodCount = 0;
    Ivar * ivars = class_copyIvarList([self class], &methodCount);
    for (unsigned int i = 0; i < methodCount; i ++) {
        Ivar ivar = ivars[i];
        const char * name = ivar_getName(ivar);
        const char * type = ivar_getTypeEncoding(ivar);
        NSLog(@"Person拥有的成员变量的类型为%s，名字为 %s ",type, name);
    }
    free(ivars);
}

/** 修改变量 */
- (id)updateVariable
{
    //获取当前类
    id theClass = [self class];
    //初始化
    id otherClass = [[theClass alloc] init];
    
    unsigned int count = 0;
    //获取属性列表
    Ivar *members = class_copyIvarList([otherClass class], &count);
    
    //遍历属性列表
    for (int i = 0 ; i < count; i++) {
        Ivar var = members[i];
        //获取变量名称
        const char *memberName = ivar_getName(var);
        //获取变量类型
        const char *memberType = ivar_getTypeEncoding(var);
        
        NSLog(@"%s----%s", memberName, memberType);
        
        Ivar ivar = class_getInstanceVariable([otherClass class], memberName);
        
        NSString *typeStr = [NSString stringWithCString:memberType encoding:NSUTF8StringEncoding];
        //判断类型
        if ([typeStr isEqualToString:@"@\"NSString\""]) {
            //修改值
            object_setIvar(otherClass, ivar, @"abc");
        }else{
            object_setIvar(otherClass, ivar, [NSNumber numberWithInt:99]);
        }
    }
    return otherClass;
}


///通过运行时获取当前对象的所有属性的名称，以数组的形式返回
- (NSArray *) allPropertyNames{
    ///存储所有的属性名称
    NSMutableArray *allNames = [[NSMutableArray alloc] init];
    
    ///存储属性的个数
    unsigned int propertyCount = 0;
    
    ///通过运行时获取当前类的属性
    objc_property_t *propertys = class_copyPropertyList([self class], &propertyCount);
    
    //把属性放到数组中
    for (int i = 0; i < propertyCount; i ++) {
        ///取出第一个属性
        objc_property_t property = propertys[i];
        
        const char * propertyName = property_getName(property);
        
        [allNames addObject:[NSString stringWithUTF8String:propertyName]];
    }
    
    ///释放
    free(propertys);
    
    return allNames;
}

#pragma mark -- 通过字符串来创建该字符串的Setter方法，并返回
- (SEL) creatGetterWithPropertyName: (NSString *) propertyName{
    
    //1.返回get方法: oc中的get方法就是属性的本身
    return NSSelectorFromString(propertyName);
}


- (void)displayCurrentModleProperty{

    //获取实体类的属性名
    NSArray *array = [self allPropertyNames];

    //拼接参数
    NSMutableString *resultString = [[NSMutableString alloc] init];

    for (int i = 0; i < array.count; i ++) {

         //获取get方法
         SEL getSel = [self creatGetterWithPropertyName:array[i]];

         if ([self respondsToSelector:getSel]) {

             //获得类和方法的签名
             NSMethodSignature *signature = [self methodSignatureForSelector:getSel];

             //从签名获得调用对象
             NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];

             //设置target
             [invocation setTarget:self];

             //设置selector
             [invocation setSelector:getSel];

             //接收返回的值
             NSObject *__unsafe_unretained returnValue = nil;

             //调用
             [invocation invoke];
 
             //接收返回值
             [invocation getReturnValue:&returnValue];
 
             [resultString appendFormat:@"%@\n", returnValue];
         }
     }
    
     NSLog(@"%@", resultString);
     
}

@end
