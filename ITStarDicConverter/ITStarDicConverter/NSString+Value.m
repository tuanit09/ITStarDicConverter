//
//  NSString+Value.m
//  Example
//
//  Created by Tuan Anh Nguyen on 8/29/13.
//  Copyright (c) 2013 tuanit09@gmail.com. All rights reserved.
//

#import "NSString+Value.h"

@implementation NSString (Value)

- (NSString *)substringBetweenBeinKey:(NSString *)beginKey endKey:(NSString *)endKey
{
    NSRange range = [self rangeOfString:beginKey];
    if (range.location == NSNotFound) {
        return nil;
    }
    NSString *tempStr = [self substringFromIndex:range.location + range.length];
    range = [tempStr rangeOfString:endKey];
    if (range.location == NSNotFound) {
        return nil;
    }
    return [tempStr substringToIndex:range.location];
}

- (NSUInteger)unsignedIntegerValue
{
    NSUInteger value;
    sscanf([self UTF8String], "%lu", &value);
    return value;
}


@end
