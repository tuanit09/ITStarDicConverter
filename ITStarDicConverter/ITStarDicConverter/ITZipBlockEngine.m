//
//  ITZipBlockEngine.m
//  ITStarDicConverter
//
//  Created by Nguyen Anh Tuan on 10/09/2013.
//  Copyright (c) 2013 tuanit09@gmail.com. All rights reserved.
//

#import "ITZipBlockEngine.h"
#import "ITDictionary.h"
#import "ITZipBlockEntry.h"
#import "ITWordEntry.h"
#import "NSData+ZIP.h"

#define kInfoFileKey            @"infoFileKey"
#define kIndexFileKey           @"indexFileKey"
#define kBlockedDataFileKey     @"blockedDataFileKey"
#define kBlockEntriesFileKey      @"zipEntriesFileKey"

@implementation ITZipBlockEngine

+(void)zipDictionary:(ITDictionary *)dictionary threshold:(NSInteger)maxDataBlockSize forTarget:(id<ITZipBlockEngineDelegate>)target
{
    [target zipEngineWillZipDictionary:dictionary];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSData *inputData = [NSData dataWithContentsOfURL:dictionary.dataFileURL];
        NSMutableData *outputData = [[NSMutableData alloc] initWithCapacity:[inputData length]];
        NSMutableArray *zipBlockEntries = [[NSMutableArray alloc] initWithCapacity:[inputData length] / maxDataBlockSize ];
        ITZipBlockEntry *zipEntry;
        ITWordEntry *beginEntry;
        ITWordEntry *endEntry;
        NSUInteger entryIndex = 0;
        NSUInteger accumulatedSize;
        NSData *zipBlock;
        NSUInteger accunDataSize =0;

        while (entryIndex < [dictionary.wordEntries count]) {
            accumulatedSize = 0;
            beginEntry = [dictionary.wordEntries objectAtIndex:entryIndex];
            do {
                endEntry = [dictionary.wordEntries objectAtIndex:entryIndex];
                accumulatedSize += endEntry.length;
                entryIndex++;
                if (entryIndex == [dictionary.wordEntries count]) {
                    break;
                }
            } while (accumulatedSize < maxDataBlockSize);
            zipEntry = [ITZipBlockEntry new];
            zipEntry.dataOffset = beginEntry.offset;
            zipEntry.dataSize = accumulatedSize;
            zipBlock = [[NSData dataWithBytes:inputData.bytes + zipEntry.dataOffset length:zipEntry.dataSize] compressedData];
            zipEntry.zipOffset = [outputData length];
            zipEntry.zipSize = [zipBlock length];
            [outputData appendData:zipBlock];
            [zipBlockEntries addObject:zipEntry];
            accunDataSize += accumulatedSize;
        }
        NSData *dicZipData = [ITZipBlockEngine zipForDic:dictionary blockedData:outputData blockEntries:zipBlockEntries];
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            [target zipEngineDidZipDictionary:dictionary withData:dicZipData];
        });
    });
}

+(NSData *)zipForDic:(ITDictionary *)dictionary blockedData:(NSData *)blockedData blockEntries:(NSArray *)blockEntries
{
    NSMutableData *zipDic = [[NSMutableData alloc] init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:zipDic];

    // Apend info file
    NSData *infoData = [[NSData dataWithContentsOfURL:dictionary.indexFileURL] compressedData];
    [archiver encodeBytes:infoData.bytes length:[infoData length] forKey:kInfoFileKey];

    // Apend indexFile
    NSMutableData *indexRawData = [[NSMutableData alloc] init];
    for (ITWordEntry *wordEntry in dictionary.wordEntries) {
        [indexRawData appendData:[wordEntry data]];
    }
    NSData *indexData = [indexRawData compressedData];
    [archiver encodeBytes:indexData.bytes length:[indexData length] forKey:kIndexFileKey];

    // Append blocked data
    [archiver encodeBytes:blockedData.bytes length:[blockedData length] forKey:kBlockedDataFileKey];

    // Apend block entries
    NSMutableData *blockEntriesRawData = [[NSMutableData alloc] init];
    for (ITZipBlockEntry *blockEntry in blockEntries) {
        [blockEntriesRawData appendData:[blockEntry data]];
    }
    NSData *blockEntriesData = [blockEntriesRawData compressedData];
    [archiver encodeBytes:blockEntriesData.bytes length:[blockEntriesData length] forKey:kBlockEntriesFileKey];

    //
    [archiver finishEncoding];

    return zipDic;
}

@end
