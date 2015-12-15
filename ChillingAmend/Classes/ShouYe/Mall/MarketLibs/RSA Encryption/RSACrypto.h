//
//  RSACrypto.h
//
//  Modified by Rohan Aurora on 10/7/14.
//  Based on code by http://blog.iamzsx.me/show.html?id=155002
//
//  Created by Carlos Júnior on 09/16/13.
//  Copyright (c) 2013 Carlos Júnior https://github.com/xjunior/XRSA
//
//  Permission is given to use this source code file, free of charge, in any
//  project, commercial or otherwise, entirely at your risk, with the condition
//  that any redistribution (in part or whole) of source code must retain
//  this copyright and permission notice. Attribution in compiled projects is
//  appreciated but not required.
//

#import <Foundation/Foundation.h>

@interface RSACrypto : NSObject

- (RSACrypto *)initWithPublicKey:(NSString *)publicKeyPath;
- (NSString *) encryptToString:(NSString *)plainText;

+(NSString *)rsaEncryptionResult:(NSString *)plainText;
@end
