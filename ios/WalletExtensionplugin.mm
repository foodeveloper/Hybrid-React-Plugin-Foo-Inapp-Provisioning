//
//  WalletExtensionplugin.m
//  Fooapplewalletreactplugin
//
//  Created by Sami Sharafeddine on 04/04/2024.
//  Copyright © 2024 Facebook. All rights reserved.
//

#import <React/RCTLog.h>
#import <React/RCTBundleURLProvider.h>

#import "WalletExtensionplugin.h"
#import "RCTExtModule.h"

@implementation WalletExtensionplugin {
    RCTBridge *_bridge;
}

- (void)createBridgeIfNeededWithCompletionHandler:(void (^)())completion {
    dispatch_async(dispatch_get_main_queue(), ^{
        if (!self->_bridge) {
            NSURL *jsCodeLocation = [[RCTBundleURLProvider sharedSettings] jsBundleURLForBundleRoot:@"index.WalletNonUIExtension"];
            self->_bridge = [[RCTBridge alloc] initWithBundleURL:jsCodeLocation
                                            moduleProvider:nil
                                             launchOptions:nil];
        }
        completion();
    });
}

- (RCTExtModule *)getEventModule {
    RCTExtModule *eventModule = [_bridge moduleForClass:[RCTExtModule class]];
    return eventModule;
}

- (void)shouldCheckForCardsToAddLocallyWithCompletion:(void (^)(NSArray<FOCard *> * _Nonnull))completion {
    [FOAppleWallet setWalletExtensionLocalPluginCompletion:completion];
    
    [self createBridgeIfNeededWithCompletionHandler:^{
        RCTExtModule *eventModule = [self getEventModule];
        [eventModule sendCustomEventWithName:@"onShouldCheckForLocalCards" andParameters:nil];
    }];
}

- (void)shouldCheckForCardsToAddRemotelyWithCompletion:(void (^)(NSArray<FOCard *> * _Nonnull))completion {
    [FOAppleWallet setWalletExtensionRemotePluginCompletion:completion];
    
    [self createBridgeIfNeededWithCompletionHandler:^{
        RCTExtModule *eventModule = [self getEventModule];
        [eventModule sendCustomEventWithName:@"onShouldCheckForRemoteCards" andParameters:nil];
    }];
}



@end
