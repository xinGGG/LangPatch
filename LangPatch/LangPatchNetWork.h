//
//  LangPatchNetWork.h
//  LangPatch
//
//  Created by xing on 16/7/25.
//  Copyright © 2016年 ljx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LangPatchNetWork : NSObject
+(instancetype) defaultUtil;

-(void)POST:(NSString *)URLString
 parameters:(id)parameters
    success:(void(^)(id responseObject))success
    failure:(void(^)(NSError *error))failure;

//请求未解析 用于单元测试
- (void)POST:(NSString *)URL RequestParams:(NSDictionary *)params FinishBlock:(void (^)(NSURLResponse *response, NSData *data, NSError *connectionError)) block;

@end
