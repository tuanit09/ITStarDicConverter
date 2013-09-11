//
//  NSString+ZipFileName.h
//  ITStarDicConverter
//
//  Created by Nguyen Anh Tuan on 11/09/2013.
//  Copyright (c) 2013 tuanit09@gmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (ZipFileName)

-(NSString *)infoFileName;
-(NSString *)indexFileName;
-(NSString *)dataFileName;
-(NSString *)blockEntryFileName;
-(NSString *)synFileName;

@end
