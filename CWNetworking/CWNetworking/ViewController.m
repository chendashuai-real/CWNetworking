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
    
    [self request2];
}


// 原声网络请求
- (void)request
{
    /*
     Urls: 请求地址
     Parameters: 请求参数, 有参数就拼接; 没有可以传nil
     Method: 请求方式
     TimeoutInterval: 超时时间
     IsHavePrefix: 返回的数据是否有前缀(拼接参数时是否有请求头); 如果有则返回字符串形式; 没有就返回字典样式
     对应的回调需要调用正确,否则会崩溃
     */
    [KCWNetworkRequestCenter requestDataWithUrls:@"URLString" withParameters:nil withMethod:@"POST" withTimeoutInterval:10 IsHavePrefix:NO];
    KCWNetworkRequestCenter.successDicBlock = ^(NSDictionary *dic) {
        
        NSLog(@"dic: %@", dic);
        
    };
    
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
