//
//  RCTExtModule.m
//  IntentsExtension
//
//  Created by Samer Marrash on 05/06/2024.
//

#import <React/RCTLog.h>
#import <React/RCTEventDispatcher.h>

#import "RCTExtModule.h"
#import "ReactEvent.h"

@interface RCTExtModule ()

@property (strong, nonatomic) NSMutableArray<ReactEvent *> *queuedEvents;

@end

@implementation RCTExtModule {
    __block bool hasListeners;
}

RCT_EXPORT_MODULE();

- (void)queueEvent:(ReactEvent *)event {
    if (!self.queuedEvents) {
        self.queuedEvents = [[NSMutableArray alloc] init];
    }
    [self.queuedEvents addObject:event];
}

- (void)sendQueuedEvents {
    if (!self.queuedEvents || self.queuedEvents.count == 0) {
        return;
    }
    
    for (ReactEvent *event in self.queuedEvents) {
        [self sendEventWithName:event.eventName body:event.eventParameters];
        [self.queuedEvents removeObject:event];
    }
}

- (void)sendEvent:(ReactEvent *)event {
    if (hasListeners) {
        [self sendEventWithName:event.eventName body:event.eventParameters];
        return;
    }
    
    // Queue event
    [self queueEvent:event];
}

- (NSArray<NSString *> *)supportedEvents {
    return @[@"onShouldCheckForLocalCards", @"onShouldCheckForRemoteCards"];
}

- (void)sendCustomEventWithName:(NSString *)eventName andParameters:(nullable NSDictionary *)eventParameters {
    dispatch_async(dispatch_get_main_queue(), ^{
        ReactEvent *eventObject = [[ReactEvent alloc] initWithEventName:eventName andParameters:eventParameters];
        [self sendEvent:eventObject];
    });
}

- (void)startObserving {
    hasListeners = YES;
    // Set up any upstream listeners or background tasks as necessary
    [self sendQueuedEvents];
}

- (void)stopObserving {
    hasListeners = NO;
    // Set up any upstream listeners or background tasks as necessary
}

@end
