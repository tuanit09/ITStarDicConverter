//
//  ITAppDelegate.m
//  ITStarDicConverter
//
//  Created by Nguyen Anh Tuan on 09/09/2013.
//  Copyright (c) 2013 tuanit09@gmail.com. All rights reserved.
//

#import "ITAppDelegate.h"
#import "ITDictionary.h"
#import "ITDictionaryEngine.h"
#import "ITZipBlockEngine.h"
#import "ITZipBlockEntry.h"
#import "ITWordEntry.h"
#import "NSData+ZIP.h"

#define kDataSizeLimit  10000000

@interface ITAppDelegate()<ITDictionaryDelegate, ITDictionaryEngineDelegate, ITZipBlockEngineDelegate>

@property (strong, nonatomic) NSURL *inURL;
@property (strong, nonatomic) NSURL *outURL;

@end

@implementation ITAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
}

- (IBAction)inputButtonPressed:(id)sender {
    NSOpenPanel *dialog = [[NSOpenPanel alloc] init];
    [dialog setCanChooseDirectories:YES];
    if ([dialog runModal] == NSOKButton) {
        self.inURL = dialog.URL;
        self.inTextBox.stringValue = [dialog.URL absoluteString];
    }
}

- (IBAction)outputButtonPressed:(id)sender {

    NSOpenPanel *dialog = [[NSOpenPanel alloc] init];
    [dialog setCanChooseDirectories:YES];

    if ([dialog runModal] == NSOKButton) {
        self.outURL = dialog.URL;
        self.outTextBox.stringValue = [dialog.URL absoluteString];
    }
}

- (IBAction)convert:(id)sender {
    NSString *infoFile = [[NSBundle mainBundle] pathForResource:@"en_vi" ofType:@"ifo"];
    NSString *indexFile = [[NSBundle mainBundle] pathForResource:@"en_vi" ofType:@"idx"];
    NSString *dataFile = [[NSBundle mainBundle] pathForResource:@"en_vi" ofType:@"dict"];
    ITDictionary *dic = [[ITDictionary alloc] initWithInfoFile:infoFile indexFile:indexFile dataFile:dataFile synFile:nil];
    [dic loadDictionaryForTarget:self];
}

#pragma -mark Dictionary Delegate
- (void)willLoadDictionary:(ITDictionary *)dic
{
    
}

-(void)didLoadDictionary:(ITDictionary *)dic
{
    [ITDictionaryEngine shortDictionary:dic forTarget:self];
}

#pragma -mark Dictionary Engine Delegate
-(void)dictionaryEngineWillShortDictionary:(ITDictionary *)dictionary
{

}

-(void)dictionaryEngineDidShortDictionary:(ITDictionary *)source withResult:(ITDictionary *)destination
{
    [ITZipBlockEngine zipDictionary:destination threshold:kDataSizeLimit forTarget:self];
}

#pragma -mark Zip Engine Delegate
-(void)zipEngineWillZipDictionary:(id)dictionary
{
    self.convertingLabel.stringValue = @"ziping";
}
-(void)zipEngineDidZipDictionary:(id)dictionary withData:(NSData *)data zipEntries:(NSArray *)zipEntries
{
    ITDictionary *dic = (ITDictionary *)dictionary;

    // Zip InfoFile:
    NSData *zipInfo = [[NSData dataWithContentsOfFile:dic.infoFilePath] compressedData];

    // Zip Index file:
    NSMutableData *mutableData = [[NSMutableData alloc] init];
    for (ITWordEntry *entry in dic.wordEntries) {
        [mutableData appendData:[entry data]];
    }
    NSData *zipIndex = [mutableData compressedData];

    // Zip

    self.convertingLabel.stringValue = @"done";
}

@end
