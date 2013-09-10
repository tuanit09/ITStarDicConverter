//
//  ITZipBlockEngine.h
//  ITStarDicConverter
//
//  Created by Nguyen Anh Tuan on 10/09/2013.
//  Copyright (c) 2013 tuanit09@gmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ITZipBlockEngine;
@class ITDictionary;

@protocol ITZipBlockEngineDelegate <NSObject>

@required
-(void)zipEngineWillZipDictionary:(id)dictionary;
-(void)zipEngineDidZipDictionary:(id)dictionary withData:(NSData *)dicZipData;

@end

@interface ITZipBlockEngine : NSObject

+(void)zipDictionary:(ITDictionary *)dictionary threshold:(NSInteger)maxDataBlockSize forTarget:(id<ITZipBlockEngineDelegate>)target;

@end
