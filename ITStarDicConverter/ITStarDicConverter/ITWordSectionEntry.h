//
//  ITWordSectionEntry.h
//  Example
//
//  Created by Nguyen Anh Tuan on 30/08/2013.
//  Copyright (c) 2013 tuanit09@gmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ITWordSectionEntry : NSObject

@property (strong, readonly, nonatomic) NSString        *firstLetter;
@property (assign, readonly, nonatomic) NSUInteger      firstWordIndex;
@property (assign, nonatomic) NSUInteger      wordCount;

- (id)initWithFirstLetter:(NSString *)letter firstWordIndex:(NSUInteger)index wordCount:(NSUInteger)count;

@end
