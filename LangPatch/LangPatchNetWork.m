//
//  LangPatchNetWork.m
//  LangPatch
//
//  Created by xing on 16/7/25.
//  Copyright © 2016年 ljx. All rights reserved.
//

#import "LangPatchNetWork.h"

@implementation LangPatchNetWork
//http://localhost:8080/home/index.html
+(instancetype) defaultUtil
{
    static LangPatchNetWork * sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[LangPatchNetWork alloc] init];
    });
    return sharedInstance;
}
-(void)POST:(NSString *)URLString
 parameters:(id)parameters
    success:(void(^)(id responseObject))success
    failure:(void(^)(NSError *error))failure{
    [self POST:@"http://localhost:8080/home/index.html" RequestParams:nil FinishBlock:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (connectionError) {
            !failure?:failure(connectionError);
        }
        if (data!=nil && data.length>0) {
            NSString *resString =
            [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSData *resData = [resString dataUsingEncoding:NSUTF8StringEncoding];
            
              id res1 =  [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            id res = [NSJSONSerialization JSONObjectWithData:resData options:NSJSONReadingMutableContainers error:nil];
            !success?:success(res);
        }else{
            !failure?:failure(connectionError);
        }
    }];

}
//post异步请求封装函数
- (void)POST:(NSString *)URL RequestParams:(NSDictionary *)params FinishBlock:(void (^)(NSURLResponse *response, NSData *data, NSError *connectionError)) block{
    //把传进来的URL字符串转变为URL地址
    NSURL *url = [NSURL URLWithString:URL];
    //请求初始化，可以在这针对缓存，超时做出一些设置
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestReloadIgnoringCacheData
                                                       timeoutInterval:20];
    //解析请求参数，用NSDictionary来存参数，通过自定义的函数parseParams把它解析成一个post格式的字符串
    NSString *parseParamsResult = [self parseParams:params];
    NSData *postData = [parseParamsResult dataUsingEncoding:NSUTF8StringEncoding];
    
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:postData];
    
    //创建一个新的队列（开启新线程）
    NSOperationQueue *queue = [NSOperationQueue new];
    //发送异步请求，请求完以后返回的数据，通过completionHandler参数来调用
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:queue
                           completionHandler:block];
}


//把NSDictionary解析成post格式的NSString字符串
- (NSString *)parseParams:(NSDictionary *)params{
    NSString *keyValueFormat;
    NSMutableString *result = [NSMutableString new];
    //实例化一个key枚举器用来存放dictionary的key
    NSEnumerator *keyEnum = [params keyEnumerator];
    id key;
    while (key = [keyEnum nextObject]) {
        keyValueFormat = [NSString stringWithFormat:@"%@=%@&",key,[params valueForKey:key]];
        [result appendString:keyValueFormat];
        NSLog(@"post()方法参数解析结果：%@",result);
    }
    return result;
}

@end
