//
//  DownTool.h
//  DragonPassEn
//
//  Created by xing on 16/4/28.
//  Copyright © 2016年 Ray. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DownloadTool : NSObject
- (void)DownloadWithUrl:(NSString *)PathUrl
                success:(void(^)(NSString *FullPath))success
                failure:(void(^)(NSError *error))failure;
@end
