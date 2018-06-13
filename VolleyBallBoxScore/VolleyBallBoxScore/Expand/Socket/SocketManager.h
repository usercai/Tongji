//
//  SocketManager.h
//  VolleyballVoice
//
//  Created by mac on 2017/6/7.
//  Copyright © 2017年 thc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GCDAsyncSocket.h"

static NSInteger kMaxReconnection_time = 30;

enum{
    SocketOfflineByServer,// 服务器掉线，默认为0
    SocketOfflineByUser,  // 用户主动cut
};

typedef void(^requestSuccess)(NSDictionary * dic);
typedef void(^requestError)(NSString *error);

@interface SocketManager : NSObject

@property (nonatomic, strong)GCDAsyncSocket *socket;
@property (nonatomic,copy)requestSuccess success;
@property (nonatomic,copy)requestError error;

+(SocketManager *)shareIntance;

/**
 连接

 @param address iP
 @param port 端口
 */
-(void)ContentSocketAddress:(NSString*)address port:(NSString *)port;

/**
 断开连接
 */
-(void)disconnectSocket;

@end
