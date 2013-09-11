//
//  NSString+ZipFileName.m
//  ITStarDicConverter
//
//  Created by Nguyen Anh Tuan on 11/09/2013.
//  Copyright (c) 2013 tuanit09@gmail.com. All rights reserved.
//

#import "NSString+ZipFileName.h"

#define kZipFileExtension           @"itz"
#define kZipInfoFileExtension       @"ifo.itz"
#define kZipIndexFileExtension      @"idx.itz"
#define kZipDataBlockFileExtension       @"blockData.itz"
#define kZipBlockEntryFileExtension @"blockEntries.itz"
#define kZipSynFileExtension        @"syn.itz"

@implementation NSString (ZipFileName)

-(NSString *)infoFileName
{
    return [self stringByReplacingOccurrencesOfString:kZipFileExtension withString:kZipInfoFileExtension];
}
-(NSString *)indexFileName
{
    return [self stringByReplacingOccurrencesOfString:kZipFileExtension withString:kZipIndexFileExtension];
}
-(NSString *)dataFileName
{
    return [self stringByReplacingOccurrencesOfString:kZipFileExtension withString:kZipDataBlockFileExtension];
}
-(NSString *)blockEntryFileName
{
    return [self stringByReplacingOccurrencesOfString:kZipFileExtension withString:kZipBlockEntryFileExtension];
}
-(NSString *)synFileName
{
    return [self stringByReplacingOccurrencesOfString:kZipFileExtension withString:kZipSynFileExtension];
}

@end
