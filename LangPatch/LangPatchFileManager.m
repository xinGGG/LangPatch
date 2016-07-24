//
//  LangPatchFileManager.m
//  LangPatch
//
//  Created by xing on 16/7/23.
//  Copyright © 2016年 ljx. All rights reserved.
//

#import "LangPatchFileManager.h"
#import "NSDictionary+ChangeNull.h"


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
    NSLog(@"执行脚本");
    NSString *Language = [LangPatchFileManager userLanguage];
    if (Language != nil) {
        NSError *error = [NSError errorWithDomain:@"初始化语言失败" code:1000 userInfo:nil];
        !success?:success(LangePathStartModeUnknow,nil,error);
        return;
    }
    
    NSLog(@"还会执行");
    
}




//储存当前语言包时效性
- (void)markLanguageTime:(NSString *)Time{
    
}

#pragma mark - 执行
- (BOOL)setupProjectResource:(NSString *)Resource ofType:(NSString *)Type{
    id res = [self findProjectResource:Resource ofType:Type];
    if (res!=nil) {
        return [self setupLanguageWithDictionary:res];
    }else{
        return NO;
    }
}

#pragma mark - private
- (id)findProjectResource:(NSString *)Resource ofType:(NSString *)Type{
    NSString *url = [[NSBundle mainBundle] pathForResource:Resource ofType:Type];
    NSString *responseString =
    [[NSString alloc] initWithData:[NSData dataWithContentsOfFile:url] encoding:NSUTF8StringEncoding];
    NSData *data = [responseString dataUsingEncoding:NSUTF8StringEncoding];
    id content = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    return content;
}


- (BOOL)setupLanguageWithDictionary:(NSDictionary *)dict{
    
    NSLog(@"%@",dict);
    if (![[dict allKeys] containsObject:@"content"]) {
        return NO;
    }
    NSDictionary *contentDict = [dict objectForKeyWithoutNull:@"content"];
    NSLog(@"%@",contentDict);
    self.LangDict = [NSMutableDictionary dictionaryWithDictionary:contentDict];
    return !self.LangDict?NO:YES;
}

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

#pragma mark private
- (NSString *)setupNowTime {
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
