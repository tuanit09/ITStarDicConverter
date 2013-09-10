//
//  ITWordEntry.h
//  Example
//
//  Created by Nguyen Anh Tuan on 26/08/2013.
//  Copyright (c) 2013 tuanit09@gmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ITWordEntry : NSObject

@property (strong, readonly, nonatomic)       NSString        *word;      // word
@property (assign, readonly, nonatomic)       NSUInteger      offset;     // offset in data file
@property (assign, readonly, nonatomic)       NSUInteger      length;     // length to retrieve in data file

-(id)initWithWord:(NSString *)word offset:(NSUInteger)offset length:(NSUInteger)length;
-(NSData *)data;

@end
