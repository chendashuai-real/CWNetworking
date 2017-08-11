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
 网络请求数据
 
 @param urls URL地址
 @param parameter 传递的参数
 @param method 请求方式
 @param timeInterval 超时时长 默认是60s, 如果 <=0 或 > 60 则默认是60s
 @param isHavePrefix 是否有请求头
 */
- (void)requestDataWithUrls:(NSString *)urls withParameters:(nullable NSString *)parameter withMethod:(NSString *_Nullable)method withTimeoutInterval:(NSInteger)timeInterval IsHavePrefix:(BOOL)isHavePrefix
{
    NSMutableURLRequest *request;
    // POST 请求
    if ([method isEqualToString:@"POST"]) {
        NSURL *url = [NSURL URLWithString:urls];
        request = [NSMutableURLRequest requestWithURL:url];
        
        // 设置传送数据编码样式
        [request setValue:@"application/x-www-form-urlencoded; charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
        // 请求体 allowLossyConversion 允许数据缺失
        request.HTTPBody = [parameter dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
        
    }
    
    // GET 请求
    if ([method isEqualToString:@"GET"]) {
        // 拼接请求字符串
        NSString *urlStr = [NSString stringWithFormat:@"%@?%@", urls, parameter];
        NSURL *url = [NSURL URLWithString:urlStr];
        request = [NSMutableURLRequest requestWithURL:url];
        
    }
    
    // 请求方式
    request.HTTPMethod = method;
    //5s后请求超时（默认60s超时）
    if (timeInterval <= 0 || timeInterval > 60) {
        // 等于则默认60s超时
        request.timeoutInterval = 60;
    }else {
        request.timeoutInterval = timeInterval;
    }
    
    // 创建网络请求会话
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionTask *sessionTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error.code == NSURLErrorTimedOut || data == nil) {
            // 这里做一些网络请求超时和数据为空的一些操作
            [[NSNotificationCenter defaultCenter] postNotificationName:kNoDataNotification object:nil];
            return ;
        }
        
        // 是否有请求头
        if (isHavePrefix) {
            // 将二进制文件转化为字符串形式
            NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
            _successStrBlock(dataStr);
        } else {
            // json解析
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            _successDicBlock(dic);
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
