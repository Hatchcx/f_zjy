//
//  DataRequest.m
//  醉江月
//
//  Created by 黄启明 on 2017/1/3.
//  Copyright © 2017年 黄启明. All rights reserved.
//

#import "DataRequest.h"

@implementation DataRequest

+(void)getUrlStr:(NSString*)urlStr finish:(FinishBlock)finish andError:(ErrorBlock)errors
{
    
    AFHTTPRequestOperationManager* manager=[AFHTTPRequestOperationManager manager];
    
    //返回的数据
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    
    //
    [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        finish(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        errors(error);
    }];
}
+(void)postUrlstr:(NSString*)urlstr parmeters:(NSMutableDictionary*)dic finish:(FinishBlock)finish andError:(ErrorBlock)errors
{
    
    AFHTTPRequestOperationManager* manager=[AFHTTPRequestOperationManager manager];
    //返回的数据
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    //post
    [manager POST:urlstr parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        finish(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        errors(error);
    }];
    
}
@end
