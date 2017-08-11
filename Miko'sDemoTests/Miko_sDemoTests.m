//
//  Miko_sDemoTests.m
//  Miko'sDemoTests
//
//  Created by admin1 on 2017/7/6.
//  Copyright © 2017年 shiqi. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface Miko_sDemoTests : XCTestCase

@end

@implementation Miko_sDemoTests

- (void)setUp {
    [super setUp];
    NSTimeInterval a=[[[NSDate alloc] init] timeIntervalSince1970];
    NSLog(@"%f",a);
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    NSTimeInterval a=[[[NSDate alloc] init] timeIntervalSince1970];
    NSLog(@"%f",a);//a	NSTimeInterval	1502358774.3786139
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
