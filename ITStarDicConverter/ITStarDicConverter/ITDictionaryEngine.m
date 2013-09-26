//
//  ITDictionaryEngine.m
//  Example
//
//  Created by Nguyen Anh Tuan on 30/08/2013.
//  Copyright (c) 2013 tuanit09@gmail.com. All rights reserved.
//

#import "ITDictionaryEngine.h"
#import "ITDictionary.h"
#import "ITWordSectionEntry.h"
#import "ITWordEntry.h"
#import "NSData+ZIP.h"


@implementation ITDictionaryEngine


+ (void)searchForWord:(NSString *)word inDictionary:(ITDictionary *)dictionary forTarget:(id<ITDictionaryEngineDelegate>)delegate
{
    [delegate dictionaryEngineWillSearchInDictionary:dictionary];
    __block NSString *__word = word;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            NSArray *results = dictionary.wordEntries;
            if ([__word length]) {
                NSMutableArray *tempDict = nil;
                __word = [__word uppercaseString];
                unichar searchedLetterVal = [__word characterAtIndex:0];
                NSUInteger firstIndex = 0;
                NSUInteger lastIndex = [dictionary.wordSectionEntries count] - 1;
                NSUInteger middleIndex;
                ITWordSectionEntry *middleSectionEntry;
                unichar middleLetterVal;
                do {
                    middleIndex = (firstIndex + lastIndex) / 2;
                    middleSectionEntry = [dictionary.wordSectionEntries objectAtIndex:middleIndex];
                    middleLetterVal = [middleSectionEntry.firstLetter characterAtIndex:0];
                    if (middleLetterVal > searchedLetterVal) {
                        lastIndex = middleIndex;
                    }
                    else if (middleLetterVal < searchedLetterVal)
                    {
                        firstIndex = middleIndex;
                    }
                    else
                    {
                        break;
                    }
                } while (lastIndex > firstIndex);
                if (searchedLetterVal == middleLetterVal) {
                    tempDict = [[NSMutableArray alloc] initWithCapacity:middleSectionEntry.wordCount];
                    NSUInteger entryIndex = middleSectionEntry.firstWordIndex;
                    ITWordEntry *wordEntry = [dictionary.wordEntries objectAtIndex:entryIndex];
                    NSString *entryWord = [wordEntry.word uppercaseString];
                    while ([__word compare:entryWord] == NSOrderedDescending) {
                        //  NSLog(@"compared word = %@", entryWord);
                        entryIndex++;
                        wordEntry = [dictionary.wordEntries objectAtIndex:entryIndex];
                        entryWord = [wordEntry.word uppercaseString];
                        if (entryIndex >= [dictionary.wordEntries count]) {
                            break;
                        }
                    }
                    NSUInteger maxIndex = middleSectionEntry.wordCount + middleSectionEntry.firstWordIndex;
                    while ([entryWord hasPrefix:__word]) {
                        [tempDict addObject:wordEntry];
                        entryIndex ++;

                        if (entryIndex >= maxIndex) {
                            break;
                        }
                        
                        wordEntry = [dictionary.wordEntries objectAtIndex:entryIndex];
                        entryWord = [wordEntry.word uppercaseString];
                    }
                }
                results = tempDict;
            }
            [delegate dictionaryEngineDidSearchInDictionary:dictionary withResult:results];
        });
    });
}

+ (NSString *)meaningForEntry:(ITWordEntry *)entry inDictionary:(ITDictionary *)dictionary
{
    NSFileHandle *file = [NSFileHandle fileHandleForReadingFromURL:dictionary.dataFileURL error:nil];
    [file seekToFileOffset:entry.offset];
    NSData *meaningData = [file readDataOfLength:entry.length];
    [file closeFile];
    return [[NSString alloc] initWithData:meaningData encoding:NSUTF8StringEncoding];
}

+ (NSArray *)synonymsForEntry:(ITWordEntry *)entry inDictionary:(ITDictionary *)dictionary
{
    return nil;
}

+ (void)sortDictionary:(ITDictionary *)dictionary forTarget:(id<ITDictionaryEngineDelegate>)delegate
{
    [delegate dictionaryEngineWillSortDictionary:dictionary];
    [delegate dictionaryEngineDidSortDictionary:dictionary withResult:dictionary];
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        NSMutableData *dicData = [[NSMutableData alloc] initWithCapacity:[[NSData dataWithContentsOfURL:dictionary.dataFileURL] length]];
//        NSFileHandle *file = [NSFileHandle fileHandleForReadingFromURL:dictionary.dataFileURL error:nil];
//        if (file) {
//            for (ITWordEntry *wordEntry in dictionary.wordEntries) {
//                [file seekToFileOffset:wordEntry.offset];
//                    wordEntry.offset = [dicData length]; // update to new offset
//                [dicData appendData:[file readDataOfLength:wordEntry.length]];
//            }
//        }
//        [file closeFile];
//        if ([dicData length]) {
//            NSLog(@"data length = %lu", [[dicData compressedData] length]);
//            if([dicData writeToURL:dictionary.dataFileURL atomically:YES]) // overwrite data file
//            {
//                NSLog(@"overwrite data file OK");
//            }
//            else
//            {
//                NSLog(@"failed to overwrite data file");
//            }
//        }
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [delegate dictionaryEngineDidSortDictionary:dictionary withResult:dictionary];
//        });
//    });
}

@end
