# RMLogger
[![Build Status](https://travis-ci.org/packatino/RMLogger.svg?branch=master)](https://travis-ci.org/packatino/RMLogger)

Logs output to the console like NSLog but has some extra features like colors.

## Add RMLogger to your project
The best way to use RMLogger is via [CocoaPods](https://cocoapods.org/) by adding the following line to your pod file:
>     pod 'RMLogger'

## Use RMLogger
To use RMLogger you have to import the RMLogger.h class:
>     #import <RMLogger.h>

The simplest way to log a message to the console looks like this:
>     RMLog(@"You log message");

### Available log types:

#### Info message log
>     RMLogInfoMessage(@"This is just a simple information.");
![log info message](http://www.robert-missbach.com/assets/RMLogger/RMLogger-infoMessage-log-example.png)
<br />

#### Success message log
>     RMLogSuccessMessage(@"The image has been uploaded successfully.");
![log info message](http://www.robert-missbach.com/assets/RMLogger/RMLogger-successMessage-log-example.png)
<br />

#### Error message log
>     RMLogErrorMessage(@"Failed to reach the server!");
![log info message](http://www.robert-missbach.com/assets/RMLogger/RMLogger-errorMessage-log-example.png)
<br />

#### Error log
>     RMLog(errorObject);
![log info message](http://www.robert-missbach.com/assets/RMLogger/RMLogger-error-log-example.png)

<br />
<br />
Don't hesitate to give feedback or create a pull request :)

