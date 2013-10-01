//
//  DIZAppDelegate.h
//  HelloWorld
//
//  Created by Quinton Harris on 2013.09.30.
//  Copyright (c) 2013 Quinton Harris. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface DIZAppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;
@property (weak) IBOutlet NSSpeechSynthesizer *speechSynthesizer;

- (IBAction)sayHello:(id)sender;

@end