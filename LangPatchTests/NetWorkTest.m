//
//  NetWorkTest.m
//  LangPatch
//
//  Created by xing on 16/7/25.
//  Copyright © 2016年 ljx. All rights reserved.
//

#import "AFTestCase.h"
#import "LangPatchNetWork.h"
@interface NetWorkTest : AFTestCase

@end

@implementation NetWorkTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    
    [[LangPatchNetWork defaultUtil] POST:@"http://localhost:8080/home/index.html" RequestParams:nil FinishBlock:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (connectionError) {
            XCTFail(@"请求失败");
            NOTIFY;

        };
        XCTAssertNotNil(data);
        
        NOTIFY;
    }];
    WAIT
}

- (void)testExample1 {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    
    [[LangPatchNetWork defaultUtil] POST:@"http://localhost:8080/home/index.html" parameters:nil success:^(id responseObject) {
        NSLog(@"%@",responseObject);
        XCTAssertNotNil(responseObject);
        NOTIFY;

    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        XCTAssertNotNil(error);
        NOTIFY;

    }];
     WAIT
}


- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
