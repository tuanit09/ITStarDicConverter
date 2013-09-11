//
//  ITWordEntry.m
//  Example
//
//  Created by Nguyen Anh Tuan on 26/08/2013.
//  Copyright (c) 2013 tuanit09@gmail.com. All rights reserved.
//

#import "ITWordEntry.h"

@implementation ITWordEntry

- (id)initWithWord:(NSString *)word offset:(NSUInteger)offset length:(NSUInteger)length
{
    if (self = [super init]) {
        _word = word;
        _offset = offset;
        _length = length;
    }
    return self;
}

-(NSData *)data
{
    NSMutableData *data = [[NSMutableData alloc] init];
    Byte byte = '\0'; // end of word
    [data appendData:[self.word dataUsingEncoding:NSUTF8StringEncoding]];
    [data appendBytes:&byte length:sizeof(Byte)];
    uint32_t offset = (uint32_t)_offset;
    uint32_t length = (uint32_t)_length;
    [data appendData:[NSData dataWithBytes:&offset length:sizeof(uint32_t)]];
    [data appendData:[NSData dataWithBytes:&length length:sizeof(uint32_t)]];
    return data;
}


@end
