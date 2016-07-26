//
//  DownToolTests.m
//  LangPatch
//
//  Created by xing on 16/7/24.
//  Copyright © 2016年 ljx. All rights reserved.
//

#import "AFTestCase.h"
#import "LangPatchDownloadTool.h"
@interface DownToolTests : AFTestCase
@property (nonatomic, strong) LangPatchDownloadTool *tool ;
@end

@implementation DownToolTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.tool = [[LangPatchDownloadTool alloc] init];

}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}
- (void)testDownTool{
    
    [self.tool DownloadWithUrl:@"http://localhost:8080/public/en_us.json" success:^(NSString *FullPath) {
        NSLog(@"%@",FullPath);
        XCTAssertNotNil(FullPath);
        NOTIFY
    } failure:^(NSError *error) {
        XCTAssertNotNil(error);
        NOTIFY
    }];
    WAIT
}

- (void)testFailureDownTool{
    [self.tool DownloadWithUrl:@"" success:^(NSString *FullPath) {
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        XCTAssertNotNil(error);
        NOTIFY
    }];
    WAIT
}

@end
