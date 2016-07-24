//
//  ViewController.m
//  LangPatch
//
//  Created by xing on 16/7/23.
//  Copyright © 2016年 ljx. All rights reserved.
//

#import "ViewController.h"
#import "LangPatchFileManager.h"
#define L(content,defaultString) [[LangPatchFileManager defaultUtil] internationalizationKey:content default:defaultString]

@interface ViewController ()
@property (nonatomic, strong) id content;

@end

@implementation ViewController

//全json替换语言包
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.content = [LangPatchFileManager findProjectResource:@"en_US" ofType:@".json"];
    NSLog(@"%@",L(@"HomePage_search_title", @"heeloo"));
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
