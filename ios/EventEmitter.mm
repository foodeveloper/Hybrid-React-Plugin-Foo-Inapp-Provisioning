//
//  EventEmitter.m
//  fooapplewalletreactplugin
//
//  Created by Sami Sharafeddine on 04/04/2024.
//

#import "EventEmitter.h"

static EventEmitter *currentEmitter = nil;

@implementation EventEmitter

- (instancetype)init {
    self = [super init];
    if (!currentEmitter) {
        currentEmitter = self;
    }
    return self;
}

RCT_EXPORT_MODULE()

- (NSArray<NSString *> *)supportedEvents {
    return @[@"shouldGetLocalCards", @"shouldGetRemoteCards"];
}

+ (void)sendEvent:(NSString *)eventName {
    [currentEmitter sendEventWithName:eventName body:nil];
}

@end
