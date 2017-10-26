//
//  PVAmplitudeBridge.m
//  PVAmplitudeBridge
//
//  Created by Keith on 10/26/17.
//  Copyright © 2017 GittieLabs. All rights reserved.
//
//  Created by react-native-create-bridge

#import "PVAmplitudeBridge.h"

// import RCTBridge
#if __has_include(<React/RCTBridge.h>)
#import <React/RCTBridge.h>
#elif __has_include(“RCTBridge.h”)
#import “RCTBridge.h”
#else
#import “React/RCTBridge.h” // Required when used as a Pod in a Swift project
#endif

// import RCTEventDispatcher
#if __has_include(<React/RCTEventDispatcher.h>)
#import <React/RCTEventDispatcher.h>
#elif __has_include(“RCTEventDispatcher.h”)
#import “RCTEventDispatcher.h”
#else
#import “React/RCTEventDispatcher.h” // Required when used as a Pod in a Swift project
#endif

#if __has_include(<React/RCTLog.h>)
#import <React/RCTLog.h>
#elif __has_include("RCTLog.h")
#import "RCTLog.h"
#else
#import "React/RCTLog.h"
#endif

#import "Amplitude.h"
#import "AMPIdentify.h"

@interface NSString (isNumber)
- (BOOL) isNumber;
@end

@implementation NSString(isNumber)
- (BOOL) isNumber {
    NSScanner *scanner = [NSScanner localizedScannerWithString:self];
    if ([scanner scanFloat:NULL]){
        return [scanner isAtEnd];
    }
    return NO;
}
@end

@implementation PVAmplitudeBridge
@synthesize bridge = _bridge;

// Export constants
// https://facebook.github.io/react-native/releases/next/docs/native-modules-ios.html#exporting-constants
- (NSDictionary *)constantsToExport
{
    return @{
             @"EXAMPLE": @"example"
             };
}

// Export a native module
// https://facebook.github.io/react-native/docs/native-modules-ios.html
RCT_EXPORT_MODULE();

// List all your events here
// https://facebook.github.io/react-native/releases/next/docs/native-modules-ios.html#sending-events-to-javascript
- (NSArray<NSString *> *)supportedEvents
{
    return @[@"SampleEvent"];
}


#pragma mark - Initialize Amplitude

// Initialize Amplitude with API key
RCT_EXPORT_METHOD(initializeApiKey: (NSString *)key)
{
    RCTLogInfo(@"Amplitude::Initializing API with key: %@", key);
    [[Amplitude instance] initializeApiKey:key];
}

#pragma mark - Log Event Methods
//Log events in Amplitude

RCT_EXPORT_METHOD(logEvent: (NSString *)eventName)
{
    RCTLogInfo(@"Amplitude::log event: %@", eventName);
    [[Amplitude instance] logEvent:eventName];
}

RCT_EXPORT_METHOD(logEventWithProperties: (NSString *)eventName withEventProperties: (NSDictionary *)eventProperties)
{
    RCTLogInfo(@"Amplitude::log event: %@", eventName);
    [[Amplitude instance] logEvent:eventName withEventProperties:eventProperties];
}

RCT_EXPORT_METHOD(logEventWithPropertiesAndSession: (NSString *)eventName withEventProperties: (NSDictionary *)eventProperties outOfSession: (BOOL) isOutOfSession)
{
    RCTLogInfo(@"Amplitude::log event: %@", eventName);
    [[Amplitude instance] logEvent:eventName withEventProperties:eventProperties outOfSession:isOutOfSession];
}

RCT_EXPORT_METHOD(logEventWithGroups: (NSString *)eventName withEventProperties: (NSDictionary *)eventProperties withGroups: (NSDictionary *) groups)
{
    RCTLogInfo(@"Amplitude::log event: %@", eventName);
    [[Amplitude instance] logEvent:eventName withEventProperties:eventProperties withGroups:groups];
}

RCT_EXPORT_METHOD(logEventWithGroupsAndSession: (NSString *)eventName withEventProperties: (NSDictionary *)eventProperties withGroups: (NSDictionary *) groups outOfSession:(BOOL) outOfSession)
{
    RCTLogInfo(@"Amplitude::log event: %@", eventName);
    [[Amplitude instance] logEvent:eventName withEventProperties:eventProperties withGroups:groups outOfSession:outOfSession];
}

#pragma mark - Track Sessions
RCT_EXPORT_METHOD(trackSessions:(BOOL)tracksessions)
{
    RCTLogInfo(@"Amplitude::Set TrackingSession Events: %s", tracksessions ? "true" : "false");
    [[Amplitude instance] setTrackingSessionEvents:tracksessions];
}

RCT_EXPORT_METHOD(minTimeBetweenSessionsMillis: (nonnull NSNumber *) time)
{
    [[Amplitude instance] setMinTimeBetweenSessionsMillis:time.longValue];
}

RCT_EXPORT_METHOD(getCurrentSessionId:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)
{
    long sessionId = [[Amplitude instance] getSessionId];
    resolve([NSNumber numberWithLong:sessionId]);
}

#pragma mark - Setting Custom User IDs
RCT_EXPORT_METHOD(setUserId: (NSString *)userId)
{
    RCTLogInfo(@"Amplitude::set userid: %@", userId);
    [[Amplitude instance] setUserId:userId];
}

#pragma mark - Logging Out and Anonymous Users
RCT_EXPORT_METHOD(logOut)
{
    RCTLogInfo(@"Amplitude::logout called");
    [[Amplitude instance] setUserId:nil]; // not string nil
    [[Amplitude instance] regenerateDeviceId];
}

#pragma mark - Setting User Properties
RCT_EXPORT_METHOD(identifySet:(NSString *)key value:(NSString *)value)
{
    RCTLogInfo(@"Amplitude::identity set called for key: %@", key);
    
    if ([value isNumber]){
        NSNumber *num = [NSNumber numberWithInteger:value.integerValue];
        AMPIdentify *identity = [[AMPIdentify identify] set:key value:num];
        [[Amplitude instance] identify:identity];
    }
    else {
        AMPIdentify *identity = [[AMPIdentify identify] set:key value:value];
        [[Amplitude instance] identify:identity];
    }
}

RCT_EXPORT_METHOD(identifySetOnce:(NSString *)key value:(NSString *)value)
{
    RCTLogInfo(@"Amplitude::identity setOnce called for key: %@", key);
    if ([value isNumber]){
        NSNumber *num = [NSNumber numberWithInteger:value.integerValue];
        AMPIdentify *identity = [[AMPIdentify identify] setOnce:key value:num];
        [[Amplitude instance] identify:identity];
    }
    else {
        AMPIdentify *identity = [[AMPIdentify identify] setOnce:key value:value];
        [[Amplitude instance] identify:identity];
    }
}


RCT_EXPORT_METHOD(identifyUnset:(NSString *)key)
{
    RCTLogInfo(@"Amplitude::identity unset called for key: %@", key);
    AMPIdentify *identity = [[AMPIdentify identify] unset:key];
    [[Amplitude instance] identify:identity];
}

RCT_EXPORT_METHOD(identifyAdd:(NSString *)key value:(NSNumber *)value)
{
    RCTLogInfo(@"Amplitude::identity add called for key: %@", key);
    AMPIdentify *identity = [[AMPIdentify identify] add:key value:value];
    [[Amplitude instance] identify:identity];
}

RCT_EXPORT_METHOD(identifyAppendArray:(NSString *)key value:(NSArray *)value)
{
    RCTLogInfo(@"Amplitude::identity append array called for key: %@", key);
    AMPIdentify *identity = [[AMPIdentify identify] append:key value:value];
    [[Amplitude instance] identify:identity];
}

RCT_EXPORT_METHOD(identifyAppendDictionary:(NSString *)key value:(NSDictionary *)value)
{
    RCTLogInfo(@"Amplitude::identity append dictionary called for key: %@", key);
    AMPIdentify *identity = [[AMPIdentify identify] append:key value:value];
    [[Amplitude instance] identify:identity];
}

RCT_EXPORT_METHOD(identifyPrependArray:(NSString *)key value:(NSArray *)value)
{
    RCTLogInfo(@"Amplitude::identity prepend array called for key: %@", key);
    AMPIdentify *identity = [[AMPIdentify identify] append:key value:value];
    [[Amplitude instance] identify:identity];
}

RCT_EXPORT_METHOD(identifyPrependDictionary:(NSString *)key value:(NSDictionary *)value)
{
    RCTLogInfo(@"Amplitude::identity prepend dictionary called for key: %@", key);
    AMPIdentify *identity = [[AMPIdentify identify] append:key value:value];
    [[Amplitude instance] identify:identity];
}

RCT_EXPORT_METHOD(clearUserProperties)
{
    RCTLogInfo(@"Amplitude::clearUserProperties called");
    [[Amplitude instance] clearUserProperties];
}

#pragma mark - Private methods

// Implement methods that you want to export to the native module
- (void) emitMessageToRN: (NSString *)eventName :(NSDictionary *)params {
    // The bridge eventDispatcher is used to send events from native to JS env
    // No documentation yet on DeviceEventEmitter: https://github.com/facebook/react-native/issues/2819
    [self sendEventWithName: eventName body: params];
}
@end

