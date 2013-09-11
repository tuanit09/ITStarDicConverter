//
//  NSData+ZIP.h
//  Example
//
//  Created by Nguyen Anh Tuan on 09/09/2013.
//  Copyright (c) 2013 tuanit09@gmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (ZIP)

-(NSData *)compressedData;
-(NSData *)uncompressedData;

@end
