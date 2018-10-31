//
//  NSData+AES128.h
//  Runner
//
//  Created by 赵亮 on 2018/7/26.
//  Copyright © 2018年 The Chromium Authors. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonCryptor.h>

@interface NSData (AES128)

/**
 *  加密
 *
 *  @param key 公钥
 *  @param iv  偏移量
 *
 *  @return 加密之后的NSData
 */
- (NSData *)AES128EncryptWithKey:(NSString *)key iv:(NSString *)iv;
/**
 *  解密
 *
 *  @param key 公钥
 *  @param iv  偏移量
 *
 *  @return 解密之后的NSData
 */
- (NSData *)AES128DecryptWithKey:(NSString *)key iv:(NSString *)iv;

@end
