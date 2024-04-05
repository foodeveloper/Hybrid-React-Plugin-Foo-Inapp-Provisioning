//
//  WalletExtensionplugin.h
//  Fooapplewalletreactplugin
//
//  Created by Sami Sharafeddine on 04/04/2024.
//  Copyright © 2024 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <React/RCTBridgeModule.h>
#import <FooAppleWallet/FooAppleWallet-umbrella.h>

#import "EventEmitter.h"

NS_ASSUME_NONNULL_BEGIN

@interface WalletExtensionplugin : FOAppleWalletExtension <RCTBridgeModule>

@end

NS_ASSUME_NONNULL_END
