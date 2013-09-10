//
//  NSString+Value.h
//  Example
//
//  Created by Tuan Anh Nguyen on 8/29/13.
//  Copyright (c) 2013 tuanit09@gmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Value)

/**
 Returns substring standing between beginKey string and endKey string.
 
 @param beginKey a string standing right before the expected substring.
 @param endKey  a string standing right after the expected substring.
 
 @return the expected substring.
 
 example:
    - Input string: "version=2.4.2\n"
    - If beginKey = "version=", endKey = "\n" then the substring will be "2.4.2"
 */
- (NSString *)substringBetweenBeinKey:(NSString *)beginKey endKey:(NSString *)endKey;

/**
 Returns an unsigned integer value.
 @return the unsigned integer value.
 */
- (NSUInteger)unsignedIntegerValue;

@end
