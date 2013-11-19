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

- (NSPoint)translateViewportPointToData:(NSPoint)viewportPoint;
- (NSPoint)translateDataPointToViewport:(NSPoint)dataPoint;

- (double)translate:(double)aValue aMinValue:(double)originMinValue aMaxValue:(double)originMaxValue bMinValue:(double)bMinValue bMaxValue:(double)bMaxValue;
@end