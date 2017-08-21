//
//  CWNetworkRequestCenter.m
//  CWNetworking
//
//  Created by 深圳策维科技有限公司 on 2017/8/11.
//  Copyright © 2017年 chenWei. All rights reserved.
//

#import "CWNetworkRequestCenter.h"

@implementation CWNetworkRequestCenter

+ (instancetype)shareNetworkRequestCenter
{
    static CWNetworkRequestCenter *requestCenter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        requestCenter = [[CWNetworkRequestCenter alloc]init];
    });
    return requestCenter;
}

+ (instancetype)defaultNetworkRequestCenter
{
    static CWNetworkRequestCenter *requestCenter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        requestCenter = [[CWNetworkRequestCenter alloc]init];
    });
    return requestCenter;
}



/**
 网络请求
 
 @param urls URL
 @param parameter 参数
 @param method 请求方式
 @param token 认证token
 @param timeInterval 超时时长
 @param parameterPrefix 参数是否有前缀
 @param progress 进度
 @param successBlock 成功回调
 @param failedBlock 失败回调
 */
- (void)requestDataWithURL:(NSString *)urls Parameters:(id)parameter Method:(NSString *)method AuthorizationToken:(NSString *)token TimeoutInterval:(NSInteger)timeInterval ParameterPrefix:(BOOL)parameterPrefix Progress:(NSString *)progress withSuccessBlock:(void (^)(id response))successBlock withFailedBlock:(void (^)(NSError *error))failedBlock
{
    NSURL *url = [NSURL URLWithString:urls];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod: method];
    request.timeoutInterval = timeInterval;
    
    if ([parameter isKindOfClass:[NSString class]]) { // 是string类型
        request.HTTPBody = [parameter dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    }else if ([parameter isKindOfClass:[NSDictionary class]]) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:parameter options:NSJSONWritingPrettyPrinted error:nil];
        NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        request.HTTPBody = [dataStr dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    }
    
    if (token != nil) {
        NSString *value = [NSString stringWithFormat:@"%@",token];
        [request addValue:value forHTTPHeaderField:@"Authorization"];
    }
    
    [request setValue:@"application/x-www-form-urlencoded;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionTask *sessionTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            failedBlock(error);
            return ;
        }
        if (data == nil) {
            successBlock(@"data为空");
            return ;
        }
        if (parameterPrefix) { // 传参数有前缀
            NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
            successBlock(dataStr);
        }else {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            successBlock(dic);
        }
    }];
    [sessionTask resume];
    
}


/**
 字符串转字典
 
 @param dataStr data字符串
 @param length 请求头字符串长度
 @return 返回字符串
 */
+ (NSDictionary *)getDictionaryWithDataString:(NSString *)dataStr withPrefixLenth:(NSInteger)length
{
    NSString * cutString;
    NSData *stringData;
    
    if (length > 0) { // 有请求头
        cutString = [dataStr substringFromIndex:length];
        stringData = [cutString dataUsingEncoding:NSUTF8StringEncoding];
        
    }else { // 无请求头
        stringData = [dataStr dataUsingEncoding:NSUTF8StringEncoding];
    }
    
    if (stringData == nil) { return nil; }
    
    NSDictionary *backDic = [NSJSONSerialization JSONObjectWithData:stringData options:NSJSONReadingMutableContainers error:nil];
    
    return backDic;
}















@end
