//
//  ITZipBlockEntry.m
//  ITStarDicConverter
//
//  Created by Nguyen Anh Tuan on 10/09/2013.
//  Copyright (c) 2013 tuanit09@gmail.com. All rights reserved.
//

#import "ITZipBlockEntry.h"

@implementation ITZipBlockEntry

-(id)init
{
    if (self = [super init]) {
        _zipOffset = 0;
        _dataOffset = 0;
        _zipSize = 0;
        _dataSize = 0;
    }
    return self;
}


-(NSData *)data
{
    NSMutableData *data = [[NSMutableData alloc] init];

    uint32_t zipOffset = (uint32_t)_zipOffset;
    uint32_t dataOffset = (uint32_t)_dataOffset;
    uint32_t zipSize = (uint32_t)_zipSize;
    uint32_t dataSize = (uint32_t)_dataSize;
    [data appendBytes:&zipOffset length:sizeof(uint32_t)];
    [data appendBytes:&dataOffset length:sizeof(uint32_t)];
    [data appendBytes:&zipSize length:sizeof(uint32_t)];
    [data appendBytes:&dataSize length:sizeof(uint32_t)];
    return data;
}

@end
