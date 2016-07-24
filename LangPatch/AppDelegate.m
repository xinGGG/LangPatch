//
//  AppDelegate.m
//  LangPatch
//
//  Created by xing on 16/7/23.
//  Copyright © 2016年 ljx. All rights reserved.
//

#import "AppDelegate.h"
#import "LangPatchFileManager.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //根据设备语言初始化语言
    [LangPatchFileManager initUserLanguage];
    
[[LangPatchFileManager defaultUtil] setupCallBack:^(LangePathStartMode type, NSDictionary *data, NSError *error) {
    NSLog(@"%u",type);
    NSLog(@"%@",error);
    switch (type) {
        case LangePathStartModeUnknow:
            [LangPatchFileManager  setupLanguageWithDictionary:[LangPatchFileManager findProjectResource:@"en_US" ofType:@".json"] ];
            break;
        case LangePathStartModeNeedUpdate:
            
            break;
        case LangePathStartModeNoNeedUpdate:
            
            break;
        default:
            break;
    }
}];
    //自定义默认语言
//    [LangPatchFileManager initWithLanguage:@"en-US"];
    
//    [LangPatchFileManager setupCallback:^(JPCallbackType type, NSDictionary *data, NSError *error) {
//        switch (type) {
//            case JPCallbackTypeUpdate: {
//                NSLog(@"updated %@ %@", data, error);
//                break;
//            }
//            case JPCallbackTypeRunScript: {
//                NSLog(@"run script %@ %@", data, error);
//                break;
//            }
//            default:
//                break;
//        }
//    }];

    //开始获取语言
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
