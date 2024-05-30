//
//  Fooapplewalletreactextensionhandler.m
//  fooapplewalletreactplugin
//
//  Created by Sami Sharafeddine on 30/05/2024.
//

#import "Fooapplewalletreactextensionhandler.h"
#import "ReactCard.h"

#import <FooAppleWallet/FooAppleWallet-umbrella.h>

@implementation Fooapplewalletreactextensionhandler

NSExtensionContext* extensionContext;

// To export a module named DisplayMode
RCT_EXPORT_MODULE();

- (id)initWithContext:(NSExtensionContext*)context {
    self = [super init];
    extensionContext = context;
    return self;
}

RCT_EXPORT_METHOD(didGetLocalCards:(NSArray<ReactCard *> *)cards) {
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
    if (focards && focards.count > 0) {
        [FOAppleWallet getWalletExtensionLocalPluginCompletion](focards);
    }
}

@end
