//
//  LangPatchFileManager.h
//  LangPatch
//
//  Created by xing on 16/7/23.
//  Copyright © 2016年 ljx. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef enum {
    LangePathStartModeUnknow,           //未知错误
    LangePathStartModeNeedUpdate,       //第一次启动 或者需要设置内容
    LangePathStartModeNoNeedUpdate      //不需要更新
}LangePathStartMode;
@interface LangPatchFileManager : NSObject
@property (nonatomic,strong) NSMutableDictionary *LangDict;
+(instancetype) defaultUtil;
//初始化Language
+ (void)initUserLanguage;
//初始化自定义Language
+ (void)initWithLanguage:(NSString *)Language;
// 获取历史语言
+ (NSString *)userLanguage;

#pragma mark - 初始化阶段
- (void)setupCallBack:(void(^)(LangePathStartMode type, NSDictionary *data, NSError *error))success;

#pragma mark - 执行阶段
/**
 *  读取项目json文件
 *
 *  @param Resource 文件名
 *  @param Type     文件类型
 *
 *  @return 返回json内容
 */
+ (id)findProjectResource:(NSString *)Resource ofType:(NSString *)Type;
/**
 *  本地储存语言包
 *
 *  @param dict 存放语言包Content
 */
- (BOOL)setupLanguageWithDictionary:(NSDictionary *)dict;
/**
 *  根据key输出多语言value
 *
 *  @param Key     语言key
 *  @param Default 语言value
 *
 *  @return 对用语言的内容
 */
- (NSString *)internationalizationKey:(NSString *)Key default:(NSString *)Default;
//(void(^)(NSError *error))failure;

@end
