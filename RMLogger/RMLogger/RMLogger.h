//
//  RMLogger.h
//  RMLogger
//
//  Created by Robert Mißbach on 13.08.15.
//  Copyright (c) 2015 Robert Mißbach. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RMLogger : NSObject

- (void)log:(NSString *)logMessage;
- (void)logString:(NSString *)logMessage;
- (void)logError:(NSString *)errorMessage;
- (void)logInfo:(NSString *)infoMessage;
- (void)logSuccess:(NSString *)successMessage;

@end
