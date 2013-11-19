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

- (WidgetTester *)widgetTester {
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
  [self.widgetTester removeObserver:self
                         forKeyPath:@"testData"
   ];
}

- (void)startWatchingWidgetTester {
  [self.widgetTester addObserver:self
                      forKeyPath:@"testData"
                         options:NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew
                         context:&VoltagePlotViewKVOContext
   ];
}

- (void)drawRect:(NSRect)dirtyRect
{
  [super drawRect:dirtyRect];
  
  NSRect bounds = [self bounds];

  [self drawBackground];
  
  NSBezierPath *voltagePath = [NSBezierPath bezierPath];

  NSPoint originPoint = { .x = 0.0, .y = bounds.size.height / 2 };
  [voltagePath moveToPoint:originPoint];
  
  for (WidgetTestObservationPoint *point in self.widgetTester.testData) {
    [voltagePath lineToPoint:[self translateDataPointToViewport:point]];
  }
  
  [voltagePath lineToPoint:NSMakePoint(self.bounds.size.width, 0.0)];
  [voltagePath lineToPoint:NSMakePoint(0.0, 0.0)];
  [voltagePath lineToPoint:originPoint];
  
  [self drawVoltagePath:voltagePath];
  
  if (self.mouseInViewport) {
    [self drawMouseHover];
  }
}

- (void)drawBackground {
  switch(self.drawMode) {
    case 1: // BAD
      [[NSColor blackColor] set];
      [NSBezierPath fillRect:[self bounds]];
      
      for (NSUInteger i = 0; i < 100; ++i) {
        NSColor *someColor = @[
                               [NSColor purpleColor],
                               [NSColor greenColor],
                               [NSColor magentaColor],
                               [NSColor orangeColor]
                               ][random() % 4];
        
        [someColor set];
      
        
        NSBezierPath *dotPath = [NSBezierPath bezierPath];
        NSPoint circlePoint = NSMakePoint(random() % (long)[self bounds].size.width, random() % (long)[self bounds].size.height);
        NSLog(@"%@", NSStringFromPoint(circlePoint));
        double circleRadius = (double)((long)random() % 10);
        [dotPath appendBezierPathWithOvalInRect: NSMakeRect(circlePoint.x - circleRadius, circlePoint.y - circleRadius, circleRadius * 2, circleRadius * 2)];

        [dotPath fill];
      }
      
      break;
      
    case 2: // UGLY
      for (WidgetTestObservationPoint *point in self.widgetTester.testData) {
        NSPoint translatedPoint = [self translateDataPointToViewport:point];
        
        NSColor *someColor = @[
                               [NSColor purpleColor],
                               [NSColor greenColor],
                               [NSColor magentaColor],
                               [NSColor orangeColor]
                               ][random() % 4];
        [someColor set];
        [NSBezierPath fillRect:NSMakeRect(translatedPoint.x, 0, self.bounds.size.width, self.bounds.size.height)];
        
      }
      
      break;
      
    default: // GOOD
      [[NSColor whiteColor] set];
      [NSBezierPath fillRect:[self bounds]];
  }
}

- (void)drawVoltagePath:(NSBezierPath *)voltagePath {
  switch(self.drawMode) {
    case 1: // BAD
      [[NSColor yellowColor] set];
      [voltagePath stroke];
      [voltagePath fill];
      break;
      
    case 2: // UGLY
            [[NSColor blackColor] set];
      [voltagePath stroke];
      [voltagePath fill];
      break;
      
    default: // GOOD
      [[NSColor colorWithCalibratedRed:0.2 green:0.2 blue:0.2 alpha:1.0] set];
      [voltagePath stroke];
      
  }
}

- (void)drawMouseHover {
  NSColor *backgroundWhite = [NSColor colorWithDeviceWhite:1.0 alpha:0.8];
  
  NSDictionary *attrDictionary = nil;
  
  switch(self.drawMode) {
    case 1: // BAD
      attrDictionary = @{
                         NSFontAttributeName : [NSFont fontWithName:@"Comic Sans MS" size:14.0],
                         NSForegroundColorAttributeName : [NSColor blackColor],
                         NSBackgroundColorAttributeName : backgroundWhite
                         };
      break;
      
    case 2: // UGLY
      attrDictionary = @{
                         NSFontAttributeName : [NSFont fontWithName:@"Comic Sans MS" size:14.0],
                         NSForegroundColorAttributeName : [NSColor blackColor],
                         NSBackgroundColorAttributeName : backgroundWhite
                         };
      break;
      
    default: // GOOD
      attrDictionary = @{
                         NSFontAttributeName : [NSFont fontWithName:@"Courier New" size:14.0],
                         NSForegroundColorAttributeName : [NSColor blackColor],
                         NSBackgroundColorAttributeName : backgroundWhite
                         };
      
      [[NSColor colorWithCalibratedRed:0.2 green:0.2 blue:0.2 alpha:1.0] set];
      
      NSBezierPath *dotPath = [NSBezierPath bezierPath];
      double circleRadius = 5.0;
      [dotPath appendBezierPathWithOvalInRect: NSMakeRect(self.dataViewportPosition.x - circleRadius, self.dataViewportPosition.y - circleRadius, circleRadius * 2, circleRadius * 2)];
      [dotPath fill];
  }
  
  NSString *initString = [NSString stringWithFormat:@" View(%.2f, %.2f)    Data(%.2f, %.2f) ",
                          self.mouseViewportPosition.x, self.mouseViewportPosition.y,
                          self.mouseDataPosition.observationTime, self.mouseDataPosition.voltage
                          ];
  
  NSMutableAttributedString *dataString = [[NSMutableAttributedString alloc] initWithString:initString
                                                                                 attributes:attrDictionary];
  [dataString drawAtPoint:NSMakePoint(
                                      self.mouseViewportPosition.x + 30,
                                      self.mouseViewportPosition.y - 10
                                      )
   ];
}

- (void)mouseEntered:(NSEvent *)theEvent {
  [self mouseMoved:theEvent];
}

- (void)mouseMoved:(NSEvent *)theEvent {
  self.mouseInViewport = YES;
  self.mouseViewportPosition = [self convertPoint:theEvent.locationInWindow fromView:nil];
  self.mouseDataPosition = [self translateViewportPointToData:self.mouseViewportPosition];
  self.dataViewportPosition = [self translateDataPointToViewport:self.mouseDataPosition];
  [self setNeedsDisplay:true];
}

- (void)mouseExited:(NSEvent *)theEvent {
  self.mouseInViewport = NO;
  
  [self setNeedsDisplay:true];
}

- (WidgetTestObservationPoint *)translateViewportPointToData:(NSPoint)viewportPoint  {
  
    NSUInteger index = (NSUInteger)[self translate:viewportPoint.x
        aMinValue:self.bounds.origin.x
        aMaxValue:self.bounds.size.width
        bMinValue:0.0
        bMaxValue:(double)[self.widgetTester.testData count]
   ];
  
  return [self.widgetTester.testData objectAtIndex:index];
}

- (NSPoint)translateDataPointToViewport:(WidgetTestObservationPoint *)dataPoint  {
  NSPoint viewportPoint = {
    .x = [self translate:dataPoint.observationTime
               aMinValue:self.widgetTester.timeMinimum
               aMaxValue:self.widgetTester.timeMaximum
               bMinValue:self.bounds.origin.x
               bMaxValue:self.bounds.size.width
          ],

    .y = [self translate:dataPoint.voltage
               aMinValue:self.widgetTester.sensorMinimum
               aMaxValue:self.widgetTester.sensorMaximum
               bMinValue:self.bounds.origin.y
               bMaxValue:self.bounds.size.height
          ]
  };
  return viewportPoint;
}

- (double)translate:(double)aValue aMinValue:(double)aMinValue aMaxValue:(double)aMaxValue bMinValue:(double)bMinValue bMaxValue:(double)bMaxValue {
  double ratio = (aValue - aMinValue) / (aMaxValue - aMinValue);
  return ratio * (bMaxValue - bMinValue) + bMinValue;
}

@end