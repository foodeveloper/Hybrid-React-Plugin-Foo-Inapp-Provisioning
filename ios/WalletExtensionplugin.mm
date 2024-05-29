//
//  WalletExtensionplugin.m
//  Fooapplewalletreactplugin
//
//  Created by Sami Sharafeddine on 04/04/2024.
//  Copyright © 2024 Facebook. All rights reserved.
//

#import "WalletExtensionplugin.h"

@implementation WalletExtensionplugin

- (void)shouldCheckForCardsToAddLocallyWithCompletion:(void (^)(NSArray<FOCard *> * _Nonnull))completion {
    [FOAppleWallet setWalletExtensionLocalPluginCompletion:completion];
    [EventEmitter sendEvent:@"shouldGetLocalCards"];
}

- (void)shouldCheckForCardsToAddRemotelyWithCompletion:(void (^)(NSArray<FOCard *> * _Nonnull))completion {
    [FOAppleWallet setWalletExtensionRemotePluginCompletion:completion];
    [EventEmitter sendEvent:@"shouldGetRemoteCards"];
}

@end
