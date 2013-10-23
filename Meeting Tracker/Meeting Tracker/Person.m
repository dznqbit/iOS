//
//  DIZPerson.m
//  Meeting Tracker
//
//  Created by Quinton Harris on 2013.10.14.
//  Copyright (c) 2013 Quinton Harris. All rights reserved.
//

#import "Person.h"

@implementation Person

// Set / Get

- (NSString *)name { return _name; }
- (void)setName:(NSString *)theName {
    if (theName != _name) {
        [_name release];
        _name = [NSString stringWithString:theName];
        [_name retain];
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

- (NSString *)description {
    return [NSString stringWithFormat:@"<Person %@ %.2f/hour>", [self name], [[self hourlyRate] doubleValue]];
}

- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:[self name] forKey:@"name"];
    [coder encodeDouble:[[self hourlyRate] doubleValue] forKey:@"hourlyRate"];
}

- (void)dealloc {
    [_name release];
    _name = nil;
    
    [_hourlyRate release];
    _hourlyRate = nil;
    
    [super dealloc];
}

// Init stuff

+ (Person *)personWithName:(NSString *)theName hourlyRate:(NSNumber *)theRate {
    Person *person = [[Person alloc] initWithName:theName hourlyRate:theRate];
    [person autorelease];
    return person;
}

- (id)init {
    if (self = [super init]) {
        _name = [@"Joe" retain];
        _hourlyRate = [@50.00 retain];
    }
    
    return self;
}

- (id)initWithCoder:(NSCoder *)coder {
    if (self = [super init]) {
        _name       = [[coder decodeObjectForKey:@"name"] retain];
        _hourlyRate = [[NSNumber numberWithDouble:[coder decodeDoubleForKey:@"hourlyRate"]] retain];
    }
    
    return self;
}
- (id)initWithName:(NSString *)theName hourlyRate:(NSNumber *)theRate {
    if (self = [super init]) {
        _name = [theName retain];
        _hourlyRate = [theRate retain];
    }
    
    return self;
}

@end
