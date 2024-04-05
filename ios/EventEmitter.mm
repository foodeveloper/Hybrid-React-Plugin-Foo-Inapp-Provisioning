//
//  EventEmitter.m
//  fooapplewalletreactplugin
//
//  Created by Sami Sharafeddine on 04/04/2024.
//

#import "EventEmitter.h"

static EventEmitter *currentEmitter = nil;

@implementation EventEmitter

+ (instancetype)emitter {
    if (!currentEmitter) {
        currentEmitter = [[EventEmitter alloc] init];
    }
    return currentEmitter;
}

- (NSArray<NSString *> *)supportedEvents {
    return @[@"shouldGetLocalCards", @"shouldGetRemoteCards"];
}

- (void)sendEvent:(NSString *)eventName {
    [currentEmitter sendEvent:eventName];
}

@end
