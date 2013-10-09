//
//  DIZAppDelegate.h
//  Homework1
//
//  Created by Quinton Harris on 2013.10.08.
//  Copyright (c) 2013 Quinton Harris. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface DIZAppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;

// Top Label

@property (weak) IBOutlet NSTextFieldCell *topLabel;
@property (weak) IBOutlet NSTextField *topLabelTextInput;

- (IBAction)topLabelHelloClick:(id)sender;
- (IBAction)topLabelGoodbyeClick:(id)sender;
- (IBAction)topLabelCopyClick:(id)sender;

// 0-1-2

@property (weak) IBOutlet NSSegmentedCell *zeroOneTwoOutlet;

- (IBAction)zeroOneTwoClick:(id)sender;
@property (weak) IBOutlet NSTextFieldCell *zeroOneTwoLabel;

@end