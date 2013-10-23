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

// UI stuff
- (NSString *)elapsedTimeString;

- (IBAction)pressedStartMeeting:(id)sender;
- (IBAction)pressedEndMeeting:(id)sender;
- (IBAction)pressedAddPerson:(id)sender;
- (IBAction)pressedRemovePerson:(id)sender;

- (void)updateGUI:(NSTimer *)theTimer;

@property (assign) IBOutlet NSButtonCell *startMeetingButton;
@property (assign) IBOutlet NSButton *endMeetingButton;

@property (assign) IBOutlet NSTextField *currentTimeLabel;
@property (assign) IBOutlet NSTextField *meetingStartLabel;

- (IBAction)pressedLogMeeting:(id)sender;
- (IBAction)pressedLogParticipants:(id)sender;

@end