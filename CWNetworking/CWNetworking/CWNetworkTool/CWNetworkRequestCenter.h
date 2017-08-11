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
// 没有数据通知
#define kNoDataNotification @"noDataNotification"

typedef void(^returnBlock)(NSString *);

typedef void(^backBlock)(NSDictionary *);


@interface CWNetworkRequestCenter : NSObject

+ (instancetype)shareNetworkRequestCenter;

+ (instancetype)defaultNetworkRequestCenter;


/**
 网络请求数据
 
 @param urls URL地址
 @param parameter 传递的参数
 @param method 请求方式
 @param timeInterval 超时时长 默认是60s, 如果 <=0 或 > 60 则默认是60s
 @param isHavePrefix 是否有请求头
 */
- (void)requestDataWithUrls:(NSString *)urls withParameters:(nullable NSString *)parameter withMethod:(NSString *_Nullable)method withTimeoutInterval:(NSInteger)timeInterval IsHavePrefix:(BOOL)isHavePrefix;


// 请求成功回调

// 如果后台返回数据中有请求头,那使用这个回调
@property(nonatomic,copy)returnBlock successStrBlock;

// 如果后台返回数据是json样式,那调用这个回调
@property(nonatomic,copy)backBlock successDicBlock;


/**
 字符串转字典

 @param dataStr data字符串
 @param length 请求头字符串长度
 @return 返回字符串
 */
+ (NSDictionary *)getDictionaryWithDataString:(NSString *)dataStr withPrefixLenth:(NSInteger)length;





@end
