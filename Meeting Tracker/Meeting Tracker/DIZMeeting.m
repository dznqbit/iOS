//
//  DIZMeeting.m
//  Meeting Tracker
//
//  Created by Quinton Harris on 2013.10.14.
//  Copyright (c) 2013 Quinton Harris. All rights reserved.
//

#import "DIZMeeting.h"
#import "DIZPerson.h"

@implementation DIZMeeting

// Start & Stop Set/Get

- (NSDate *)startingTime { return _startingTime; }
- (void)setStartingTime:(NSDate *)theStartingTime {
    if (_startingTime != theStartingTime) {
        [_startingTime release];
        [theStartingTime retain];
        _startingTime = theStartingTime;
    }
}

- (NSDate *)endingTime { return _endingTime; }
- (void)setEndingTime:(NSDate *)theEndingTime {
    if (_endingTime != theEndingTime) {
        [_endingTime release];
        [theEndingTime retain];
        _endingTime = theEndingTime;
    }
}

// Persons Present

- (NSMutableArray *)personsPresent { return _personsPresent; }
- (void)setPersonsPresent:(NSMutableArray *)thePersonsPresent {
    if (_personsPresent != thePersonsPresent) {
        [_personsPresent release];
        [thePersonsPresent retain];
        _personsPresent = thePersonsPresent;
    }
}

- (void)addToPersonsPresent:(id)thePerson {
    // TODO: do we need to prevent double-addition?
    [thePerson retain];
    [[self personsPresent] addObject:thePerson];
}

- (void)removeFromPersonsPresent:(id)thePerson {
    [[self personsPresent] removeObject:thePerson];
    [thePerson release];
}

- (void)removeObjectFromPersonsPresentAtIndex:(NSUInteger)index {
    DIZPerson *person = [[self personsPresent] objectAtIndex:index];
    [[self personsPresent] removeObjectAtIndex:index];
    [person release];
}

- (void)insertObject:(id)theObject inPersonsPresentAtIndex:(NSUInteger)index {
    [theObject retain];
    [[self personsPresent] insertObject:theObject atIndex:index];
}

- (NSUInteger)countOfPersonsPresent {
    return [[self personsPresent] count];
}

- (NSUInteger)elapsedSeconds {
    NSDate *currentTime = [NSDate date];
    NSTimeInterval elapsedTime = [currentTime compare:[self startingTime]];
    
    [currentTime release];
    return (NSUInteger)[NSNumber numberWithDouble:elapsedTime]; // TODO: is the casting shitty?
}

- (double)elapsedHours {
    NSDate *currentTime = [NSDate date];
    NSTimeInterval elapsedTime = [currentTime compare:[self startingTime]];

    [currentTime release];
    return elapsedTime / 3600.00;
}

- (NSString *)elapsedTimeDisplayString {
    return @"TODO";
}

- (NSNumber *)accruedCost {
    return [NSNumber numberWithDouble:([[self totalBillingRate] doubleValue] * [self elapsedHours])];
}

- (NSNumber *)totalBillingRate {
    double billingRate = 0.00;
    
    for (DIZPerson *person in [self personsPresent]) {
        billingRate += [[person hourlyRate] doubleValue];
    }
    
    return [NSNumber numberWithDouble:billingRate];
}

- (void)dealloc {
    [_startingTime release];
    _startingTime = nil;
    
    [_endingTime release];
    _endingTime = nil;
    
    [_personsPresent release];
    _personsPresent = nil;
    
    [super dealloc];
}

- (id)init {
    if (self = [super init]) {
        _personsPresent = [[NSMutableArray alloc] init];
    }
    
    return self;
}

+ (DIZMeeting *)meetingWithCaptains {
    DIZMeeting *meeting = [[DIZMeeting alloc] init];

    NSArray *captains = @[
        [[DIZPerson alloc] initWithName: @"Sean Archer" hourlyRate: 0.01],
        [[DIZPerson alloc] initWithName: @"Katherine Janeway" hourlyRate: 20.00],
        [[DIZPerson alloc] initWithName: @"Benjamin Sisko" hourlyRate: 40.00],
        [[DIZPerson alloc] initWithName: @"Jean-Luc Picard" hourlyRate: 100.00],
        [[DIZPerson alloc] initWithName: @"James T Kirk" hourlyRate: 200.00]
    ];

    for (DIZPerson *captain in captains) {
        [meeting addToPersonsPresent:captain];
        [captain release];
    }

    [meeting autorelease];
    return meeting;
}

+ (DIZMeeting *)meetingWithMarxBrothers {
    DIZMeeting *meeting = [[DIZMeeting alloc] init];
    
    NSArray *brothers = @[
        [[DIZPerson alloc] initWithName: @"Larry Marx" hourlyRate: 0.01],
        [[DIZPerson alloc] initWithName: @"Al Marx" hourlyRate: 20.00],
        [[DIZPerson alloc] initWithName: @"Joe Marx" hourlyRate: 40.00]
    ];
    
    for (DIZPerson *brother in brothers) {
        [meeting addToPersonsPresent:brother];
        [brother release];
    }
    
    [meeting autorelease];
    return meeting;
}

+ (DIZMeeting *)meetingWithStooges {
    DIZMeeting *meeting = [[DIZMeeting alloc] init];
    
    NSArray *stooges = @[
        [[DIZPerson alloc] initWithName: @"Larry" hourlyRate: 1.50],
        [[DIZPerson alloc] initWithName: @"Curly" hourlyRate: 1.00],
        [[DIZPerson alloc] initWithName: @"Moe" hourlyRate: 20.00]
    ];
    
    for (DIZPerson *stooge in stooges) {
        [meeting addToPersonsPresent:stooge];
        [stooge release];
    }
    [meeting autorelease];
    return meeting;
}

@end