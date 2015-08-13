//
//  RMLogger.m
//  RMLogger
//
//  Created by Robert Mißbach on 13.08.15.
//  Copyright (c) 2015 Robert Mißbach. All rights reserved.
//

#import "RMLogger.h"

@implementation RMLogger


- (void)logString:(NSString *)logMessage
{
    NSLog(@"%@", logMessage);
}

- (void)log:(NSString *)logMessage
{
    [self logInfo:logMessage];
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
