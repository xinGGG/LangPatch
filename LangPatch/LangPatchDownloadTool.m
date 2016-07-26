//
//  DownTool.m
//  DragonPassEn
//
//  Created by xing on 16/4/28.
//  Copyright © 2016年 Ray. All rights reserved.
//
#define GetCacheWithFileName(FileName) [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:FileName]
#define L(content,defaultString) [[LangPatchFileManager defaultUtil] internationalizationKey:content default:defaultString]

#import "LangPatchDownloadTool.h"
@interface LangPatchDownloadTool()<NSURLConnectionDelegate>
@property (nonatomic, assign) NSInteger recLenth;
@property (nonatomic, strong) NSMutableData *data;
@end
@implementation LangPatchDownloadTool

- (void)DownloadWithUrl:(NSString *)PathUrl
                success:(void(^)(NSString *FullPath))success
                failure:(void(^)(NSError *error))failure{
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURL *url = [NSURL URLWithString:PathUrl];
    
    NSURLSessionDownloadTask *downloadTask = [session downloadTaskWithURL:url completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            !failure?:failure(error);
            return ;
        }
        
        NSString *fullPath = GetCacheWithFileName(response.suggestedFilename);
        [[NSFileManager defaultManager] moveItemAtURL:location toURL:[NSURL fileURLWithPath:fullPath] error:nil];
        NSLog(@"%@  ----  %@",fullPath,[NSThread currentThread]);
        !success?:success(fullPath);
    }];;
    
    [downloadTask resume];
}
@end
