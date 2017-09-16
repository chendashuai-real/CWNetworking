//
//  ViewController.m
//  CWNetworking
//
//  Created by 深圳策维科技有限公司 on 2017/8/11.
//  Copyright © 2017年 深圳策维科技有限公司. All rights reserved.
//

#import "ViewController.h"

#import "CWNetworkRequestCenter.h"
#import "CW_AFNetworkManager.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self request];
    
    [self dicTest];
}


// 原声网络请求
- (void)request
{
    
    /**
     网络请求
     
     @param urls URL
     @param parameter 参数
     @param method 请求方式
     @param token 认证token
     @param timeInterval 超时时长
     @param parameterPrefix 参数是否有前缀, 有YES, 无NO
     @param progress 进度
     @param successBlock 成功回调
     @param failedBlock 失败回调
     */
    // 这里举例: 表单传递参数请求网络数据
    
    // 字符串表单参数传递: encData: 网关认证 encKey
    NSString *parameter1 = [NSString stringWithFormat:@"encData={\"key\":\"%@\"}&encKey=",@""];
    
    
    
    // 数组表单参数传递: encData: 网关认证 encKey
    // 需要先将数组反序列化
    NSError *error = nil;
    NSMutableArray *dataArr = [NSMutableArray array];
    
    // 将字典转换成 NSData
    NSData *data = [NSJSONSerialization dataWithJSONObject:@"你的字典" options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    
    // 如果有多个字典就循环遍历添加到数组中
    [dataArr addObject:jsonStr];

    NSString *parameter2 = [NSString stringWithFormat:@"encData={\"key\":{\"key\":\"%@\",\"key\":[%@]}}&encKey=",@"你的value",@"你需要上传的数组"];
    
    
    
    
    
    // 如果token需要验证就传入token, 不需要就传 nil
    NSString *token = @"获取你的token";
    
    // ParameterPrefix: 传递的参数是否有前缀, 有数据就会以字符串的形式返回; 无就是以字典的形式返回
    [KCWNetworkRequestCenter requestDataWithURL:@"" Parameters:parameter2 Method:@"POST" AuthorizationToken:token TimeoutInterval:10 ParameterPrefix:NO Progress:nil withSuccessBlock:^(id response) {
        NSLog(@"%@", response);
    } withFailedBlock:^(NSError *error) {
        NSLog(@"%@", error);
    }];
    
    
    
}

// 键值数组转换为字典
- (void)dicTest
{
    NSArray *keyArr = @[@"",@"",@"loginName",@"ap"];
    NSArray *valueArr = @[@"",@"321123",@"",@""];
    NSDictionary *dic = [CWNetworkRequestCenter dictionaryWithKeyArray:keyArr valueArray:valueArr];
    // 将字典 转成 JSON数据
    NSData *data1 = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:NULL];
    // 将JSON数据 转成 字符串
    NSString *upString = [[NSString alloc] initWithData: data1 encoding: NSUTF8StringEncoding];
    
    NSLog(@"adskh: %@", upString);
    
    
}


// AFN 请求
- (void)request2
{
    
    [KCW_AFNetworkManager networkRequestWithUrls:@"URLString" withMethod:@"GET" withParameters:nil withProgress:nil withSuccessBlock:^(id responsnose) {
        
        NSLog(@"adjhk: %@", responsnose);
        
    } withFailedBlock:^(NSError *error) {
        
        NSLog(@"%@", error);
    }];
    
    
    
    
}

@end
