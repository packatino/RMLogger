//
//  RMLoggerTests.m
//  RMLogger
//
//  Created by Robert Mißbach on 13.08.15.
//  Copyright (c) 2015 Robert Mißbach. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import <OCMock.h>

#import "RMLogger.h"

@interface RMLoggerTests : XCTestCase

@property (nonatomic) id loggerMock;

@end


@implementation RMLoggerTests


#pragma mark - Set up and tear down

- (void)setUp
{
    RMLogger *logger = [[RMLogger alloc] init];
    self.loggerMock = OCMPartialMock(logger);
}

- (void)tearDown
{
    self.loggerMock = nil;
}


#pragma mark - Test methods

- (void)testSimpleMessageLog
{
    [self.loggerMock log:@"hello"];
    OCMVerify([self.loggerMock logString:@"🔵 hello"]);
}

- (void)testErrorMessageLog
{
    [self.loggerMock logError:@"error"];
    OCMVerify([self.loggerMock logString:@"🔴 error"]);
}

- (void)testInfoMessageLog
{
    [self.loggerMock logInfo:@"info"];
    OCMVerify([self.loggerMock logString:@"🔵 info"]);
}

- (void)testSuccessMessageLog
{
    [self.loggerMock logSuccess:@"success"];
    OCMVerify([self.loggerMock logString:@"✅ success"]);
}



@end
