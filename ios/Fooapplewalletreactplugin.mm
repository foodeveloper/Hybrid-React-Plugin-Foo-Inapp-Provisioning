#import <React/RCTUtils.h>
#import <FooAppleWallet/FOAppleWallet-Umberlla.h>

#import "Fooapplewalletreactplugin.h"

@interface Fooapplewalletreactplugin () <FOInAppProtocol>

@property (copy, nonatomic) RCTPromiseResolveBlock provisioningResolveBlock;
@property (copy, nonatomic) RCTPromiseRejectBlock provisioningRejectBlock;

@end

@implementation Fooapplewalletreactplugin

+ (instancetype)sharedInstance
{
    static Fooapplewalletreactplugin *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[Fooapplewalletreactplugin alloc] init];
    });
    return sharedInstance;
}

RCT_EXPORT_MODULE()

RCT_EXPORT_METHOD(setHostName:(NSString *)hostName
                  andPath:(NSString *)path
                  resolve:(RCTPromiseResolveBlock)resolve
                  reject:(RCTPromiseRejectBlock)reject)
{
   
    [FOAppleWallet setHostName:hostName andPath:path];
    resolve(@"Success");
}

RCT_EXPORT_METHOD(setAppGroupIdentifier:(NSString *)identifier
                  resolve:(RCTPromiseResolveBlock)resolve
                  reject:(RCTPromiseRejectBlock)reject)
{
    
    [FOAppleWallet setAppGroupIdentifier:identifier];
    resolve(@"Success");
}

RCT_EXPORT_METHOD(setExtensionNeedsAuthentication:(BOOL)needsAuthentication
                  resolve:(RCTPromiseResolveBlock)resolve
                  reject:(RCTPromiseRejectBlock)reject)
{
    
    [FOAppleWallet setExtensionNeedsAuthentication:needsAuthentication];
    resolve(@"Success");
}

RCT_EXPORT_METHOD(setExtensionHasAvailableLocalPasses:(BOOL)hasLocalPasses
                  resolve:(RCTPromiseResolveBlock)resolve
                  reject:(RCTPromiseRejectBlock)reject)
{
    
    [FOAppleWallet setExtensionHasAvailableLocalPasses:hasLocalPasses];
    resolve(@"Success");
}

RCT_EXPORT_METHOD(setExtensionHasAvailableRemotePasses:(BOOL)hasRemotePasses
                  resolve:(RCTPromiseResolveBlock)resolve
                  reject:(RCTPromiseRejectBlock)reject)
{
    
    [FOAppleWallet setExtensionHasAvailableRemotePasses:hasRemotePasses];
    resolve(@"Success");
}

RCT_EXPORT_METHOD(deviceSupportsAppleWallet :(RCTPromiseResolveBlock)resolve
                  reject:(RCTPromiseRejectBlock)reject)
{
    BOOL isDeviceSupportsAppleWallet = [FOInAppProvisioning deviceSupportsAppleWallet];
    resolve(@(isDeviceSupportsAppleWallet));
}

RCT_EXPORT_METHOD(isCardAddedToLocalWalletWithCardSuffix:(NSString *)cardSuffix
                  resolve:(RCTPromiseResolveBlock)resolve
                  reject:(RCTPromiseRejectBlock)reject)
{
    BOOL isCardAdded = [FOInAppProvisioning isCardAddedToLocalWalletWithCardSuffix:cardSuffix];
    resolve(@(isCardAdded));
}

RCT_EXPORT_METHOD(isCardAddedToRemoteWalletWithCardSuffix:(NSString *)cardSuffix
                  resolve:(RCTPromiseResolveBlock)resolve
                  reject:(RCTPromiseRejectBlock)reject)
{
    BOOL isCardAdded = [FOInAppProvisioning isCardAddedToRemoteWalletWithCardSuffix:cardSuffix];
    resolve(@(isCardAdded));
}

RCT_EXPORT_METHOD(didGetAvailableLocalCards:(NSArray *)cards) {
    NSMutableArray<FOCard *> *focards = [[NSMutableArray alloc] init];
    for (NSDictionary *reactCard in cards) {
        // Image
        NSString *base64String = [reactCard objectForKey:@"cardArtBase64"];
        NSData *base64Data = [[NSData alloc] initWithBase64EncodedString:base64String
                                                                 options:NSDataBase64DecodingIgnoreUnknownCharacters];
        UIImage *cardImage = [[UIImage alloc] initWithData:base64Data];
        
        // String params
        NSString *identifier = [reactCard objectForKey:@"identifier"];
        NSString *title = [reactCard objectForKey:@"title"];
        NSString *cardholderName = [reactCard objectForKey:@"cardholderName"];
        NSString *panSuffix = [reactCard objectForKey:@"panSuffix"];
        NSString *pan = [reactCard objectForKey:@"pan"];
        NSString *expiryDate = [reactCard objectForKey:@"expiryDate"];
        NSString *cardScheme = [reactCard objectForKey:@"cardScheme"];
        
        // FOCard
        FOCard *card = [[FOCard alloc] initWithIdentifier:identifier
                                                cardTitle:title
                                                  cardArt:cardImage
                                           cardholderName:cardholderName
                                                panSuffix:panSuffix
                                                      pan:pan
                                               expiryDate:expiryDate
                                               cardScheme:[self getCardScheme:cardScheme]];
        [focards addObject:card];
    }
    if (focards && focards.count > 0) {
        [FOAppleWallet getWalletExtensionLocalPluginCompletion](focards);
    }
}

RCT_EXPORT_METHOD(didGetAvailableRemoteCards:(NSArray <ReactCard *> *)cards) {
    NSMutableArray<FOCard *> *focards = [[NSMutableArray alloc] init];
    for (NSDictionary *reactCard in cards) {
        // Image
        NSString *base64String = [reactCard objectForKey:@"cardArtBase64"];
        NSData *base64Data = [[NSData alloc] initWithBase64EncodedString:base64String
                                                                 options:NSDataBase64DecodingIgnoreUnknownCharacters];
        UIImage *cardImage = [[UIImage alloc] initWithData:base64Data];
        
        // String params
        NSString *identifier = [reactCard objectForKey:@"identifier"];
        NSString *title = [reactCard objectForKey:@"title"];
        NSString *cardholderName = [reactCard objectForKey:@"cardholderName"];
        NSString *panSuffix = [reactCard objectForKey:@"panSuffix"];
        NSString *pan = [reactCard objectForKey:@"pan"];
        NSString *expiryDate = [reactCard objectForKey:@"expiryDate"];
        NSString *cardScheme = [reactCard objectForKey:@"cardScheme"];
        
        // FOCard
        FOCard *card = [[FOCard alloc] initWithIdentifier:identifier
                                                cardTitle:title
                                                  cardArt:cardImage
                                           cardholderName:cardholderName
                                                panSuffix:panSuffix
                                                      pan:pan
                                               expiryDate:expiryDate
                                               cardScheme:[self getCardScheme:cardScheme]];
        [focards addObject:card];
    }
    if (focards && focards.count > 0) {
        [FOAppleWallet getWalletExtensionRemotePluginCompletion](focards);
    }
}

RCT_EXPORT_METHOD(addCardForUserId:(nullable NSString *)userId
                  deviceId:(nullable NSString *)deviceId
                  cardId:(NSString *)cardId
                  cardHolderName:(NSString *)cardHolderName
                  cardPanSuffix:(NSString *)cardPanSuffix
                  sessionId:(nullable NSString *)sessionId
                  localizedDescription:(nullable NSString *)localizedDescription
                  cardScheme:(nullable NSString *)cardScheme
                  resolve:(RCTPromiseResolveBlock)resolve
                  reject:(RCTPromiseRejectBlock)reject)
{
    [Fooapplewalletreactplugin sharedInstance].provisioningResolveBlock = resolve;
    [Fooapplewalletreactplugin sharedInstance].provisioningRejectBlock = reject;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        UIViewController *presentedViewController = RCTPresentedViewController();
      [FOInAppProvisioning addCardForUserId:userId deviceId:deviceId cardId:cardId cardHolderName:cardHolderName cardPanSuffix:cardPanSuffix cardScheme:[self getCardScheme:cardScheme] sessionId:sessionId localizedDescription:localizedDescription inViewController:presentedViewController delegate:self];
    });
}

RCT_EXPORT_METHOD(addCardForUserIdWithPanAndExpiry:(nullable NSString *)userId
                  deviceId:(nullable NSString *)deviceId
                  cardId:(NSString *)cardId
                  cardHolderName:(NSString *)cardHolderName
                  cardPanSuffix:(NSString *)cardPanSuffix
                  localizedDescription:(nullable NSString *)localizedDescription
                  pan:(NSString *)pan
                  expiryDate:(NSString *)expiryDate
                  cardScheme:(nullable NSString *)cardScheme
                  resolve:(RCTPromiseResolveBlock)resolve
                  reject:(RCTPromiseRejectBlock)reject)
{
    [Fooapplewalletreactplugin sharedInstance].provisioningResolveBlock = resolve;
    [Fooapplewalletreactplugin sharedInstance].provisioningRejectBlock = reject;

    dispatch_async(dispatch_get_main_queue(), ^{
        UIViewController *presentedViewController = RCTPresentedViewController();
      [FOInAppProvisioning addCardForUserId:userId deviceId:deviceId cardId:cardId cardHolderName:cardHolderName cardPanSuffix:cardPanSuffix localizedDescription:localizedDescription pan:pan expiryDate:expiryDate cardScheme:[self getCardScheme:cardScheme] inViewController:presentedViewController delegate:self];
    });
}

- (void)didFinishAddingCard:(nullable PKPaymentPass *)pass error:(FOInAppAddCardError)error errorMessage:(nullable NSString *)errorMessage {
    NSLog(@"DidFinishAddingCard result: %u, message: %@", error, errorMessage);
    NSString *result = [[NSString alloc] initWithFormat:@"%u", error];
    
    if (error == 0) {
        [Fooapplewalletreactplugin sharedInstance].provisioningResolveBlock(result);
    } else {
        NSError *error = [[NSError alloc] initWithDomain:@"FOInAppAddCardError" code:(NSInteger)[result intValue] userInfo:nil];
        [Fooapplewalletreactplugin sharedInstance].provisioningRejectBlock(result, errorMessage, error);
    }
}

- (FOInAppCardScheme)getCardScheme:(NSString *)string {
  if ([string isEqualToString:@"MASTERCARD"]) {
    return FOInAppCardSchemeMastercard;
  } else if ([string isEqualToString:@"VISA"]) {
    return FOInAppCardSchemeVisa;
  } else if ([string isEqualToString:@"MADA"]) {
    return FOInAppCardSchemeMada;
  } else if ([string isEqualToString:@"MADA_VISA"]) {
    return FOInAppCardSchemeMadaVisa;
  } else if ([string isEqualToString:@"MADA_MASTERCARD"]) {
    return FOInAppCardSchemeMadaMastercard;
  } else {
    return FOInAppCardSchemeUnspecified;
  }
}

@end
