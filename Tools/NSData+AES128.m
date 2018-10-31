//
//  NSData+AES128.m
//  Runner
//
//  Created by 赵亮 on 2018/7/26.
//  Copyright © 2018年 The Chromium Authors. All rights reserved.
//

#import "NSData+AES128.h"


@implementation NSData (AES128)

/**
 *  根据CCOperation，确定加密还是解密
 *
 *  @param operation kCCEncrypt -> 加密  kCCDecrypt－>解密
 *  @param key       公钥
 *  @param iv        偏移量
 *
 *  @return 加密或者解密的NSData
 */
- (NSData *)AES128Operation:(CCOperation)operation key:(NSString *)key iv:(NSString *)iv

{
    
    char keyPtr[kCCKeySizeAES128 + 1];
    
    memset(keyPtr, 0, sizeof(keyPtr));
    
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    
    
    char ivPtr[kCCBlockSizeAES128 + 1];
    
    memset(ivPtr, 0, sizeof(ivPtr));
    
    [iv getCString:ivPtr maxLength:sizeof(ivPtr) encoding:NSUTF8StringEncoding];
    
    
    
    NSUInteger dataLength = [self length];
    
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    
    void *buffer = malloc(bufferSize);
    
    
    //设置byte。 
    /***************/
    
    Byte keybyte[] = {
        17, -35, -45, 25, 54, -55, -45, 40, 35, -45, 35, 26, -95, 25, -35, 76
    };
    
    Byte ivbyte[] = {
        -13, 35, -25, 22, 54, -87, 34, -15, -22, 55, 45, -66, 28, 5 - 4, 67, 43
    };
    void const *keyBytes = keybyte;
    void const *initVectorBytes = ivbyte;
    /***************/
    
    size_t numBytesCrypted = 0;
    
    CCCryptorStatus cryptStatus = CCCrypt(operation,
                                          
                                          kCCAlgorithmAES128,
                                          
                                          kCCOptionPKCS7Padding,
                                          
                                          keyBytes,
                                          
                                          kCCBlockSizeAES128,
                                          
                                          initVectorBytes,
                                          
                                          [self bytes],
                                          
                                          dataLength,
                                          
                                          buffer,
                                          
                                          bufferSize,
                                          
                                          &numBytesCrypted);
    
    if (cryptStatus == kCCSuccess) {
        
        return [NSData dataWithBytesNoCopy:buffer length:numBytesCrypted];
        
    }
    
    free(buffer);
    
    return nil;
    
}


- (NSData *)AES128EncryptWithKey:(NSString *)key iv:(NSString *)iv

{
    
    return [self AES128Operation:kCCEncrypt key:key iv:iv];
    
}


- (NSData *)AES128DecryptWithKey:(NSString *)key iv:(NSString *)iv

{
    
    return [self AES128Operation:kCCDecrypt key:key iv:iv];
    
}


@end
