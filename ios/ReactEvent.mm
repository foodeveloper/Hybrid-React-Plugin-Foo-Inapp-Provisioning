//
//  ReactEvent.m
//  Fooapplewalletreactplugin
//
//  Created by Sami Sharafeddine on 06/06/2024.
//  Copyright © 2024 Facebook. All rights reserved.
//

#import "ReactEvent.h"

@implementation ReactEvent

- (instancetype)initWithEventName:(NSString *)name andParameters:(NSDictionary *)parameters {
    self = [super init];
    if (self) {
        self.eventName = name;
        self.eventParameters = parameters;
    }
    return self;
}

@end
