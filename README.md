# CWNetworking
封装原生网络请求和AFNetworking工具类, demo举例表单格式提交参数
@(原声网络请求NSURlsession)[封装AFNetworking]

**CWNetworking**是我在一个整个项目下来对网络请求的一点总结, 其中曲折坎坷也是多不胜数, 它集合了原生网络请求和第三方AFNetworking.  
特点概述：
 
- **原生网络请求** 
- **AFNetworking** 

-------------------



##CWNetworking简介

>封装原生网络请求和第三方AFNetworking,代码中有表单格式提交参数示例    —— [代码](https://github.com/LuckyChen73/CWNetworking.git)



### 使用
``` python
原生网络请求:
[KCWNetworkRequestCenter requestDataWithURL:@"" Parameters:parameter2 Method:@"POST" AuthorizationToken:token TimeoutInterval:10 ParameterPrefix:NO Progress:nil withSuccessBlock:^(id response) {
        NSLog(@"%@", response);
} withFailedBlock:^(NSError *error) {
        NSLog(@"%@", error);
 }];

第三方AFNetworking:
[KCW_AFNetworkManager networkRequestWithUrls:@"URLString" withMethod:@"GET" withParameters:nil withProgress:nil withSuccessBlock:^(id responsnose) {
        NSLog(@"adjhk: %@", responsnose);
} withFailedBlock:^(NSError *error) {
        NSLog(@"%@", error);
}];



```
### 注解

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
-- (void)requestDataWithURL:(NSString *)urls Parameters:(id)parameter Method:(NSString *)method AuthorizationToken:(NSString *)token TimeoutInterval:(NSInteger)timeInterval ParameterPrefix:(BOOL)parameterPrefix Progress:(NSString *)progress withSuccessBlock:(void (^)(id response))successBlock withFailedBlock:(void (^)(NSError *error))failedBlock;



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
