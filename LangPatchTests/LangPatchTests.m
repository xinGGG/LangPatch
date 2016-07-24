//
//  LangPatchTests.m
//  LangPatchTests
//
//  Created by xing on 16/7/23.
//  Copyright © 2016年 ljx. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "LangPatchFileManager.h"
@interface LangPatchTests : XCTestCase
@property (nonatomic, strong) id content;
@end
#define L(content,defaultString) [[LangPatchFileManager defaultUtil] internationalizationKey:content default:defaultString]

@implementation LangPatchTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.content = [LangPatchFileManager findProjectResource:@"en_US" ofType:@".json"];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}
- (void)testsetupDict{
   BOOL checkBool = [[LangPatchFileManager defaultUtil] setupLanguageWithDictionary:self.content];
    XCTAssertTrue(checkBool);
    XCTAssertTrue([L(@"HomePage_search_title", @"heeloo") isEqualToString:@"Enter country/city/airport"]);
}

- (void)testHistory{
    [LangPatchFileManager initUserLanguage];
    XCTAssertTrue([[LangPatchFileManager userLanguage] isEqualToString:@"en-US"]);
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
