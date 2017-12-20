//
//  HomeAPI.m
//  MortgageCalculator-Swift
//
//  Created by gozap on 2017/11/28.
//  Copyright © 2017年 com.longdai. All rights reserved.
//

#import "HomeAPI.h"

@implementation HomeAPI
+(NSURLResponse *)requestapi{
    NSString *appcode = @"e6e6d859575041a59434643cb86ad657";
    NSString *host = @"http://toutiao-ali.juheapi.com";
    NSString *path = @"/toutiao/index";
    NSString *method = @"GET";
    NSString *querys = @"?type=type";
    NSString *url = [NSString stringWithFormat:@"%@%@%@",  host,  path , querys];
    NSString *bodys = @"";
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString: url]  cachePolicy:1  timeoutInterval:  5];
    request.HTTPMethod  =  method;
    [request addValue:  [NSString  stringWithFormat:@"APPCODE %@" ,  appcode]  forHTTPHeaderField:  @"Authorization"];
    
    //3 创建会话对象  默认的会话
    NSURLSession *session = [NSURLSession sharedSession];
    
    //4 创建网络任务
    //NSURLSessionTask 抽象类  使用其子类 dataTask,uploadTask,downloadTask
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        //判断错误
        if (error) {
            NSLog(@"请求出错:%@", error);
            
            return;
        }
     
        NSError *jsonError = nil;
        
        //Json解析
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&jsonError];
        NSString *jsonText = [NSString stringWithFormat:@"%@", dic];
        
    }];
    
    //5 开启任务
    [dataTask resume];
    
    
    return nil;
    
    
    
//    [requestSession dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//        NSLog(@"Response object: %@" , response);
//        return response;
//    }];
//
//    NSURLSessionDataTask *task = [requestSession dataTaskWithRequest:request
//                                completionHandler:^(NSData * _Nullable body , NSURLResponse * _Nullable response, NSError * _Nullable error) {
//                                                       NSLog(@"Response object: %@" , response);
//
//                                                       return response;
//                                                       NSString *bodyString = [[NSString alloc] initWithData:body encoding:NSUTF8StringEncoding];
//
//                                                       //打印应答中的body
//                                                       NSLog(@"Response body: %@" , bodyString);
//                                                   }];
    
    //[task resume];
}
@end
