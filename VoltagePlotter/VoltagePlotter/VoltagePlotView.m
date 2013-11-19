//
//  VoltagePlotView.m
//  VoltagePlotter
//
//  Created by Quinton Harris on 2013.11.18.
//  Copyright (c) 2013 Quinton Harris. All rights reserved.
//

#import "VoltagePlotView.h"

@implementation VoltagePlotView

static void *VoltagePlotViewKVOContext;

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        NSTrackingArea *ta = [[NSTrackingArea alloc] initWithRect:NSZeroRect
                                                          options:(NSTrackingMouseEnteredAndExited
                                                                   | NSTrackingMouseMoved
                                                                   | NSTrackingActiveAlways
                                                                   | NSTrackingInVisibleRect)
                                                            owner:self
                                                         userInfo:nil];
        [self addTrackingArea:ta];

    }
    return self;
}

- (void)dealloc {
  if (_widgetTester != nil) {
    [self stopWatchingWidgetTester];
  }
}

- (void)setWidgetTester:(WidgetTester *)theWidgetTester {
  if (_widgetTester != nil) {
    [self stopWatchingWidgetTester];
  }
  
  _widgetTester = theWidgetTester;
  
  [self startWatchingWidgetTester];
}

- (WidgetTester *)getWidgetTester {
  return _widgetTester;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
  if (context != &VoltagePlotViewKVOContext) {
    [super observeValueForKeyPath:keyPath
                         ofObject:object
                           change:change
                          context:context
     ];
    return;
  }
  
  if ([keyPath isEqualToString:@"testData"]) { // damn well better
    [self setNeedsDisplay:true];
  }
}

- (void)stopWatchingWidgetTester {
  [[self getWidgetTester] removeObserver:self
                              forKeyPath:@"testData"
   ];
}

- (void)startWatchingWidgetTester {
  [[self getWidgetTester] addObserver:self
                           forKeyPath:@"testData"
                              options:NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew
                              context:&VoltagePlotViewKVOContext
   ];
}

- (void)drawRect:(NSRect)dirtyRect
{
  [super drawRect:dirtyRect];
  
  NSRect bounds = [self bounds];
  
  [[NSColor blackColor] set];
  
  [NSBezierPath fillRect:bounds];
}

- (void)mouseMoved:(NSEvent *)theEvent {
  NSLog(@"mouseMoved: %@", NSStringFromPoint(theEvent.locationInWindow));
}

- (NSPoint)translateDataPointToViewport:(NSPoint)dataPoint  {
  NSPoint viewportPoint = {
    .x = [self translate:dataPoint.x
               aMinValue:[[self getWidgetTester] timeMinimum]
               aMaxValue:[[self getWidgetTester] timeMaximum]
               bMinValue:self.bounds.origin.x
               bMaxValue:self.bounds.size.width
          ],

    .y = [self translate:dataPoint.y
               aMinValue:[[self getWidgetTester] sensorMinimum]
               aMaxValue:[[self getWidgetTester] sensorMaximum]
               bMinValue:self.bounds.origin.y
               bMaxValue:self.bounds.size.height
          ]
  };
  return viewportPoint;
}

- (NSPoint)translateViewportPointToData:(NSPoint)viewportPoint  {
  NSPoint dataPoint = {
    .x = [self translate:viewportPoint.x
               aMinValue:self.bounds.origin.x
               aMaxValue:self.bounds.size.width
               bMinValue:[[self getWidgetTester] timeMinimum]
               bMaxValue:[[self getWidgetTester] timeMaximum]
          ],
    
    .y = [self translate:viewportPoint.y
               aMinValue:self.bounds.origin.y
               aMaxValue:self.bounds.size.height
               bMinValue:[[self getWidgetTester] sensorMinimum]
               bMaxValue:[[self getWidgetTester] sensorMaximum]
          ]
  };
  
  return dataPoint;
}

- (double)translate:(double)aValue aMinValue:(double)aMinValue aMaxValue:(double)aMaxValue bMinValue:(double)bMinValue bMaxValue:(double)bMaxValue {
  double ratio = (aValue - aMinValue) / (aMaxValue - aMinValue);
  return ratio * (bMaxValue - bMinValue) + bMinValue;
}

@end