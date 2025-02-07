import { NativeModules, NativeEventEmitter, Platform } from 'react-native';
const { ExtModule } = NativeModules;

export const FooNonUIWalletExtensionHandler = new NativeEventEmitter(ExtModule);

const LINKING_ERROR =
  `The package 'fooapplewalletreactplugin' doesn't seem to be linked. Make sure: \n\n` +
  Platform.select({ ios: "- You have run 'pod install'\n", default: '' }) +
  '- You rebuilt the app after installing the package\n' +
  '- You are not using Expo Go\n';

const Fooapplewalletreactplugin = NativeModules.Fooapplewalletreactplugin
  ? NativeModules.Fooapplewalletreactplugin
  : new Proxy(
      {},
      {
        get() {
          throw new Error(LINKING_ERROR);
        },
      }
    );

    export function setHostName(hostName: string , path:string): Promise<string> {
      return Fooapplewalletreactplugin.setHostName(hostName , path);
    }
    export interface CardUserIdDetails {
        userId?: string | null;  // nullable from "nullable NSString"
        deviceId?: string | null; // nullable from "nullable NSString"
        cardId: string;
        cardHolderName: string;
        cardPanSuffix: string;
        sessionId?: string | null; // nullable from "nullable NSString"
        localizedDescription?: string | null;
        cardScheme?: string | null;
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
        cardScheme?: string | null;
    }
    export interface ReactCard {
      identifier: string;
      title: string;
      cardArtBase64: string;
      cardholderName: string;
      panSuffix: string;
      pan?: string | null;
      expiryDate?: string | null;
      cardScheme?: string | null;
    }
    export function addCardForUserId({userId , deviceId , cardId , cardHolderName , cardPanSuffix , sessionId,localizedDescription, cardScheme }:CardUserIdDetails): Promise<string> {
      return Fooapplewalletreactplugin.addCardForUserId(userId , deviceId , cardId , cardHolderName , cardPanSuffix , sessionId,localizedDescription,cardScheme);
    }
    export function addCardForPanId({userId , deviceId , cardId , cardHolderName , cardPanSuffix , localizedDescription , pan , expiryDate, cardScheme}:CardPanIdDetails): Promise<string> {
      return Fooapplewalletreactplugin.addCardForUserIdWithPanAndExpiry(userId , deviceId , cardId , cardHolderName , cardPanSuffix , localizedDescription , pan , expiryDate, cardScheme);
    }
    export function deviceSupportsAppleWallet (): Promise<boolean> {
      return Fooapplewalletreactplugin.deviceSupportsAppleWallet();
    }
    export function isCardAddedToLocalWalletWithCardSuffix (cardSuffix:string): Promise<boolean> {
      return Fooapplewalletreactplugin.isCardAddedToLocalWalletWithCardSuffix(cardSuffix);
    }
    export function didGetAvailableLocalCards (cards:ReactCard[]): Promise<void> {
      return Fooapplewalletreactplugin.didGetAvailableLocalCards(cards);
    }
    export function didGetAvailableRemoteCards (cards:ReactCard[]): Promise<void> {
      return Fooapplewalletreactplugin.didGetAvailableRemoteCards(cards);
    }
    export function setAppGroupIdentifier(identifier: string): Promise<string> {
      return Fooapplewalletreactplugin.setAppGroupIdentifier(identifier);
    }
    export function  setExtensionNeedsAuthentication(needsAuthentication: boolean): Promise<string> {
      return Fooapplewalletreactplugin.setExtensionNeedsAuthentication(needsAuthentication);
    }
    export function setExtensionHasAvailableLocalPasses(hasLocalPasses: boolean): Promise<string> {
      return Fooapplewalletreactplugin.setExtensionHasAvailableLocalPasses(hasLocalPasses);
    }
    export function setExtensionHasAvailableRemotePasses(hasRemotePasses: boolean): Promise<string> {
      return Fooapplewalletreactplugin.setExtensionHasAvailableRemotePasses(hasRemotePasses);
    }