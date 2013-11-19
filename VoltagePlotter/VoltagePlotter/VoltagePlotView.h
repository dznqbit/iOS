//
//  VoltagePlotView.h
//  VoltagePlotter
//
//  Created by Quinton Harris on 2013.11.18.
//  Copyright (c) 2013 Quinton Harris. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "WidgetTester.h"
#import "WidgetTestObservationPoint.h"

@interface VoltagePlotView : NSView {
  WidgetTester *_widgetTester;
}

@property (nonatomic,assign)NSUInteger drawMode;
@property (nonatomic,assign)BOOL mouseInViewport;
@property (nonatomic,assign)NSPoint mouseViewportPosition;
@property (nonatomic,assign)NSPoint mouseTranslatedViewportPosition;
@property (nonatomic,weak)WidgetTestObservationPoint *mouseDataPosition;

- (void)setWidgetTester:(WidgetTester *)theWidgetTester;
- (WidgetTester *)widgetTester;

- (void)startWatchingWidgetTester;
- (void)stopWatchingWidgetTester;

- (void)drawBackground;
- (void)drawVoltagePath:(NSBezierPath *)voltagePath;
- (void)drawMouseHover;

- (WidgetTestObservationPoint *)translateViewportPointToData:(NSPoint)viewportPoint;
- (NSPoint)translateDataPointToViewport:(WidgetTestObservationPoint *)dataPoint;

- (double)translate:(double)aValue aMinValue:(double)originMinValue aMaxValue:(double)originMaxValue bMinValue:(double)bMinValue bMaxValue:(double)bMaxValue;
@end