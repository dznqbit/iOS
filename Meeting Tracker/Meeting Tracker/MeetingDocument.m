//
//  DIZDocument.m
//  Meeting Tracker
//
//  Created by Quinton Harris on 2013.10.14.
//  Copyright (c) 2013 Quinton Harris. All rights reserved.
//

#import "MeetingDocument.h"

@implementation MeetingDocument

static void *MeetingDocumentKVOContext;

- (id)init
{
    if (self = [super init]) {
        _meeting = [[Meeting alloc] init];
        [self startObservingMeeting:[self meeting]];
    }
 
    return self;
}

- (void)dealloc {
    [self stopObservingMeeting:_meeting];
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
  
    // NSLog(@"Unarchive data %@", data);

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
        [self stopObservingMeeting:[self meeting]];

        [theMeeting retain];
        [_meeting release];
        _meeting = theMeeting;

        [self startObservingMeeting:[self meeting]];
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

- (NSDate *)startingTime {
    return self.meeting.startingTime;
}

- (void)setStartingTime:(NSDate *)theStartingTime {
    [self willChangeValueForKey:@"meetingNotStarted"];
    [self willChangeValueForKey:@"meetingActive"];
  
    self.meeting.startingTime = theStartingTime;
  
    [self didChangeValueForKey:@"meetingNotStarted"];
    [self didChangeValueForKey:@"meetingActive"];
}

- (NSDate *)endingTime {
  return self.meeting.endingTime;
}

- (void)setEndingTime:(NSDate *)theEndingTime {
  [self willChangeValueForKey:@"meetingActive"];
  self.meeting.endingTime = theEndingTime;
  [self didChangeValueForKey:@"meetingActive"];
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

- (void)resetMeetingWithMeeting:(Meeting *)meeting {
    [self willChangeValueForKey:@"meetingNotStarted"];
    [self willChangeValueForKey:@"meetingActive"];
    [self willChangeValueForKey:@"personsPresent"];

    [self setMeeting: meeting];

    [self didChangeValueForKey:@"personsPresent"];
    [self didChangeValueForKey:@"meetingActive"];
    [self didChangeValueForKey:@"meetingNotStarted"];
}

- (void)resetMeetingWithCaptains:(id)sender {
    [self resetMeetingWithMeeting:[Meeting meetingWithCaptains]];
}

- (void)resetMeetingWithMarxBrothers:(id)sender {
    [self resetMeetingWithMeeting:[Meeting meetingWithMarxBrothers]];
}

- (void)resetMeetingWithStooges:(id)sender {
    [self resetMeetingWithMeeting:[Meeting meetingWithStooges]];
}

- (IBAction)pressedStartMeeting:(id)sender {
    self.startingTime = [NSDate date];
}

- (IBAction)pressedEndMeeting:(id)sender {
    self.endingTime = [NSDate date];
}

- (void)setPersonsPresent:(NSMutableArray *)thePersonsPresent {
  for (Person *person in [self personsPresent]) {
    [self stopObservingPerson:person];
  }
  
  [[self meeting] setPersonsPresent:thePersonsPresent];
  
  for (Person *person in [self personsPresent]) {
    [self startObservingPerson:person];
  }
}

- (NSMutableArray *)personsPresent {
    return [[self meeting] personsPresent];
}

- (void)updateGUI:(NSTimer *)theTimer {
    for (NSString *key in @[@"accruedCost", @"elapsedTimeString", @"currentTimeString"]) {
        [self willChangeValueForKey:key];
        [self didChangeValueForKey:key];
    }

    [[self billingRateLiveComputeLabel] setObjectValue:[[self personsPresent] valueForKeyPath:@"@sum.hourlyRate"]];
    [[self billingRateTargetActionLabel] setObjectValue:[[self meeting] totalBillingRate]];
}

- (void)changeKeyPath:(NSString *)keyPath
             ofObject:(id)obj
              toValue:(id)newValue {
    NSLog(@"obj %@ changeKeyPath %@", obj, keyPath);
  
     [obj setValue:newValue forKeyPath:keyPath];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (context != &MeetingDocumentKVOContext) {
        [super observeValueForKeyPath:keyPath
                             ofObject:object
                               change:change
                              context:context
        ];
        
        return;
    }
    
    NSLog(@"OVFKP %@", keyPath);
  
    id oldValue = [change objectForKey:NSKeyValueChangeOldKey];
    if (oldValue == [NSNull null]) {
      oldValue = nil;
    }
  
    if ([keyPath isEqualToString:@"personsPresent"]) {
      switch([change[NSKeyValueChangeKindKey] integerValue]) {
        case NSKeyValueChangeSetting:
          [
            [[self undoManager] prepareWithInvocationTarget:self]
            changeKeyPath:keyPath
            ofObject:self
            toValue:oldValue
          ];

          [[self undoManager] setActionName:@"Edit"];
          break;
        case NSKeyValueChangeInsertion:
          NSLog(@"Queue up removal");
          break;
        case NSKeyValueChangeRemoval:
          NSLog(@"Queue up insertion");
          break;
        default:
          NSLog(@"Didn't recognize %ld", (long)[change[NSKeyValueChangeKindKey] integerValue]);
      }
    }
    
    if ([keyPath isEqualToString:@"startingTime"]) {
        [
         [[self undoManager] prepareWithInvocationTarget:self]
            changeKeyPath:keyPath
                 ofObject:self
                  toValue:oldValue
        ];
        
        [[self undoManager] setActionName:@"Start Meeting"];
    }

    if ([keyPath isEqualToString:@"endingTime"]) {
      [
       [[self undoManager] prepareWithInvocationTarget:self]
       changeKeyPath:keyPath
       ofObject:self
       toValue:oldValue
       ];
      
      [[self undoManager] setActionName:@"End Meeting"];
    }
  
    if ([keyPath isEqualToString:@"name"]) {
      [
       [[self undoManager] prepareWithInvocationTarget:self]
       changeKeyPath:keyPath
       ofObject:object
       toValue:oldValue
       ];
      
      [[self undoManager] setActionName:@"Change Attendee Name"];
    }

    if ([keyPath isEqualToString:@"hourlyRate"]) {
      [
       [[self undoManager] prepareWithInvocationTarget:self]
       changeKeyPath:keyPath
       ofObject:object
       toValue:oldValue
       ];
      
      [[self undoManager] setActionName:@"Change Attendee Hourly Rate"];
    }
}

- (void)startObservingMeeting:(Meeting *)theMeeting {
    for (Person *person in theMeeting.personsPresent) {
        [self startObservingPerson:person];
    }
    
    for (NSString *keyPath in @[@"personsPresent", @"startingTime", @"endingTime"]) {
        [theMeeting addObserver:self
                     forKeyPath:keyPath
                        options:NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew
                        context:&MeetingDocumentKVOContext
         ];
    }
}

- (void)stopObservingMeeting:(Meeting *)theMeeting {
  for (Person *person in theMeeting.personsPresent) {
    [self stopObservingPerson:person];
  }
  
  for (NSString *keyPath in @[@"personsPresent", @"startingTime", @"endingTime"]) {
    [theMeeting removeObserver:self
                    forKeyPath:keyPath];
  }
}

- (void)startObservingPerson:(Person *)thePerson {
    for (NSString *keyPath in @[@"name", @"hourlyRate"]) {
        [thePerson addObserver:self
                    forKeyPath:keyPath
                       options:NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew
                       context:&MeetingDocumentKVOContext
         ];
    }
}

- (void)stopObservingPerson:(Person *)thePerson {
    for (NSString *keyPath in @[@"name", @"hourlyRate"]) {
        [thePerson removeObserver:self
                       forKeyPath:keyPath
         ];
    }

}

- (BOOL)validateMenuItem:(NSMenuItem *)menuItem {
    if ([menuItem action] == @selector(pressedStartMeeting:)) {
        return self.meetingNotStarted;
    }
    
    if ([menuItem action] == @selector(pressedEndMeeting:)) {
        return self.meetingActive;
    }

    return true;
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
