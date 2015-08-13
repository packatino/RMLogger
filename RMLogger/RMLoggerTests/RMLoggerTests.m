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

- (void)testUniversalLogWithString
{
    [self.loggerMock log:@"hello"];
    OCMVerify([self.loggerMock logString:@"🔵 hello"]);
}

- (void)testUniversalLogWithError
{
    NSDictionary *userInfo = [NSDictionary dictionaryWithObject:@"error description" forKey:NSLocalizedDescriptionKey];
    NSError *error = [NSError errorWithDomain:@"error domain"
                                         code:123
                                     userInfo:userInfo];
    
    [self.loggerMock log:error];
    OCMVerify([self.loggerMock logString:@"🔴 Error 123: \"error description\""]);
}


- (void)testErrorMessageLog
{
    [self.loggerMock logErrorMessage:@"error"];
    OCMVerify([self.loggerMock logString:@"🔴 error"]);
}

- (void)testInfoMessageLog
{
    [self.loggerMock logInfoMessage:@"info"];
    OCMVerify([self.loggerMock logString:@"🔵 info"]);
}

- (void)testSuccessMessageLog
{
    [self.loggerMock logSuccessMessage:@"success"];
    OCMVerify([self.loggerMock logString:@"✅ success"]);
}


- (void)testErrorLog
{
    NSDictionary *userInfo = [NSDictionary dictionaryWithObject:@"error description" forKey:NSLocalizedDescriptionKey];
    NSError *error = [NSError errorWithDomain:@"error domain"
                                         code:123
                                     userInfo:userInfo];
    
    [self.loggerMock logError:error];
    OCMVerify([self.loggerMock logString:@"🔴 Error 123: \"error description\""]);
}


- (void)testQuickLog
{
    id loggerClassMock = OCMClassMock([RMLogger class]);
    OCMStub([loggerClassMock sharedInstance]).andReturn(self.loggerMock);
    
    NSString *logMessage = @"hello";
    RMLog(logMessage);
    
    OCMVerify([self.loggerMock log:logMessage]);
}

@end
