//
//  AppDelegate.h
//  VoltagePlotter
//
//  Created by Quinton Harris on 2013.11.18.
//  Copyright (c) 2013 Quinton Harris. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "WidgetTester.h"
#import "VoltagePlotView.h"

@interface AppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;
@property (weak) IBOutlet VoltagePlotView *voltagePlotView;

@property (strong) WidgetTester *widgetTester;

- (void)generateNewTestData;

- (IBAction)pressedNewTestData:(id)sender;
- (IBAction)pressedSummarize:(id)sender;

- (IBAction)selectedDrawMode:(id)sender;

@end