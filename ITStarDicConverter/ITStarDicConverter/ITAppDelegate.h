//
//  ITAppDelegate.h
//  ITStarDicConverter
//
//  Created by Nguyen Anh Tuan on 09/09/2013.
//  Copyright (c) 2013 tuanit09@gmail.com. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface ITAppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;

@property (weak) IBOutlet NSTextFieldCell *convertingLabel;
@property (weak) IBOutlet NSLevelIndicator *convertingProgressBar;

@property (weak) IBOutlet NSTextField *inTextBox;

@property (weak) IBOutlet NSTextField *outTextBox;

- (IBAction)inputButtonPressed:(id)sender;

- (IBAction)outputButtonPressed:(id)sender;

- (IBAction)convert:(id)sender;

@end
