//
//  SocketManager.m
//  VolleyballVoice
//
//  Created by mac on 2017/6/7.
//  Copyright © 2017年 thc. All rights reserved.
//

#import "SocketManager.h"
#import "HC_GCDTimerManager.h"
#import "GCDAsyncUdpSocket.h"
#import "JSON.h"

@interface SocketManager ()<GCDAsyncSocketDelegate>
@property (nonatomic, assign)BOOL isOnline;
@property (nonatomic, assign)NSInteger reconnection_time;

@property (nonatomic,strong)NSString * address;
@property (nonatomic,assign)NSInteger port;

@property (nonatomic,strong)NSString * address1;
@property (nonatomic,assign)NSInteger port1;
@property (nonatomic,strong)NSString * address2;
@property (nonatomic,assign)NSInteger port2;


@end
@implementation SocketManager

+(SocketManager *)shareIntance{

    static SocketManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[SocketManager alloc] initWithSocket];
    });
    return manager;
    
}

- (instancetype)initWithSocket
{
    self = [super init];
    if (self) {
        
        
        self.socket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue()];

    }
    return self;
}

/**
 连接

 @param address iP地址
 @param port 端口号
 */
-(void)ContentSocketAddress:(NSString*)address port:(NSString *)port{
    self.address = address;
    self.port = [port intValue];
    self.address1 = address;
    self.address2 = address;
    self.port1 = [port intValue];
    self.port2 = [port intValue];
    [self socketConnectHost];
    
}


/**
 断开连接
 */
-(void)disconnectSocket{

    [self.socket disconnect];
}


/**
 重连
 */
-(void)socketConnectHost{

    if (!self.isOnline) {
        NSError* error = nil;
        [self.socket connectToHost:self.address onPort:self.port error:&error];

    }

}

#pragma mark 代理
//连接成功
- (void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(uint16_t)port{

    self.isOnline = YES;
    kUserInfo.Wifi = YES;
    [self.socket readDataWithTimeout:-1 tag:0];

//    确认身份
    [[SocketManager shareIntance] GetTeamPlayerCode:Confirm Success:^(NSDictionary *dic) {
        NSLog(@"确认身份成功");
    } Error:^(NSString *error) {
        NSLog(@"确认身份失败");
    }];
    NSLog(@"连接成功");
    [VBHUD showHUDWithText:@"连接成功"];
    
}

//连接失败/断开连接
- (void)socketDidDisconnect:(GCDAsyncSocket*)sock withError:(NSError*)err {
    self.isOnline= NO;
    kUserInfo.Wifi = NO;
    
    
    if (self.address == self.address1) {
        self.address = self.address2;
    }else{
        self.address = self.address1;
    }
    
    [self socketConnectHost];

    NSLog(@"断开连接");
    
    [VBHUD showHUDWithText:@"连接失败"];
}

#pragma mark 数据发送成功
-(void)socket:(GCDAsyncSocket *)sock didWriteDataWithTag:(long)tag{
    NSLog(@"%s",__func__);
    
    //发送完数据手动读取，-1不设置超时
    [sock readDataWithTimeout:-1 tag:tag];
}

#pragma mark 读取数据
-(void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag{
    
    [self.socket readDataWithTimeout:-1 tag:0];

    NSMutableString *receiverStr = [[NSMutableString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"json字符串--------%@",receiverStr);
    NSDictionary *dicccc = [receiverStr JSONValue];
    NSString *code = [NSString stringWithFormat:@"%@",dicccc[@"code"]];
    NSLog(@"解析后--------%@",dicccc);
    
    if ([code isEqualToString:@"13"]) {
        
        NSDictionary *dic  = @{@"data":dicccc[@"data"]};
        
        [kNotificationCenter postNotificationName:@"MatchInfo" object:nil userInfo:dic];
    }
    
    if ([code isEqualToString:@"2"]) {
        
        NSDictionary *dic = @{@"data":dicccc[@"data"]};
        
        [kNotificationCenter postNotificationName:@"LineUp" object:nil userInfo:dic];
    }
}



@end
