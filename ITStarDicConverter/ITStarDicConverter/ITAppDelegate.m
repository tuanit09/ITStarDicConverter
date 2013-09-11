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
    if (self.inURL && self.outURL) {
        ITDictionary *dic = [[ITDictionary alloc] initWithDictionaryFolder:self.inURL];
        [dic loadDictionaryForTarget:self];
    }
}

#pragma -mark Dictionary Delegate
- (void)willLoadDictionary:(ITDictionary *)dic
{
    self.convertingLabel.stringValue = @"loading dictionary......";
    [self.activityIndicator startAnimation:nil];
}

-(void)didLoadDictionary:(ITDictionary *)dic
{
    self.convertingLabel.stringValue = @"dictionary loaded";
    [self.activityIndicator stopAnimation:nil];
    [ITDictionaryEngine shortDictionary:dic forTarget:self];
}

#pragma -mark Dictionary Engine Delegate
-(void)dictionaryEngineWillShortDictionary:(ITDictionary *)dictionary
{
    self.convertingLabel.stringValue = @"shorting dictionary......";
    [self.activityIndicator startAnimation:nil];
}

-(void)dictionaryEngineDidShortDictionary:(ITDictionary *)source withResult:(ITDictionary *)destination
{
    self.convertingLabel.stringValue = @"dictionary shorted";
    [self.activityIndicator stopAnimation:nil];
    [ITZipBlockEngine zipDictionary:destination threshold:kDataSizeLimit forTarget:self];
}

#pragma -mark Zip Engine Delegate
-(void)zipEngineWillZipDictionary:(id)dictionary
{
    self.convertingLabel.stringValue = @"zipping dictionary......";
    [self.activityIndicator startAnimation:nil];
}
-(void)zipEngineDidZipDictionary:(id)dictionary withData:(NSData *)dicZipData
{
    self.convertingLabel.stringValue = @"dictionary zipped";
    [self.activityIndicator stopAnimation:nil];
    NSURL *destinationURL = [self.outURL URLByAppendingPathComponent:@"dict.itz"];
    [dicZipData writeToURL:destinationURL atomically:YES];
    [ITZipBlockEngine parseZipDataURL:destinationURL toFolder:self.outURL forTarget:self];
    self.convertingLabel.stringValue = @"done";
}
-(void)zipEngineWillParseDataURL:(NSURL *)zipDicURL
{
    self.convertingLabel.stringValue = @"parsing dictionary......";
    [self.activityIndicator startAnimation:nil];
}
-(void)zipEngineDidParseDataURL:(NSURL *)zipDicURL
{
    self.convertingLabel.stringValue = @"dictionary parsed";
    [self.activityIndicator stopAnimation:nil];
}

@end
