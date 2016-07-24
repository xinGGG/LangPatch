//
//  ViewController.m
//  LangPatch
//
//  Created by xing on 16/7/23.
//  Copyright © 2016年 ljx. All rights reserved.
//

#import "ViewController.h"
#import "LangPatchFileManager.h"
#import "DownloadTool.h"
#define L(content,defaultString) [[LangPatchFileManager defaultUtil] internationalizationKey:content default:defaultString]

@interface ViewController ()
@property (nonatomic, strong) id content;

@end

@implementation ViewController

//全json替换语言包
- (void)viewDidLoad {
    [super viewDidLoad];
    DownloadTool *tool =  [[DownloadTool alloc] init];
    [tool DownloadWithUrl:@"http://localhost:8080/public/en_US.json" success:^(id responseObject) {
        [[LangPatchFileManager defaultUtil] setupFromSandboxCache];
        NSLog(@"%@",L(@"HomePage_search_title", @"heeloo"));
    } failure:^(NSError *error) {
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
