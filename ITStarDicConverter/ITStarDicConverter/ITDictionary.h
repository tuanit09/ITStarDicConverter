//
//  ITDictionary.h
//  Example
//
//  Created by Nguyen Anh Tuan on 26/08/2013.
//  Copyright (c) 2013 tuanit09@gmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ITDictionary;
@class ITDictionaryInfo;

@protocol ITDictionaryDelegate <NSObject>

-(void)willLoadDictionary:(ITDictionary *)dic;
-(void)didLoadDictionary:(ITDictionary *)dic;

@end

@interface ITDictionary : NSObject

@property (strong, readonly, nonatomic) NSURL        *infoFileURL;      // path to info file.
@property (strong, readonly, nonatomic) NSURL        *indexFileURL;     // path to index file.
@property (strong, readonly, nonatomic) NSURL        *dataFileURL;      // path to data file.
@property (strong, readonly, nonatomic) NSURL        *synFileURL;       // path to synonym file.
@property (strong, readonly, nonatomic) NSArray         *wordEntries;           // list of entries initialized at same time with ITDictionary object.
@property (strong, readonly, nonatomic) NSArray         *wordSectionEntries;
@property (assign, readonly, nonatomic) NSUInteger      sectionAIndex;
@property (assign, readonly, nonatomic) unichar         letterAValue;

/* info */
@property (strong, readonly, nonatomic) NSString        *version;
@property (strong, readonly, nonatomic) NSString        *bookName;
@property (assign, readonly, nonatomic) NSUInteger      wordCount;
@property (assign, readonly, nonatomic) NSUInteger      synWordCount;
@property (assign, readonly, nonatomic) NSUInteger      idxFileSize;
@property (assign, readonly, nonatomic) NSUInteger      idxOffsetBits;
@property (strong, readonly, nonatomic) NSString        *author;
@property (strong, readonly, nonatomic) NSString        *email;
@property (strong, readonly, nonatomic) NSString        *website;
@property (strong, readonly, nonatomic) NSString        *description;
@property (strong, readonly, nonatomic) NSDate          *date;
@property (strong, readonly, nonatomic) NSString        *sameTypeSequence;


/**
 Init new ITDictionary object with its' data folder.
 */
- (id) initWithDictionaryFolder:(NSURL *)folderURL;

/**
 Init new ITDictionary object with its' data files.
 */
- (id) initWithInfoFile:(NSURL *)infoFileURL indexFile:(NSURL *)indexFileURL dataFile:(NSURL *)dataFileURL synFile:(NSURL *)synFileURL;

/**
 Load dictionary data including: info file, index file, syn file.
 Data is loaded asynchronously.
 */
- (void)loadDictionaryForTarget:(id<ITDictionaryDelegate>)delegate;

@end
