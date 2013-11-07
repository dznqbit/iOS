//
//  PreferencesWindowController.m
//  Meeting Tracker
//
//  Created by Quinton Harris on 2013.11.06.
//  Copyright (c) 2013 Quinton Harris. All rights reserved.
//

#import "PreferencesWindowController.h"

@interface PreferencesWindowController ()

@end

@implementation PreferencesWindowController

- (id)init {
    self = [super initWithWindowNibName:@"PreferencesWindowController"];
    return self;
}

- (id)initWithWindow:(NSWindow *)window
{
    self = [super initWithWindow:window];
    if (self) {
        // Initialization code here.
    }
    return self;
}

- (void)windowDidLoad
{
    [super windowDidLoad];
    
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
}

@end
