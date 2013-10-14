//
//  DIZPerson.m
//  Meeting Tracker
//
//  Created by Quinton Harris on 2013.10.14.
//  Copyright (c) 2013 Quinton Harris. All rights reserved.
//

#import "DIZPerson.h"

@implementation DIZPerson

// Set / Get

- (NSString *)name { return _name; }
- (void)setName:(NSString *)theName {
    if (theName != _name) {
        [_name release];
        [theName retain];
        _name = theName;
    }
}

- (NSNumber *)hourlyRate { return _hourlyRate; }
- (void)setHourlyRate:(NSNumber *)theRate {
    if (theRate != _hourlyRate) {
        [_hourlyRate release];
        [theRate retain];
        _hourlyRate = theRate;
    }
}

// Init stuff

+ (DIZPerson *)personWithName:(NSString *)theName hourlyRate:(double)theRate {
    DIZPerson *person = [[DIZPerson alloc] initWithName:theName hourlyRate:theRate];
    [person autorelease];
    return person;
}

- (id)initWithName:(NSString *)theName hourlyRate:(double)theRate {
    if (self = [super init]) {
        _name = [theName retain];
        _hourlyRate = [[NSNumber numberWithDouble:theRate] retain];
    }
    
    return self;
}

@end
