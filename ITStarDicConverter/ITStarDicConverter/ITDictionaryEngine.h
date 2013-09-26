//
//  ITDictionaryEngine.h
//  Example
//
//  Created by Nguyen Anh Tuan on 30/08/2013.
//  Copyright (c) 2013 tuanit09@gmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ITDictionary;
@class ITWordEntry;

@protocol ITDictionaryEngineDelegate <NSObject>

- (void)dictionaryEngineWillSortDictionary:(ITDictionary *)dictionary;
- (void)dictionaryEngineDidSortDictionary:(ITDictionary *) source withResult:(ITDictionary *)destination;
- (void)dictionaryEngineWillSearchInDictionary:(ITDictionary *)dictionary;
- (void)dictionaryEngineDidSearchInDictionary:(ITDictionary *)dictionary withResult:(NSArray *)results;

@end

@interface ITDictionaryEngine : NSObject

+ (void)sortDictionary:(ITDictionary *)dictionary forTarget:(id<ITDictionaryEngineDelegate>)delegate;
+ (void)searchForWord:(NSString *)word inDictionary:(ITDictionary *)dictionary forTarget:(id<ITDictionaryEngineDelegate>)delegate;
+ (NSString *)meaningForEntry:(ITWordEntry *)entry inDictionary:(ITDictionary *)dictionary;
+ (NSArray *)synonymsForEntry:(ITWordEntry *)entry inDictionary:(ITDictionary *)dictionary;

@end
