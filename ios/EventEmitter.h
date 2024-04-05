//
//  EventEmitter.h
//  fooapplewalletreactplugin
//
//  Created by Sami Sharafeddine on 04/04/2024.
//

#import <Foundation/Foundation.h>
#import <React/RCTEventEmitter.h>

NS_ASSUME_NONNULL_BEGIN

@interface EventEmitter : RCTEventEmitter

+ (instancetype)emitter;

- (void)sendEvent:(NSString *)eventName;

@end

NS_ASSUME_NONNULL_END
