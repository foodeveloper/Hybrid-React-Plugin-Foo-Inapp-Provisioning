//
//  WalletExtensionplugin.m
//  Fooapplewalletreactplugin
//
//  Created by Sami Sharafeddine on 04/04/2024.
//  Copyright © 2024 Facebook. All rights reserved.
//

#import "WalletExtensionplugin.h"
#import "Fooapplewalletreactextensionhandler.h"

Fooapplewalletreactextensionhandler *handler;

@implementation WalletExtensionplugin

- (void)shouldCheckForCardsToAddLocallyWithCompletion:(void (^)(NSArray<FOCard *> * _Nonnull))completion {
    handler = [[Fooapplewalletreactextensionhandler alloc] init];
    [FOAppleWallet setWalletExtensionLocalPluginCompletion:completion];
}

- (void)shouldCheckForCardsToAddRemotelyWithCompletion:(void (^)(NSArray<FOCard *> * _Nonnull))completion {
    [FOAppleWallet setWalletExtensionRemotePluginCompletion:completion];
    [[EventEmitter emitter] sendEvent:@"shouldGetRemoteCards"];
}

@end
