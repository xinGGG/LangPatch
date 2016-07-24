//
//  NSDictionary+ChangeNull.h
//  BasePro
//
//  Created by xing on 16/7/23.
//  Copyright © 2016年 ljx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (ChangeNull)

-(id)objectForKeyWithoutNull:(id)aKey;

@end
