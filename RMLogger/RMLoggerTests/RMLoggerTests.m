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
    NSString *expectedOutput = [NSString stringWithFormat:@"%@ hello", RMInfoSymbol];
    OCMVerify([self.loggerMock logString:expectedOutput]);
}

- (void)testUniversalLogWithError
{
    NSDictionary *userInfo = [NSDictionary dictionaryWithObject:@"error description" forKey:NSLocalizedDescriptionKey];
    NSError *error = [NSError errorWithDomain:@"error domain"
                                         code:123
                                     userInfo:userInfo];
    
    [self.loggerMock log:error];
    NSString *expectedOutput = [NSString stringWithFormat:@"%@ Error 123: \"error description\"", RMErrorSymbol];
    OCMVerify([self.loggerMock logString:expectedOutput]);
}


#pragma mark - Tests for special logs

- (void)testErrorMessageLog
{
    [self.loggerMock logErrorMessage:@"error"];
    NSString *expectedOutput = [NSString stringWithFormat:@"%@ error", RMErrorSymbol];
    OCMVerify([self.loggerMock logString:expectedOutput]);
}

- (void)testErrorMessageLogWithFormat
{
    [self.loggerMock logErrorMessage:@"error %.1f", 1.0];
    NSString *expectedOutput = [NSString stringWithFormat:@"%@ error 1.0", RMErrorSymbol];
    OCMVerify([self.loggerMock logString:expectedOutput]);
}

- (void)testInfoMessageLog
{
    [self.loggerMock logInfoMessage:@"info"];
    NSString *expectedOutput = [NSString stringWithFormat:@"%@ info", RMInfoSymbol];
    OCMVerify([self.loggerMock logString:expectedOutput]);
}

- (void)testInfoMessageLogWithFormat
{
    [self.loggerMock logInfoMessage:@"info %.1f", 1.0];
    NSString *expectedOutput = [NSString stringWithFormat:@"%@ info 1.0", RMInfoSymbol];
    OCMVerify([self.loggerMock logString:expectedOutput]);
}

- (void)testSuccessMessageLog
{
    [self.loggerMock logSuccessMessage:@"success"];
    NSString *expectedOutput = [NSString stringWithFormat:@"%@ success", RMSuccessSymbol];
    OCMVerify([self.loggerMock logString:expectedOutput]);
}

- (void)testSuccessMessageLogWithFormat
{
    [self.loggerMock logSuccessMessage:@"success %.1f", 1.0];
    NSString *expectedOutput = [NSString stringWithFormat:@"%@ success 1.0", RMSuccessSymbol];
    OCMVerify([self.loggerMock logString:expectedOutput]);
}


- (void)testErrorLog
{
    NSDictionary *userInfo = [NSDictionary dictionaryWithObject:@"error description" forKey:NSLocalizedDescriptionKey];
    NSError *error = [NSError errorWithDomain:@"error domain"
                                         code:123
                                     userInfo:userInfo];
    
    [self.loggerMock logError:error];
    NSString *expectedOutput = [NSString stringWithFormat:@"%@ Error 123: \"error description\"", RMErrorSymbol];
    OCMVerify([self.loggerMock logString:expectedOutput]);
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
    NSString *expectedOutput = [NSString stringWithFormat:@"%@ error", RMErrorSymbol];
    OCMVerify([self.loggerMock logString:expectedOutput]);
}

- (void)testQuickErrorMessageWithFormatLog
{
    RMLogErrorMessage(@"error %.1f", 1.0);
    NSString *expectedOutput = [NSString stringWithFormat:@"%@ error 1.0", RMErrorSymbol];
    OCMVerify([self.loggerMock logString:expectedOutput]);
}

- (void)testQuickInfoMessageLog
{
    RMLogInfoMessage(@"info");
    NSString *expectedOutput = [NSString stringWithFormat:@"%@ info", RMInfoSymbol];
    OCMVerify([self.loggerMock logString:expectedOutput]);
}

- (void)testQuickInfoMessageWithFormatLog
{
    RMLogInfoMessage(@"info %.1f", 1.0);
    NSString *expectedOutput = [NSString stringWithFormat:@"%@ info 1.0", RMInfoSymbol];
    OCMVerify([self.loggerMock logString:expectedOutput]);
}

- (void)testQuickSuccessMessageLog
{
    RMLogSuccessMessage(@"success");
    NSString *expectedOutput = [NSString stringWithFormat:@"%@ success", RMSuccessSymbol];
    OCMVerify([self.loggerMock logString:expectedOutput]);
}

- (void)testQuickSuccessMessageWithFormatLog
{
    RMLogSuccessMessage(@"success %.1f", 1.0);
    NSString *expectedOutput = [NSString stringWithFormat:@"%@ success 1.0", RMSuccessSymbol];
    OCMVerify([self.loggerMock logString:expectedOutput]);
}

- (void)testQuickSuccessMessageWithWrongFormat1
{
    RMLogSuccessMessage(@"success %.1f");
    NSString *expectedOutput = [NSString stringWithFormat:@"%@ success 0.0", RMSuccessSymbol];
    OCMVerify([self.loggerMock logString:expectedOutput]);
}

- (void)testQuickSuccessMessageWithWrongFormat2
{
    RMLogSuccessMessage(@"success", 1.0);
    NSString *expectedOutput = [NSString stringWithFormat:@"%@ success", RMSuccessSymbol];
    OCMVerify([self.loggerMock logString:expectedOutput]);
}

@end
