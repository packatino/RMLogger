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


#pragma mark - Logging

- (void)logString:(NSString *)logMessage
{
    NSLog(@"%@", logMessage);
}

- (void)log:(NSObject *)object
{
    [self logInfo:object.description];
}


- (void)logError:(NSString *)errorMessage
{
    NSString *logString = [NSString stringWithFormat:@"🔴 %@", errorMessage];
    [self logString:logString];
}

- (void)logInfo:(NSString *)infoMessage
{
    NSString *logString = [NSString stringWithFormat:@"🔵 %@", infoMessage];
    [self logString:logString];
}

- (void)logSuccess:(NSString *)successMessage
{
    NSString *logString = [NSString stringWithFormat:@"✅ %@", successMessage];
    [self logString:logString];
}

@end
