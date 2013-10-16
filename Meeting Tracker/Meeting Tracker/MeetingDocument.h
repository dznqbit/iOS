//
//  DIZDocument.h
//  Meeting Tracker
//
//  Created by Quinton Harris on 2013.10.14.
//  Copyright (c) 2013 Quinton Harris. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Meeting.h"
#import "Person.h"

@interface MeetingDocument : NSDocument
{
    Meeting *_meeting;
    NSTimer *_timer;
}

- (Meeting *)meeting;
- (void)setMeeting:(Meeting *)theMeeting;
- (NSTimer *)timer;
- (void)setTimer:(NSTimer *)theTimer;

- (void)updateGUI:(NSTimer *)theTimer;

@property (assign) IBOutlet NSTextField *currentTimeLabel;

- (IBAction)pressedLogMeeting:(id)sender;
- (IBAction)pressedLogParticipants:(id)sender;

@end