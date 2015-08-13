//
//  RMLogger.h
//  RMLogger
//
//  Created by Robert Mißbach on 13.08.15.
//  Copyright (c) 2015 Robert Mißbach. All rights reserved.
//

#import <Foundation/Foundation.h>


FOUNDATION_EXPORT void RMLog(NSObject *object);


@interface RMLogger : NSObject

+ (RMLogger *)sharedInstance;

- (void)log:(NSObject *)object;
- (void)logString:(NSString *)logMessage;
- (void)logError:(NSString *)errorMessage;
- (void)logInfo:(NSString *)infoMessage;
- (void)logSuccess:(NSString *)successMessage;

@end
