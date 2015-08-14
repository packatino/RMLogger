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

- (void)testErrorMessageLogWithFormat
{
    [self.loggerMock logErrorMessage:@"error %.1f", 1.0];
    OCMVerify([self.loggerMock logString:@"🔴 error 1.0"]);
}

- (void)testInfoMessageLog
{
    [self.loggerMock logInfoMessage:@"info"];
    OCMVerify([self.loggerMock logString:@"🔵 info"]);
}

- (void)testInfoMessageLogWithFormat
{
    [self.loggerMock logInfoMessage:@"info %.1f", 1.0];
    OCMVerify([self.loggerMock logString:@"🔵 info 1.0"]);
}

- (void)testSuccessMessageLog
{
    [self.loggerMock logSuccessMessage:@"success"];
    OCMVerify([self.loggerMock logString:@"✅ success"]);
}

- (void)testSuccessMessageLogWithFormat
{
    [self.loggerMock logSuccessMessage:@"success %.1f", 1.0];
    OCMVerify([self.loggerMock logString:@"✅ success 1.0"]);
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
    RMLogErrorMessage(@"error");
    OCMVerify([self.loggerMock logString:@"🔴 error"]);
}

- (void)testQuickErrorMessageWithFormatLog
{
    RMLogErrorMessage(@"error %.1f", 1.0);
    OCMVerify([self.loggerMock logString:@"🔴 error 1.0"]);
}

- (void)testQuickInfoMessageLog
{
    RMLogInfoMessage(@"info");
    OCMVerify([self.loggerMock logString:@"🔵 info"]);
}

- (void)testQuickInfoMessageWithFormatLog
{
    RMLogInfoMessage(@"info %.1f", 1.0);
    OCMVerify([self.loggerMock logString:@"🔵 info 1.0"]);
}

- (void)testQuickSuccessMessageLog
{
    RMLogSuccessMessage(@"success");
    OCMVerify([self.loggerMock logString:@"✅ success"]);
}

- (void)testQuickSuccessMessageWithFormatLog
{
    RMLogSuccessMessage(@"success %.1f", 1.0);
    OCMVerify([self.loggerMock logString:@"✅ success 1.0"]);
}

- (void)testQuickSuccessMessageWithWrongFormat1
{
    RMLogSuccessMessage(@"success %.1f");
    OCMVerify([self.loggerMock logString:@"✅ success 0.0"]);
}

- (void)testQuickSuccessMessageWithWrongFormat2
{
    RMLogSuccessMessage(@"success", 1.0);
    OCMVerify([self.loggerMock logString:@"✅ success"]);
}

@end
