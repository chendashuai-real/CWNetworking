# CWNetworking
将原声网络请求和AFNetworking请求集中在一个工具类中
@(原声网络请求NSURlsession)[封装AFNetworking]

**CWNetworking**是我在一个整个项目下来对网络请求的一点总结, 其中曲折坎坷也是多不胜数, 它集合了原生网络请求和第三方AFNetworking.  
特点概述：
 
- **原生网络请求** 
- **AFNetworking** 

-------------------



##CWNetworking简介

>将原生网络请求和第三方AFNetworking整合,让你多一种选择。    —— [代码](https://github.com/LuckyChen73/CWNetworking.git)



### 使用
``` python
原生网络请求:
[KCWNetworkRequestCenter requestDataWithUrls:@"URLString" withParameters:nil withMethod:@"POST" withTimeoutInterval:10 IsHavePrefix:NO];                     KCWNetworkRequestCenter.successDicBlock = ^(NSDictionary *dic) {
        
        NSLog(@"dic: %@", dic);
        
};

第三方AFNetworking:
[KCW_AFNetworkManager networkRequestWithUrls:@"URLString" withMethod:@"GET" withParameters:nil withProgress:nil withSuccessBlock:^(id responsnose) {
        
        NSLog(@"adjhk: %@", responsnose);
        
} withFailedBlock:^(NSError *error) {
        
        NSLog(@"%@", error);
}];



```
### 注解

/**
 网络请求数据
 
 @param urls URL地址  建议:如果你的url地址通用, 那么就在pch文件中宏定义基地址
 @param parameter 传递的参数
 @param method 请求方式
 @param timeInterval 超时时长 默认是60s, 如果 <=0 或 > 60 则默认是60s
 @param isHavePrefix 是否有请求头
 */
 
 -- (void)requestDataWithUrls:(nullable NSString *)urls withParameters:(nullable NSString *)parameter withMethod:(NSString *_Nullable)method withTimeoutInterval:(NSInteger)timeInterval IsHavePrefix:(BOOL)isHavePrefix;



/**
 网络请求
 
 @param urls URL字符串
 @param method 请求方式
 @param parameters 请求参数
 @param progress 请求数据的进度
 @param successBlock 成功回调
 @param failedBlock 失败回调
 */
 
-- (void)networkRequestWithUrls:(NSString *)urls withMethod:(NSString *)method withParameters:(NSDictionary *)parameters withProgress:(NSString *)progress withSuccessBlock:(void(^)(id responsnose))successBlock withFailedBlock:(void(^)(NSError *error))failedBlock;
