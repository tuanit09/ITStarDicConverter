//
//  ITWordSectionEntry.m
//  Example
//
//  Created by Nguyen Anh Tuan on 30/08/2013.
//  Copyright (c) 2013 tuanit09@gmail.com. All rights reserved.
//

#import "ITWordSectionEntry.h"

@implementation ITWordSectionEntry

- (id)initWithFirstLetter:(NSString *)letter firstWordIndex:(NSUInteger)index wordCount:(NSUInteger)count
{
    if (self = [super init]) {
        _firstLetter = letter;
        _firstWordIndex = index;
        _wordCount = count;
    }
    return  self;
}

@end
