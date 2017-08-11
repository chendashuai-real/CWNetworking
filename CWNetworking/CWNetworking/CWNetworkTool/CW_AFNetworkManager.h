//
//  CW_AFNetworkManager.h
//  CWNetworking
//
//  Created by 深圳策维科技有限公司 on 2017/8/11.
//  Copyright © 2017年 chenWei. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

#define KCW_AFNetworkManager [CW_AFNetworkManager shareSessionManager]

@interface CW_AFNetworkManager : AFHTTPSessionManager

+ (instancetype)shareSessionManager;


/**
 网络请求

 @param urls URL字符串
 @param method 请求方式
 @param parameters 请求参数
 @param progress 请求数据的进度
 @param successBlock 成功回调
 @param failedBlock 失败回调
 */
- (void)networkRequestWithUrls:(NSString *)urls withMethod:(NSString *)method withParameters:(NSDictionary *)parameters withProgress:(NSString *)progress withSuccessBlock:(void(^)(id responsnose))successBlock withFailedBlock:(void(^)(NSError *error))failedBlock;




@end
