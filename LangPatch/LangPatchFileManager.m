//
//  LangPatchFileManager.m
//  LangPatch
//
//  Created by xing on 16/7/23.
//  Copyright © 2016年 ljx. All rights reserved.
//

#import "LangPatchFileManager.h"
#import "NSDictionary+ChangeNull.h"
#import "LangPatchNetWork.h"
#define GetCacheWithFileName(FileName) [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:FileName]
#define L(content,defaultString) [[LangPatchFileManager defaultUtil] internationalizationKey:content default:defaultString]


static NSString *CurrentLangeKey = @"LPCurrentLanguage";

@implementation LangPatchFileManager
+(instancetype) defaultUtil
{
    static LangPatchFileManager * sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[LangPatchFileManager alloc] init];
    });
    return sharedInstance;
}

/*
 *  初始化Language
 */
+(void)initUserLanguage{
    
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    
    NSString *string = [def valueForKey:CurrentLangeKey];
    
    if(string.length == 0){
        //获取系统当前语言版本(中文zh-Hans,英文en)
        
        NSArray* languages = [def objectForKey:@"AppleLanguages"];
        
        NSString *current = [languages objectAtIndex:0];
        
        string = current;
        
        [def setValue:current forKey:CurrentLangeKey];
        
        [def synchronize];//持久化，不加的话不会保存
    }
}


/**
 *  初始化自定义Language
 *
 *  @param Language Language
 */
+ (void)initWithLanguage:(NSString *)Language{
    [[NSUserDefaults standardUserDefaults] setObject:Language forKey:CurrentLangeKey];
}
#pragma mark - 初始化
//获取手机语言
+(NSString *)userLanguage{
    
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    
    NSString *language = [def valueForKey:CurrentLangeKey];
    
    return language;
}

- (void)setupCallBack:(void(^)(LangePathStartMode type, NSDictionary *data, NSError *error))success{
    //获取当前语言
    NSString *Language = [LangPatchFileManager userLanguage];
    NSLog(@"%@",Language);
    //容错
    if (Language != nil) {
        NSError *error = [NSError errorWithDomain:@"初始化语言失败" code:1000 userInfo:nil];
        !success?:success(LangePathStartModeUnknow,nil,error);
        return;
    }
//    
//    if ([self setupLanguageForm:LangePathDataTypeFromProject Resource:Language ofType:@"json"]) {
//        !success?:success(LangePathStartModeUnknow,nil,nil);
//    };
//    
    //unknow
//    !success?:success(LangePathStartModeUnknow,nil,nil);

    //分发请求
    
    NSLog(@"还会执行");
    
}



#pragma mark - 策略部分
#pragma mark - 项目目录读取
- (BOOL)setupFromProjectResource{
    NSString *currentLang = [LangPatchFileManager userLanguage];
    return [[LangPatchFileManager defaultUtil] setupLanguageForm:LangePathDataTypeFromProject Resource:currentLang ofType:@"json"];
}

- (BOOL)setupFromSandboxCache{
    NSString *currentLang = [LangPatchFileManager userLanguage];
    return [[LangPatchFileManager defaultUtil] setupLanguageForm:LangePathDataTypeFromCache Resource:currentLang ofType:@"json"];
}

#pragma mark - 执行
//从cache查找

//从项目查找
- (BOOL)setupLanguageForm:(LangePathDataType)DataType Resource:(NSString *)Resource ofType:(NSString *)Type{
    //先本地查找
    //项目文件查找
    id res ;
    switch (DataType) {
        case LangePathDataTypeFromProject:
            res = [self findFromProjectResource:Resource ofType:Type];
            break;
        case LangePathDataTypeFromCache:
            res = [self findFromCacheResource:Resource ofType:Type];
            break;
        default:
            break;
    }
    if (res!=nil) {
        return [self setupLanguageWithDictionary:res];
    }else{
        return NO;
    }
}

#pragma mark - private
#pragma mark 沙盒缓存查找
- (id)findFromCacheResource:(NSString *)Resource ofType:(NSString *)Type{
    NSString *langFileName = [NSString stringWithFormat:@"%@.%@",Resource,Type];
    NSString *url = GetCacheWithFileName(langFileName);
    NSLog(@"%@",url);
    return [self returnContentWithUrl:url];
}

#pragma mark 项目文件查找
- (id)findFromProjectResource:(NSString *)Resource ofType:(NSString *)Type{
    NSString *url = [[NSBundle mainBundle] pathForResource:Resource ofType:Type];
    return [self returnContentWithUrl:url];
}

#pragma mark 录入
- (BOOL)setupLanguageWithDictionary:(NSDictionary *)dict{
//    NSLog(@"%@",dict);
    if (![[dict allKeys] containsObject:@"content"]) {
        return NO;
    }
    NSDictionary *contentDict = [dict objectForKeyWithoutNull:@"content"];
    self.LangDict = [NSMutableDictionary dictionaryWithDictionary:contentDict];
    return !self.LangDict?NO:YES;
}

#pragma mark 输出
- (NSString *)internationalizationKey:(NSString *)Key default:(NSString *)Default{
    if (!self.LangDict || [self.LangDict isEqual:@""]) {
        return Default;
    }
    if ([[self.LangDict objectForKeyWithoutNull:Key] isEqualToString:@""]){
        return Default;
    }else{
        return [self.LangDict objectForKeyWithoutNull:Key];
    }
    
}

#pragma mark - private
#pragma mark - 根据url输出json
- (id)returnContentWithUrl:(NSString *)url{
    NSString *responseString =
    [[NSString alloc] initWithData:[NSData dataWithContentsOfFile:url] encoding:NSUTF8StringEncoding];
    NSData *data = [responseString dataUsingEncoding:NSUTF8StringEncoding];
    return [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
}

+ (NSString *)setupNowTime {
    NSDate *currentDate = [NSDate date];//获取当前时间，日期
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd"];
    NSString *dateString = [dateFormatter stringFromDate:currentDate];
    NSLog(@"dateString:%@",dateString);
    return dateString;
}

#pragma mark - layer
- (NSMutableDictionary *)LangDict{
    if (!_LangDict) {
        _LangDict = [NSMutableDictionary dictionary];
    }
    return _LangDict;
}

@end
