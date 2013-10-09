//
//  DIZAppDelegate.m
//  Homework1
//
//  Created by Quinton Harris on 2013.10.08.
//  Copyright (c) 2013 Quinton Harris. All rights reserved.
//

#import "DIZAppDelegate.h"

@implementation DIZAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
}

- (IBAction)topLabelHelloClick:(id)sender {
    [[self topLabel] setTitle:@"Hello"];
}

- (IBAction)topLabelGoodbyeClick:(id)sender {
    [[self topLabel] setTitle:@"Goodbye"];
}

- (IBAction)topLabelCopyClick:(id)sender {
    [
     [self topLabel]
     setTitle:[[self topLabelTextInput] stringValue]
     ];
}

@end