//
//  VoltagePlotView.h
//  VoltagePlotter
//
//  Created by Quinton Harris on 2013.11.18.
//  Copyright (c) 2013 Quinton Harris. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "WidgetTester.h"

@interface VoltagePlotView : NSView {
  WidgetTester *_widgetTester;
}

- (void)setWidgetTester:(WidgetTester *)theWidgetTester;
- (WidgetTester *)getWidgetTester;

- (void)startWatchingWidgetTester;
- (void)stopWatchingWidgetTester;

@end
