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
    // create a mock for the logger
    RMLogger *logger = [[RMLogger alloc] init];
    self.loggerMock = OCMPartialMock(logger);
    
    // make sure the mock is always used
    id loggerClassMock = OCMClassMock([RMLogger class]);
    OCMStub([loggerClassMock sharedInstance]).andReturn(self.loggerMock);
}

- (void)tearDown
{
    self.loggerMock = nil;
}


#pragma mark - Test for unsiversal log

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


#pragma mark - Tests for special logs

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



#pragma mark - Tests for quick log

- (void)testQuickLog
{
    NSString *logMessage = @"hello";
    RMLog(logMessage);
    
    OCMVerify([self.loggerMock log:logMessage]);
}

- (void)testQuickErrorMessageLog
{
    NSString *logMessage = @"error";
    RMLogErrorMessage(logMessage);
    
    OCMVerify([self.loggerMock logErrorMessage:logMessage]);
}

- (void)testQuickInfoMessageLog
{
    NSString *logMessage = @"info";
    RMLogInfoMessage(logMessage);
    
    OCMVerify([self.loggerMock logInfoMessage:logMessage]);
}

- (void)testQuickSuccessMessageLog
{
    NSString *logMessage = @"success";
    RMLogSuccessMessage(logMessage);
    
    OCMVerify([self.loggerMock logSuccessMessage:logMessage]);
}

@end
