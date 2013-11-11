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

- (void)setStartingTime:(NSDate *)theDate;
- (NSDate *)startingTime;

- (void)setEndingTime:(NSDate *)theDate;
- (NSDate *)endingTime;

// UI stuff
- (BOOL)meetingNotStarted;
- (BOOL)meetingActive;
- (NSString *)currentTimeString;
- (NSString *)elapsedTimeString;
- (NSNumber *)accruedCost;

- (void)setPersonsPresent:(NSMutableArray *)thePersonsPresent;
- (NSMutableArray *)personsPresent;

- (IBAction)pressedStartMeeting:(id)sender;
- (IBAction)pressedEndMeeting:(id)sender;
- (IBAction)resetMeetingWithCaptains:(id)sender;
- (IBAction)resetMeetingWithMarxBrothers:(id)sender;
- (IBAction)resetMeetingWithStooges:(id)sender;

- (void)updateGUI:(NSTimer *)theTimer;

// Observation
- (void)startObservingMeeting:(Meeting *)theMeeting;
- (void)stopObservingMeeting:(Meeting *)theMeeting;

- (void)startObservingPerson:(Person *)thePerson;
- (void)stopObservingPerson:(Person *)thePerson;

@property (assign) IBOutlet NSButtonCell *startMeetingButton;
@property (assign) IBOutlet NSButton *endMeetingButton;

@property (assign) IBOutlet NSTextField *currentTimeLabel;
@property (assign) IBOutlet NSTextField *meetingStartLabel;

@property (assign) IBOutlet NSTextField *billingRateLiveComputeLabel;
@property (assign) IBOutlet NSTextField *billingRateTargetActionLabel;

@property (assign) IBOutlet NSScrollView *participantsTable;

- (IBAction)pressedLogMeeting:(id)sender;
- (IBAction)pressedLogParticipants:(id)sender;

@end