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
        // Initialization code here.
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

- (void)drawRect:(NSRect)dirtyRect
{
  [super drawRect:dirtyRect];
  
  NSRect bounds = [self bounds];
  NSLog(@"draw");
  
  switch(rand() % 3) {
    case 0:
      [[NSColor greenColor] set];
      break;
      
    case 1:
      [[NSColor redColor] set];
      break;
      
    case 2:
      [[NSColor blackColor] set];
      break;
      
    default:
      [[NSColor yellowColor] set];
  }

  [NSBezierPath fillRect:bounds];
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

  NSLog(@"OVFKP %@", keyPath);
  
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
@end
