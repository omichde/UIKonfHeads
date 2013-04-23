//
//  NSString+MD5.h
//  wpbackerygroup
//
//  Created by Oliver Michalak on 29.07.12.
//
//

#import <Foundation/Foundation.h>

@interface NSString (MD5)

+ (NSString*) udid;
- (NSString*) md5;
- (NSString*) sha256;

@end
