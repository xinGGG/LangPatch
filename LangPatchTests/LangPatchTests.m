
//
//  LangPatchTests.m
//  LangPatchTests
//
//  Created by xing on 16/7/23.
//  Copyright © 2016年 ljx. All rights reserved.
//
#import "AFTestCase.h"
#import "LangPatchFileManager.h"
#import "LangPatchDownloadTool.h"
@interface LangPatchTests : AFTestCase
@property (nonatomic, strong) id content;
@end

@implementation LangPatchTests

- (void)setUp {
    [super setUp];
    [LangPatchFileManager initWithLanguage:nil];

    // Put setup code here. This method is called before the invocation of each test method in the class.
    
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

#pragma mark - 初始化
//校验初始化是否正确
- (void)testHistoryWithNormal{
    [LangPatchFileManager initUserLanguage];
    XCTAssertTrue([[LangPatchFileManager userLanguage] isEqualToString:@"en-US"]);
}

- (void)testHistoryWithUser{
    [LangPatchFileManager initWithLanguage:@"zh-CN"];
    XCTAssertTrue([[LangPatchFileManager userLanguage] isEqualToString:@"zh-CN"]);
}

//校验是否能查找项目文件
- (void)testLocaltion{
    BOOL findLocaltionFormProject = [[LangPatchFileManager defaultUtil] setupFromProjectResource];
    XCTAssertTrue(findLocaltionFormProject);
}

#pragma mark - 执行
- (void)testOutPut{
    self.content = [[LangPatchFileManager defaultUtil] findFromProjectResource:@"en_US" ofType:@"json"];
    BOOL checkBool = [[LangPatchFileManager defaultUtil] setupLanguageWithDictionary:self.content];
    XCTAssertTrue(checkBool);
    XCTAssertTrue([L(@"HomePage_search_title", @"heeloo") isEqualToString:@"Enter country/city/airport"]);
}

//读本地
- (void)testUnknow{
    BOOL checkBool = [[LangPatchFileManager defaultUtil] setupFromProjectResource];
    XCTAssertTrue(checkBool);
}

- (void)testNeedUpdate{
   DownloadTool *tool = [[DownloadTool alloc] init];
    [tool DownloadWithUrl:@"http://localhost:8080/public/en_US.json" success:^(NSString *FullPath) {
//        + (id)findFromCacheResource:(NSString *)Resource ofType:(NSString *)Type;
        id res = [[LangPatchFileManager defaultUtil] findFromCacheResource:@"en_US" ofType:@"json"];
        BOOL checkBool = [[LangPatchFileManager defaultUtil] setupLanguageWithDictionary:res];
        XCTAssertTrue(checkBool);
        XCTAssertTrue([L(@"HomePage_search_title", @"heeloo") isEqualToString:@"Enter country/city/airport"]);
        NOTIFY
    } failure:^(NSError *error) {
        XCTFail(@"请求失败");
        NOTIFY
    }];
WAIT
}


- (void)testNeedLoad{
    
}
- (void)testNoNeedLoad{
    
}


@end
