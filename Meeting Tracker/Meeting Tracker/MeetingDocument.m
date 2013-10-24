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
//        _meeting = [[Meeting alloc] init];
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

    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:0.2
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
    return [NSKeyedArchiver archivedDataWithRootObject:[self meeting]];
}

- (BOOL)readFromData:(NSData *)data ofType:(NSString *)typeName error:(NSError **)outError
{
    // Insert code here to read your document from the given data of the specified type. If outError != NULL, ensure that you create and set an appropriate error when returning NO.
    // You can also choose to override -readFromFileWrapper:ofType:error: or -readFromURL:ofType:error: instead.
    // If you override either of these, you should also override -isEntireFileLoaded to return NO if the contents are lazily loaded.
    
    NSLog(@"Unarchive data %@", data);

    if ([data length] > 0) {
        @try {
            [self setMeeting:[NSKeyedUnarchiver unarchiveObjectWithData:data]];
        } @catch (NSException *) {
            NSLog(@"Corrupted Data");
            return NO;
        }
    }
    
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

- (BOOL)meetingNotStarted {
    return ![[self meeting] meetingStarted];
}

- (BOOL)meetingActive {
    return [[self meeting] meetingStarted] && ![[self meeting] meetingEnded];
}

- (NSString *)currentTimeString {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd/MM/yyyy, HH:mm:ss a"];
    [dateFormatter autorelease];
    
    return [dateFormatter stringFromDate:[NSDate date]];
}

- (NSString *)elapsedTimeString {
    return [[self meeting] elapsedTimeDisplayString];
}

- (NSNumber *)accruedCost {
    return [[self meeting] accruedCost];
}

- (IBAction)pressedStartMeeting:(id)sender {
    [self willChangeValueForKey:@"meetingNotStarted"];
    [self willChangeValueForKey:@"meetingActive"];
    
    [[self meeting] setStartingTime: [NSDate date]];
    
    [self didChangeValueForKey:@"meetingNotStarted"];
    [self didChangeValueForKey:@"meetingActive"];
}

- (IBAction)pressedEndMeeting:(id)sender {
    [self willChangeValueForKey:@"meetingActive"];
    
    [[self meeting] setEndingTime: [NSDate date]];
    
    [self didChangeValueForKey:@"meetingActive"];
}

- (void)setPersonsPresent:(NSMutableArray *)thePersonsPresent {
    [[self meeting] setPersonsPresent:thePersonsPresent];
}

- (NSMutableArray *)personsPresent {
    return [[self meeting] personsPresent];
}

- (void)updateGUI:(NSTimer *)theTimer {
    for (NSString *key in @[@"accruedCost", @"elapsedTimeString", @"currentTimeString"]) {
        [self willChangeValueForKey:key];
        [self didChangeValueForKey:key];
    }
  
    NSLog(@"total billing rate %@", [[self meeting] totalBillingRate]);
    [[self billingRateTargetActionLabel] setObjectValue:[[self meeting] totalBillingRate]];
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
