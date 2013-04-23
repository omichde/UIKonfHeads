//
//  NSString+MD5.m
//  wpbackerygroup
//
//  Created by Oliver Michalak on 29.07.12.
//
//

#import "NSString+MD5.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (MD5)

+ (NSString*) udid {
	CFUUIDRef uuid = CFUUIDCreate(NULL);
	NSString *udid = (__bridge_transfer NSString *) CFUUIDCreateString(NULL, uuid);
	CFRelease(uuid);
	return udid;
}

- (NSString*) md5 {
	NSData *dataIn = [self dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
	NSMutableData *macOut = [NSMutableData dataWithLength:CC_MD5_DIGEST_LENGTH];
	CC_MD5(dataIn.bytes, dataIn.length, macOut.mutableBytes);
	NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
	for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
		[output appendFormat:@"%02x", ((uint8_t*)macOut.mutableBytes)[i]];
	return output;
}

- (NSString*) sha256 {
	NSData *dataIn = [self dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
	NSMutableData *macOut = [NSMutableData dataWithLength:CC_SHA256_DIGEST_LENGTH];
	CC_SHA256(dataIn.bytes, dataIn.length,  macOut.mutableBytes);
	NSMutableString *output = [NSMutableString stringWithCapacity:CC_SHA256_DIGEST_LENGTH * 2];
	for(int i = 0; i < CC_SHA256_DIGEST_LENGTH; i++)
		[output appendFormat:@"%02x", ((uint8_t*)macOut.mutableBytes)[i]];
	return output;
}

@end
