//
//  ReactCard.h
//  Fooapplewalletreactplugin
//
//  Created by Sami Sharafeddine on 28/05/2024.
//  Copyright © 2024 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ReactCard : NSObject

@property (strong, nonatomic) NSString *identifier;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *cardArtBase64;
@property (strong, nonatomic) NSString *cardholderName;
@property (strong, nonatomic) NSString *panSuffix;
@property (strong, nonatomic) NSString *pan;
@property (strong, nonatomic) NSString *expiryDate;

@end

NS_ASSUME_NONNULL_END
