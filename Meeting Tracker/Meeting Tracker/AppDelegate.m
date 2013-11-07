//
//  AppDelegate.m
//  Meeting Tracker
//
//  Created by Quinton Harris on 2013.11.06.
//  Copyright (c) 2013 Quinton Harris. All rights reserved.
//

#import "AppDelegate.h"
#import "PreferencesWindowController.h"

@implementation AppDelegate
- (void)applicationDidFinishLaunching:(NSNotification *) theNotification {
}

+ (void)initialize {
    [self registerStandardDefaults];
}

+ (void)registerStandardDefaults {
    NSMutableDictionary *defaultValues = [NSMutableDictionary dictionary];
    defaultValues[@"personName"] =  @"diz";
    defaultValues[@"personHourlyRate"] = @10.;
    
    [[NSUserDefaults standardUserDefaults] registerDefaults:defaultValues];
}

- (IBAction)showPreferencesPanel:(id)sender {
    if (!self.preferencesWindowController) {
        self.preferencesWindowController = [[[PreferencesWindowController alloc] init] autorelease];
    }
    
    [self.preferencesWindowController window];
}

- (void)startMeeting:(id)sender {
}

@end