//
//  DIZDocument.m
//  Meeting Tracker
//
//  Created by Quinton Harris on 2013.10.14.
//  Copyright (c) 2013 Quinton Harris. All rights reserved.
//

#import "MeetingDocument.h"

@implementation MeetingDocument

- (id)init
{
    if (self = [super init]) {
        _meeting = [[Meeting meetingWithCaptains] retain];
    }
    
    return self;
}

- (void)dealloc {
    [_meeting release];
    
    if (_timer != nil) {
        [_timer release];
    }
    
    [super dealloc];
}

- (NSString *)windowNibName
{
    // Override returning the nib file name of the document
    // If you need to use a subclass of NSWindowController or if your document supports multiple NSWindowControllers, you should remove this method and override -makeWindowControllers instead.
    return @"MeetingDocument";
}

- (void)windowControllerDidLoadNib:(NSWindowController *)aController
{
    [super windowControllerDidLoadNib:aController];
    [self updateGUI:nil];

    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1
                                                     target:self
                                                    selector:@selector(updateGUI:)
                                                   userInfo:nil
                                                    repeats:YES];
    [self setTimer:timer];
}

+ (BOOL)autosavesInPlace
{
    return YES;
}

- (NSData *)dataOfType:(NSString *)typeName error:(NSError **)outError
{
    // FIXME: placeholder
    return [NSData data];
}

- (BOOL)readFromData:(NSData *)data ofType:(NSString *)typeName error:(NSError **)outError
{
    // Insert code here to read your document from the given data of the specified type. If outError != NULL, ensure that you create and set an appropriate error when returning NO.
    // You can also choose to override -readFromFileWrapper:ofType:error: or -readFromURL:ofType:error: instead.
    // If you override either of these, you should also override -isEntireFileLoaded to return NO if the contents are lazily loaded.
    NSException *exception = [NSException exceptionWithName:@"UnimplementedMethod" reason:[NSString stringWithFormat:@"%@ is unimplemented", NSStringFromSelector(_cmd)] userInfo:nil];
    @throw exception;
    return YES;
}

- (void)windowWillClose:(NSNotification *)notification {
    [[self timer] invalidate];
}

- (Meeting *)meeting { return _meeting; }
- (void)setMeeting:(Meeting *)theMeeting {
    if (_meeting != theMeeting) {
        [theMeeting retain];
        [_meeting release];
        _meeting = theMeeting;
    }
}

- (NSTimer *)timer { return _timer; }
- (void)setTimer:(NSTimer *)theTimer {
    if (_timer != theTimer) {
        [theTimer retain];
        [_timer release];
        _timer = theTimer;
    }
}

- (NSString *)elapsedTimeString {
    return @"hello";
}

- (IBAction)pressedStartMeeting:(id)sender {
    [[self meeting] setStartingTime: [NSDate date]];
}

- (IBAction)pressedEndMeeting:(id)sender {
    [[self meeting] setEndingTime: [NSDate date]];
}

- (IBAction)pressedAddPerson:(id)sender {
}

- (IBAction)pressedRemovePerson:(id)sender {
}

- (IBAction)pressedStopMeeting:(id)sender {
}

- (void)updateGUI:(NSTimer *)theTimer {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd/MM/yyyy, HH:mm:ss a"];
    [[self currentTimeLabel] setStringValue:[dateFormatter stringFromDate:[NSDate date]]];
    [dateFormatter release];
}

- (IBAction)pressedLogMeeting:(id)sender {
    NSLog(@"%@", [[self meeting] description]);
}

- (IBAction)pressedLogParticipants:(id)sender {
    for (Person *person in [[self meeting] personsPresent]) {
        NSLog(@"%@", [person description]);
    }
}
@end
