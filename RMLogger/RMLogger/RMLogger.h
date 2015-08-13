//
//  RMLogger.h
//  RMLogger
//
//  Created by Robert Mißbach on 13.08.15.
//  Copyright (c) 2015 Robert Mißbach. All rights reserved.
//

#import <Foundation/Foundation.h>


/// Quick way to access [[RMLogger sharedInstance] log:]
FOUNDATION_EXPORT void RMLog(NSObject *object);


/**
 This is the class where the actual logging takes place.
 */
@interface RMLogger : NSObject

#pragma mark - Shared instance

/// Use this method to get yout Singleton instance of RMLogger!
+ (RMLogger *)sharedInstance;


#pragma mark - Logging

/// Logs any NSObject. By default the description of the objct is used.
- (void)log:(NSObject *)object;

/// Logs the message parameter exactly as it comes in.
- (void)logString:(NSString *)logMessage;

#pragma mark -

/// Logs a message and marks it as an error.
- (void)logErrorMessage:(NSString *)errorMessage;

/// Logs a message and marks it as an info.
- (void)logInfoMessage:(NSString *)infoMessage;

/// Logs a message and marks it as a success.
- (void)logSuccessMessage:(NSString *)successMessage;

#pragma mark -

/// Special log for NSError objects
- (void)logError:(NSError *)error;

@end
