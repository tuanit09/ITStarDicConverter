//
//  NSData+ZIP.m
//  Example
//
//  Created by Nguyen Anh Tuan on 09/09/2013.
//  Copyright (c) 2013 tuanit09@gmail.com. All rights reserved.
//

#import "NSData+ZIP.h"
#import <zlib.h>


#define CHUNK 16384
#define COMPRESS_LEVEL 9

@implementation NSData (ZIP)

-(NSData *)compressedData
{

    int ret;
    unsigned have;
    z_stream strm;
    unsigned char out[CHUNK];

    /* allocate deflate state */
    strm.zalloc = Z_NULL;
    strm.zfree = Z_NULL;
    strm.opaque = Z_NULL;
    ret = deflateInit(&strm, COMPRESS_LEVEL);
    if (ret != Z_OK)
        return nil;

    strm.next_in = (Bytef *)self.bytes;
    strm.avail_in = [self length];

    NSMutableData *compressedData = [[NSMutableData alloc] initWithCapacity:[self length]];
    do {
        strm.avail_out = CHUNK;
        strm.next_out = out;
        ret = deflate(&strm, Z_FINISH);    /* no bad return value */
        have = CHUNK - strm.avail_out;
        [compressedData appendBytes:out length:have];
    } while (strm.avail_out == 0);
    /* clean up and return */
    (void)deflateEnd(&strm);
    return compressedData;
}

-(NSData *)uncompressedData
{
    int ret;
    unsigned have;
    z_stream strm;
    unsigned char out[CHUNK];

    /* allocate inflate state */
    strm.zalloc = Z_NULL;
    strm.zfree = Z_NULL;
    strm.opaque = Z_NULL;
    strm.avail_in = 0;
    strm.next_in = Z_NULL;
    ret = inflateInit(&strm);
    if (ret != Z_OK)
        return nil;

    strm.avail_in = [self length];
    strm.next_in = (Bytef *)self.bytes;

    NSMutableData *uncompressedData = [[NSMutableData alloc] initWithCapacity:[self length] *2];

        /* run inflate() on input until output buffer not full */
    do {
        strm.avail_out = CHUNK;
        strm.next_out = out;
        ret = inflate(&strm, Z_NO_FLUSH);
        switch (ret) {
            case Z_NEED_DICT:
                ret = Z_DATA_ERROR;     /* and fall through */
            case Z_DATA_ERROR:
            case Z_MEM_ERROR:
                (void)inflateEnd(&strm);
                return nil;
        }
        have = CHUNK - strm.avail_out;

        [uncompressedData appendBytes:out length:have];
    } while (strm.avail_out == 0);

    /* clean up and return */
    (void)inflateEnd(&strm);
    return uncompressedData;
}

@end
