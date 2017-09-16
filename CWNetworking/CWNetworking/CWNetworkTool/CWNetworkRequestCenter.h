//
//  CWNetworkRequestCenter.h
//  CWNetworking
//
//  Created by 深圳策维科技有限公司 on 2017/8/11.
//  Copyright © 2017年 chenWei. All rights reserved.
//

#import <Foundation/Foundation.h>
// 单例宏定义
#define KCWNetworkRequestCenter [CWNetworkRequestCenter shareNetworkRequestCenter]


@interface CWNetworkRequestCenter : NSObject

+ (instancetype)shareNetworkRequestCenter;

+ (instancetype)defaultNetworkRequestCenter;

// 基地址
@property (nonatomic, copy) NSString *baseURL;


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
- (void)requestDataWithURL:(NSString *)urls Parameters:(id)parameter Method:(NSString *)method AuthorizationToken:(NSString *)token TimeoutInterval:(NSInteger)timeInterval ParameterPrefix:(BOOL)parameterPrefix Progress:(NSString *)progress withSuccessBlock:(void (^)(id response))successBlock withFailedBlock:(void (^)(NSError *error))failedBlock;


/**
 字符串转字典
 
 @param dataStr data字符串
 @param length 请求头字符串长度
 @return 返回字符串
 */
+ (NSDictionary *)getDictionaryWithDataString:(NSString *)dataStr withPrefixLenth:(NSInteger)length;



/**
 将数组转换为字典

 @param keyArray 键数组
 @param valueArray 值数组
 @return 返回字典
 */
+ (NSDictionary *)dictionaryWithKeyArray:(NSArray *)keyArray valueArray:(NSArray *)valueArray;



@end
