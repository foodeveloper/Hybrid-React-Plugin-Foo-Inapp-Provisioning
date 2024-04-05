
#ifdef RCT_NEW_ARCH_ENABLED
#import "RNFooapplewalletreactpluginSpec.h"

@interface Fooapplewalletreactplugin : NSObject <NativeFooapplewalletreactpluginSpec>
#else
#import <React/RCTBridgeModule.h>
#import "WalletExtensionplugin.h"

@interface Fooapplewalletreactplugin : NSObject <RCTBridgeModule>
#endif

@end
