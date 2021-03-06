//
//  AppDelegate.m
//  VoltagePlotter
//
//  Created by Quinton Harris on 2013.11.18.
//  Copyright (c) 2013 Quinton Harris. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
  self.widgetTester = [[WidgetTester alloc] init];
  self.voltagePlotView.widgetTester = self.widgetTester;
  [self generateNewTestData];
}

- (void)generateNewTestData {
  [self.widgetTester performTest];
}

- (IBAction)pressedNewTestData:(id)sender {
  [self generateNewTestData];
}

- (IBAction)pressedSummarize:(id)sender {
  NSPasteboard *pasteboard = [NSPasteboard generalPasteboard];
  [pasteboard clearContents];
  [pasteboard writeObjects: @[self.widgetTester.summary]];
}

- (IBAction)selectedDrawMode:(id)sender {
  self.voltagePlotView.drawMode = [sender selectedSegment];
}

@end
