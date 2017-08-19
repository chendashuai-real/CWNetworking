//
//  CW_AFNetworkManager.m
//  CWNetworking
//
//  Created by 深圳策维科技有限公司 on 2017/8/11.
//  Copyright © 2017年 chenWei. All rights reserved.
//

#import "CW_AFNetworkManager.h"

@implementation CW_AFNetworkManager

+ (instancetype)shareSessionManager
{
    static CW_AFNetworkManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[CW_AFNetworkManager alloc]init];
        
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        // 接收数据的格式
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/plain", @"text/json",@"application/json", nil];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
    });
    return manager;
}


/**
 网络请求
 
 @param urls URL字符串
 @param method 请求方式
 @param parameters 请求参数
 @param progress 请求数据的进度
 @param successBlock 成功回调
 @param failedBlock 失败回调
 */
- (void)networkRequestWithUrls:(NSString *)urls withMethod:(NSString *)method withParameters:(id)parameters withProgress:(NSString *)progress withSuccessBlock:(void(^)(id responsnose))successBlock withFailedBlock:(void(^)(NSError *error))failedBlock
{
    //在没获取到更深入一层的方法之前，判断后再去使用GET 或者 POST方法。
    if ([method isEqualToString:@"GET"]) {
        NSString *urlStr = [NSString stringWithFormat:@"%@?%@",urls, parameters];
        
        [self GET:urlStr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject) {
            
            successBlock(responseObject);
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            failedBlock(error);
        }];
    }
    
    if ([method isEqualToString:@"POST"]) {
        [self POST:urls parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject) {
            successBlock(responseObject);
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            failedBlock(error);
        }];
    }

}




@end
