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

RCT_EXPORT_METHOD(didGetAvailableLocalCards:(NSArray <ReactCard *> *)cards) {
    NSMutableArray<FOCard *> *focards = [[NSMutableArray alloc] init];
    for (ReactCard *reactCard in cards) {
        NSData *base64Data = [[NSData alloc] initWithBase64EncodedString:reactCard.cardArtBase64
                                                                 options:NSDataBase64DecodingIgnoreUnknownCharacters];
        UIImage *cardImage = [[UIImage alloc] initWithData:base64Data];
        FOCard *card = [[FOCard alloc] initWithIdentifier:reactCard.identifier
                                                cardTitle:reactCard.title
                                                  cardArt:cardImage
                                           cardholderName:reactCard.cardholderName
                                                panSuffix:reactCard.panSuffix
                                                      pan:reactCard.pan
                                               expiryDate:reactCard.expiryDate];
        [focards addObject:card];
    }
    if (cards && cards.count > 0) {
        localCardsCompletionHandler(focards);
    }
}

RCT_EXPORT_METHOD(didGetAvailableRemoteCards:(NSArray <ReactCard *> *)cards) {
    NSMutableArray<FOCard *> *focards = [[NSMutableArray alloc] init];
    for (ReactCard *reactCard in cards) {
        NSData *base64Data = [[NSData alloc] initWithBase64EncodedString:reactCard.cardArtBase64
                                                                 options:NSDataBase64DecodingIgnoreUnknownCharacters];
        UIImage *cardImage = [[UIImage alloc] initWithData:base64Data];
        FOCard *card = [[FOCard alloc] initWithIdentifier:reactCard.identifier
                                                cardTitle:reactCard.title
                                                  cardArt:cardImage
                                           cardholderName:reactCard.cardholderName
                                                panSuffix:reactCard.panSuffix
                                                      pan:reactCard.pan
                                               expiryDate:reactCard.expiryDate];
        [focards addObject:card];
    }
    if (cards && cards.count > 0) {
        remoteCardsCompletionHandler(focards);
    }
}

@end
