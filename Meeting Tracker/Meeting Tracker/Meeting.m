//
//  DIZMeeting.m
//  Meeting Tracker
//
//  Created by Quinton Harris on 2013.10.14.
//  Copyright (c) 2013 Quinton Harris. All rights reserved.
//

#import "Meeting.h"
#import "Person.h"

@implementation Meeting

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

- (NSString *)description {
    return [NSString stringWithFormat:@"<Meeting %lu participants %@/hour>", [self countOfPersonsPresent], [self totalBillingRate]];
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
    // [thePerson retain];
    [[self personsPresent] addObject:thePerson];
}

- (void)removeFromPersonsPresent:(id)thePerson {
    [[self personsPresent] removeObject:thePerson];
    // [thePerson release];
}

- (void)removeObjectFromPersonsPresentAtIndex:(NSUInteger)index {
    // Person *person = [[self personsPresent] objectAtIndex:index];
    [[self personsPresent] removeObjectAtIndex:index];
    // [person release];
}

- (void)insertObject:(id)theObject inPersonsPresentAtIndex:(NSUInteger)index {
    [theObject retain];
    [[self personsPresent] insertObject:theObject atIndex:index];
}

- (NSUInteger)countOfPersonsPresent {
    return [[self personsPresent] count];
}

- (NSUInteger)elapsedSeconds {
    return (NSUInteger)[[self endingTime] timeIntervalSinceDate:[self startingTime]];
}

- (double)elapsedHours {
    return (double)[self elapsedSeconds] / 3600.00;
}

- (NSString *)elapsedTimeDisplayString {
    NSUInteger elapsedSeconds = [self elapsedSeconds];
    return [NSString stringWithFormat:@"%02ld:%02ld:%02ld",
            elapsedSeconds / 3600,
            (elapsedSeconds / 60) % 60,
            elapsedSeconds % 60
    ];
}

- (NSNumber *)accruedCost {
    return [NSNumber numberWithDouble:([[self totalBillingRate] doubleValue] * [self elapsedHours])];
}

- (NSNumber *)totalBillingRate {
    double billingRate = 0.00;
    
    for (Person *person in [self personsPresent]) {
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

+ (Meeting *)meetingWithCaptains {
    Meeting *meeting = [[Meeting alloc] init];

    NSArray *captains = @[
        [Person personWithName:@"Sean Archer" hourlyRate:@0.01],
        [Person personWithName: @"Katherine Janeway" hourlyRate: @20.00],
        [Person personWithName: @"Benjamin Sisko" hourlyRate: @40.00],
        [Person personWithName: @"Jean-Luc Picard" hourlyRate: @100.00],
        [Person personWithName: @"James T Kirk" hourlyRate: @200.00]
    ];

    for (Person *captain in captains) {
        [meeting addToPersonsPresent:captain];
    }

    [meeting autorelease];
    return meeting;
}

+ (Meeting *)meetingWithMarxBrothers {
    Meeting *meeting = [[Meeting alloc] init];
    
    NSArray *brothers = @[
        [Person personWithName: @"Larry Marx" hourlyRate: @0.01],
        [Person personWithName: @"Al Marx" hourlyRate: @20.00],
        [Person personWithName: @"Joe Marx" hourlyRate: @40.00]
    ];
    
    for (Person *brother in brothers) {
        [meeting addToPersonsPresent:brother];
    }
    
    [meeting autorelease];
    return meeting;
}

+ (Meeting *)meetingWithStooges {
    Meeting *meeting = [[Meeting alloc] init];
    
    NSArray *stooges = @[
        [Person personWithName: @"Larry" hourlyRate: @1.50],
        [Person personWithName: @"Curly" hourlyRate: @1.00],
        [Person personWithName: @"Moe" hourlyRate: @20.00]
    ];
    
    for (Person *stooge in stooges) {
        [meeting addToPersonsPresent:stooge];
    }
    
    [meeting autorelease];
    return meeting;
}

@end