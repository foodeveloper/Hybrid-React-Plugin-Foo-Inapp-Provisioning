//
//  WalletExtensionplugin.m
//  Fooapplewalletreactplugin
//
//  Created by Sami Sharafeddine on 04/04/2024.
//  Copyright © 2024 Facebook. All rights reserved.
//

#import "WalletExtensionplugin.h"

@implementation WalletExtensionplugin

void (^localCardsCompletionHandler)(NSArray<FOCard *> * _Nonnull);
void (^remoteCardsCompletionHandler)(NSArray<FOCard *> * _Nonnull);

- (void)shouldCheckForCardsToAddLocallyWithCompletion:(void (^)(NSArray<FOCard *> * _Nonnull))completion {
    localCardsCompletionHandler = completion;
    [[EventEmitter emitter] sendEvent:@"shouldGetLocalCards"];
}

- (void)shouldCheckForCardsToAddRemotelyWithCompletion:(void (^)(NSArray<FOCard *> * _Nonnull))completion {
    remoteCardsCompletionHandler = completion;
    [[EventEmitter emitter] sendEvent:@"shouldGetRemoteCards"];
}

RCT_EXPORT_MODULE()

RCT_EXPORT_METHOD(didGetAvailableLocalCards:(NSArray <FOCard *> *)cards) {
    if (cards && cards.count > 0) {
        localCardsCompletionHandler(cards);
    }
}

RCT_EXPORT_METHOD(didGetAvailableRemoteCards:(NSArray <FOCard *> *)cards) {
    if (cards && cards.count > 0) {
        remoteCardsCompletionHandler(cards);
    }
}

@end
