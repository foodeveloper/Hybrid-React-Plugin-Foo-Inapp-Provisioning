
#ifdef RCT_NEW_ARCH_ENABLED
#import "RNFooAppleWalletPluginSpec.h"

@interface FooAppleWalletPlugin : NSObject <NativeFooAppleWalletPluginSpec>
#else
#import <React/RCTBridgeModule.h>

@interface FooAppleWalletPlugin : NSObject <RCTBridgeModule>
#endif

@end
