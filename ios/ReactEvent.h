//
//  ReactEvent.h
//  Fooapplewalletreactplugin
//
//  Created by Sami Sharafeddine on 06/06/2024.
//  Copyright © 2024 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ReactEvent : NSObject

@property (strong, nonatomic) NSString *eventName;
@property (strong, nonatomic) NSDictionary *eventParameters;

- (instancetype)initWithEventName:(NSString *)name andParameters:(NSDictionary *)parameters;

@end

NS_ASSUME_NONNULL_END
