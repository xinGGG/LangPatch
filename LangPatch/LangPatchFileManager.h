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

typedef enum {
    LangePathDataTypeFromProject,           //来自项目文件
    LangePathDataTypeFromCache,           //来自沙盒Cache
}LangePathDataType;

@interface LangPatchFileManager : NSObject
@property (nonatomic,strong) NSMutableDictionary *LangDict;

+(instancetype) defaultUtil;

#pragma mark - 初始化阶段
//初始化Language
+ (void)initUserLanguage;
//初始化自定义Language
+ (void)initWithLanguage:(NSString *)Language;
// 获取历史语言
+ (NSString *)userLanguage;

- (void)setupCallBack:(void(^)(LangePathStartMode type, NSDictionary *data, NSError *error))success;

#pragma mark - 策略
- (BOOL)setupFromProjectResource;
- (BOOL)setupFromSandboxCache;

- (BOOL)setupLanguageForm:(LangePathDataType)DataType Resource:(NSString *)Resource ofType:(NSString *)Type;

//查找沙盒Cache文件
- (id)findFromCacheResource:(NSString *)Resource ofType:(NSString *)Type;
//查找NSBundle文件
- (id)findFromProjectResource:(NSString *)Resource ofType:(NSString *)Type;
//输入内容字典
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

@end
