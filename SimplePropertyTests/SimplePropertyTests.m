//
//  SimplePropertyTests.m
//  SimplePropertyTests
//
//  Created by ileo on 16/8/29.
//  Copyright © 2016年 ileo. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Test.h"

@interface SimplePropertyTests : XCTestCase

@end

@implementation SimplePropertyTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    
    Test *t = [[Test alloc] init];
    
    [t fillPropertyWithDictionary:@{@"aArr":@[@{@"iii":@"<null>"},@{@"iii":@3},@{@"iii":@4}],@"arr":@[@"啊啊啊",@"啊阿道夫啊啊",@"啊风啊啊"],@"dic":@{@"iii":@111}}];
    
    [t fillPropertyWithDictionary:@{@"heihei":@"1"}];
    
    ARR *arr = [[ARR alloc] init];
    [arr fillPropertyWithDictionary:@{@"heihei":@44,@"iii":@33}];
    arr.heihei = 77;
    arr.iii = 99;
    [arr clearUserDefault];
    
    
    
//    NSLog(@"done , t %@",t.debugDescription);
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
