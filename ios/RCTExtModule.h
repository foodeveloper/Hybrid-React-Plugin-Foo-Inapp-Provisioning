//
//  RCTExtModule.h
//  IntentsExtension
//
//  Created by Samer Marrash on 05/06/2024.
//

#import <Foundation/Foundation.h>
#import <React/RCTBridgeModule.h>
#import <React/RCTEventEmitter.h>

NS_ASSUME_NONNULL_BEGIN

@interface RCTExtModule : RCTEventEmitter <RCTBridgeModule>

- (void)sendCustomEventWithName:(NSString *)eventName andParameters:(nullable NSDictionary *)eventParameters;

@end

NS_ASSUME_NONNULL_END
