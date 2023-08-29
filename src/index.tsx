import { NativeModules, Platform } from 'react-native';

const LINKING_ERROR =
  `The package 'fooapplewalletplugin' doesn't seem to be linked. Make sure: \n\n` +
  Platform.select({ ios: "- You have run 'pod install'\n", default: '' }) +
  '- You rebuilt the app after installing the package\n' +
  '- You are not using Expo Go\n';

const FooAppleWalletPlugin = NativeModules.FooAppleWalletPlugin
  ? NativeModules.FooAppleWalletPlugin
  : new Proxy(
      {},
      {
        get() {
          throw new Error(LINKING_ERROR);
        },
      }
    );


export function setHostName(hostName: string , path:string): Promise<string> {
  return FooAppleWalletPlugin.setHostName(hostName , path);
}
export interface CardUserIdDetails {
    userId?: string | null;  // nullable from "nullable NSString"
    deviceId?: string | null; // nullable from "nullable NSString"
    cardId: string;
    cardHolderName: string;
    cardPanSuffix: string;
    sessionId?: string | null; // nullable from "nullable NSString"
    localizedDescription?: string | null;
 

}
export interface CardPanIdDetails {
    userId?: string | null;  // nullable from "nullable NSString"
    deviceId?: string | null; // nullable from "nullable NSString"
    cardId: string;
    cardHolderName: string;
    cardPanSuffix: string;
    localizedDescription?: string | null; // nullable from "nullable NSString"
    pan: string;
    expiryDate: string;

}
export function addCardForUserId({userId , deviceId , cardId , cardHolderName , cardPanSuffix , sessionId,localizedDescription }:CardUserIdDetails): Promise<string> {
  return FooAppleWalletPlugin.addCardForUserId(userId , deviceId , cardId , cardHolderName , cardPanSuffix , sessionId,localizedDescription);
}
export function addCardForPanId({userId , deviceId , cardId , cardHolderName , cardPanSuffix , localizedDescription , pan , expiryDate}:CardPanIdDetails): Promise<string> {
  return FooAppleWalletPlugin.addCardForUserIdWithPanAndExpiry(userId , deviceId , cardId , cardHolderName , cardPanSuffix , localizedDescription , pan , expiryDate);
}
export function deviceSupportsAppleWallet (): Promise<boolean> {
  return FooAppleWalletPlugin.deviceSupportsAppleWallet();
}
export function isCardAddedToLocalWalletWithCardSuffix (cardSuffix:string): Promise<boolean> {
  return FooAppleWalletPlugin.isCardAddedToLocalWalletWithCardSuffix(cardSuffix);
}
export function isCardAddedToRemoteWalletWithCardSuffix (cardSuffix:string): Promise<boolean> {
  return FooAppleWalletPlugin.isCardAddedToRemoteWalletWithCardSuffix(cardSuffix);
}