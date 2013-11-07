//
//  AppDelegate.h
//  Meeting Tracker
//
//  Created by Quinton Harris on 2013.11.06.
//  Copyright (c) 2013 Quinton Harris. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PreferencesWindowController; 
@interface AppDelegate : NSObject <NSApplicationDelegate>

@property (nonatomic, retain) PreferencesWindowController *preferencesWindowController;

- (IBAction)showPreferencesPanel:(id)sender;

@end
