//
//  DataRequest.h
//  醉江月
//
//  Created by 黄启明 on 2017/1/3.
//  Copyright © 2017年 黄启明. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AFHTTPSessionManager.h"
#import "AFHTTPRequestOperationManager.h"

//声明成功和失败的block代码块的类型
typedef void (^FinishBlock)(id dataString);
typedef void (^ErrorBlock)(NSError*error);

@interface DataRequest : NSObject
@property(strong,nonatomic)FinishBlock finishBlock;//成功时返回的信息
@property(strong,nonatomic)ErrorBlock errorBlock;//失败时返回信息
//声明一个get请求的方法
+(void)getUrlStr:(NSString*)urlStr finish:(FinishBlock)finish andError:(ErrorBlock)errors;
//声明一个post请求的方法
+(void)postUrlstr:(NSString*)urlstr parmeters:(NSMutableDictionary*)dic finish:(FinishBlock)finish andError:(ErrorBlock)errors;

@end
