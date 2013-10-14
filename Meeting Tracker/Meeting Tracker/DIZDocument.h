//
//  DIZDocument.h
//  Meeting Tracker
//
//  Created by Quinton Harris on 2013.10.14.
//  Copyright (c) 2013 Quinton Harris. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "DIZMeeting.h"

@interface DIZDocument : NSDocument
{
    DIZMeeting *_meeting;
    NSTimer *_timer;
}

- (DIZMeeting *)meeting;

@end
