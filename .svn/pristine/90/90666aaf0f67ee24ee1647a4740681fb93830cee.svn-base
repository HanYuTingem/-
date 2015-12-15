//
//  RSACrypto.m
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

#import "RSACrypto.h"

@interface RSACrypto () {
    SecKeyRef publicKey;
    SecCertificateRef certificate;
    SecPolicyRef policy;
    SecTrustRef trust;
    size_t maxPlainLen;
}
- (RSACrypto *)initWithData:(NSData *)keyData;
- (NSData *) encryptWithData:(NSData *)content;
- (NSData *) encryptWithString:(NSString *)content;
@end

@implementation RSACrypto

- (RSACrypto *)initWithData:(NSData *)keyData {
    self = [super init];
    
    if (self) {
        if (keyData == nil) {
            return nil;
        }
        
        certificate = SecCertificateCreateWithData(kCFAllocatorDefault, ( __bridge CFDataRef) keyData);
        if (certificate == nil) {
            NSLog(@"Can not read certificate from data");
            return nil;
        }
        
        policy = SecPolicyCreateBasicX509();
        OSStatus returnCode = SecTrustCreateWithCertificates(certificate, policy, &trust);
        if (returnCode != 0) {
            NSLog(@"SecTrustCreateWithCertificates fail. Error Code: %d", (int)returnCode);
            return nil;
        }
        
        SecTrustResultType trustResultType;
        returnCode = SecTrustEvaluate(trust, &trustResultType);
        if (returnCode != 0) {
            return nil;
        }
        
        publicKey = SecTrustCopyPublicKey(trust);
        if (publicKey == nil) {
            NSLog(@"SecTrustCopyPublicKey fail");
            return nil;
        }
        
        maxPlainLen = SecKeyGetBlockSize(publicKey) - 12;
    }
    
    return self;
}

- (RSACrypto *)initWithPublicKey:(NSString *)publicKeyPath {
    if (publicKeyPath == nil) {
        NSLog(@"Can not find %@", publicKeyPath);
        return nil;
    }
    
    NSData *publicKeyFileContent = [NSData dataWithContentsOfFile:publicKeyPath];
    
    return [self initWithData:publicKeyFileContent];
}

- (NSData *) encryptWithData:(NSData *)content {
    size_t plainLen = [content length];
    if (plainLen > maxPlainLen) {
        NSLog(@"content(%ld) is too long, must < %ld", plainLen, maxPlainLen);
        return nil;
    }
    
    void *plain = malloc(plainLen);
    [content getBytes:plain
               length:plainLen];
    
    size_t cipherLen = 2048; // currently RSA key length is set to 128 bytes
    void *cipher = malloc(cipherLen);
    
    OSStatus returnCode = SecKeyEncrypt(publicKey, kSecPaddingPKCS1, plain,
                                        plainLen, cipher, &cipherLen);
    
    NSData *result = nil;
    if (returnCode != 0) {
        NSLog(@"SecKeyEncrypt fail. Error Code: %d", (int)returnCode);
    }
    else {
        result = [NSData dataWithBytes:cipher
                                length:cipherLen];
    }
    
    free(plain);
    free(cipher);
    
    return result;
}

- (NSData *) encryptWithString:(NSString *)content {
    return [self encryptWithData:[content dataUsingEncoding:NSUTF8StringEncoding]];
}

- (NSString *) encryptToString:(NSString *)plainText {
    NSData *data = [self encryptWithString:plainText];
    return [self base64forData:data];
}

// convert NSData to NSString
- (NSString*)base64forData:(NSData*)theData {
    const uint8_t* input = (const uint8_t*)[theData bytes];
    NSInteger length = [theData length];
    
    static char table[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=";
    
    NSMutableData* data = [NSMutableData dataWithLength:((length + 2) / 3) * 4];
    uint8_t* output = (uint8_t*)data.mutableBytes;
    
    NSInteger i;
    for (i=0; i < length; i += 3) {
        NSInteger value = 0;
        NSInteger j;
        for (j = i; j < (i + 3); j++) {
            value <<= 8;
            
            if (j < length) {
                value |= (0xFF & input[j]);
            }
        }
        
        NSInteger theIndex = (i / 3) * 4;
        output[theIndex + 0] =                    table[(value >> 18) & 0x3F];
        output[theIndex + 1] =                    table[(value >> 12) & 0x3F];
        output[theIndex + 2] = (i + 1) < length ? table[(value >> 6)  & 0x3F] : '=';
        output[theIndex + 3] = (i + 2) < length ? table[(value >> 0)  & 0x3F] : '=';
    }
    
    return [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
}

- (void)dealloc{
    CFRelease(certificate);
    CFRelease(trust);
    CFRelease(policy);
    CFRelease(publicKey);
}

-(id)init{
    
    self = [super init];
    if (self) {
    }
    return self;
}

+(NSString *)rsaEncryptionResult:(NSString *)plainText;
{
    NSString *keypath = [[NSBundle mainBundle] pathForResource:@"public_key" ofType:@"der"];
    RSACrypto *rsaObject = [[RSACrypto alloc] initWithPublicKey:keypath];
    return [rsaObject encryptToString:plainText];
}

@end
