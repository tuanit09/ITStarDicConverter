//
//  ITZipBlockEntry.h
//  ITStarDicConverter
//
//  Created by Nguyen Anh Tuan on 10/09/2013.
//  Copyright (c) 2013 tuanit09@gmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ITZipBlockEntry : NSObject

@property (assign, nonatomic) NSUInteger zipOffset;
@property (assign, nonatomic) NSUInteger dataOffset;
@property (assign, nonatomic) NSUInteger zipSize;
@property (assign, nonatomic) NSUInteger dataSize;

-(NSData *)data;

@end
