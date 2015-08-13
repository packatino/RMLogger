//
//  RMLogger.m
//  RMLogger
//
//  Created by Robert Mißbach on 13.08.15.
//  Copyright (c) 2015 Robert Mißbach. All rights reserved.
//

#import "RMLogger.h"


FOUNDATION_EXTERN void RMLog(NSObject *object)
{
    [[RMLogger sharedInstance] log:object];
}

FOUNDATION_EXTERN void RMLogErrorMessage(NSString *errorMessage)
{
    [[RMLogger sharedInstance] logErrorMessage:errorMessage];
}

FOUNDATION_EXTERN void RMLogInfoMessage(NSString *infoMessage)
{
    [[RMLogger sharedInstance] logInfoMessage:infoMessage];
}

FOUNDATION_EXTERN void RMLogSuccessMessage(NSString *successMessage)
{
    [[RMLogger sharedInstance] logSuccessMessage:successMessage];
}



@implementation RMLogger


#pragma mark - Object live cycle

+ (RMLogger *)sharedInstance
{
    static RMLogger *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}


#pragma mark - Actual Logging

- (void)logString:(NSString *)logMessage
{
    NSLog(@"%@", logMessage);
}


#pragma mark - Universal Logging

- (void)log:(NSObject *)object
{
    if ([object isKindOfClass:[NSError class]])
    {
        [self logError:((NSError *)object)];
    }
    else
    {
        [self logInfoMessage:object.description];
    }
}


#pragma mark - Logging strings

- (void)logErrorMessage:(NSString *)errorMessage
{
    NSString *logString = [NSString stringWithFormat:@"🔴 %@", errorMessage];
    [self logString:logString];
}

- (void)logInfoMessage:(NSString *)infoMessage
{
    NSString *logString = [NSString stringWithFormat:@"🔵 %@", infoMessage];
    [self logString:logString];
}

- (void)logSuccessMessage:(NSString *)successMessage
{
    NSString *logString = [NSString stringWithFormat:@"✅ %@", successMessage];
    [self logString:logString];
}


#pragma mark - Logging special objects

- (void)logError:(NSError *)error
{
    NSString *errorString = [NSString stringWithFormat:@"Error %li: \"%@\"", (long)error.code, error.localizedDescription];
    [self logErrorMessage:errorString];
}

@end
