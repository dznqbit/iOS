//
//  DIZAppDelegate.m
//  Homework1
//
//  Created by Quinton Harris on 2013.10.08.
//  Copyright (c) 2013 Quinton Harris. All rights reserved.
//

#import "DIZAppDelegate.h"

@implementation DIZAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    [self updateSeasonsLabel:@"December"];
}

// Top Label

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

// 0-1-2

- (IBAction)zeroOneTwoClick:(id)sender {
    NSInteger selectedIndex = [[self zeroOneTwoOutlet] selectedSegment];
    
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setNumberStyle:NSNumberFormatterSpellOutStyle];
    [numberFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en"]];
    NSString *numberString = [[numberFormatter stringFromNumber:[NSNumber numberWithInt:(int)selectedIndex]] capitalizedString];
    
    NSString *labelString = [NSString stringWithFormat:@"%d: %@", (int)selectedIndex, numberString];
    [[self zeroOneTwoLabel] setTitle:labelString];
    
    // [numberFormatter release]; ARC prevents this
}

// Seasons

- (IBAction)winterClick:(id)sender {
    [self updateSeasonsLabel:@"December"];
}

- (IBAction)springClick:(id)sender {
    [self updateSeasonsLabel:@"March"];
}

- (IBAction)summerClick:(id)sender {
    [self updateSeasonsLabel:@"June"];
}

- (IBAction)fallClick:(id)sender {
    [self updateSeasonsLabel:@"September"];
}

- (void)updateSeasonsLabel:(NSString *)seasonStart {
    [[self seasonsLabel] setTitle:seasonStart];
}

@end