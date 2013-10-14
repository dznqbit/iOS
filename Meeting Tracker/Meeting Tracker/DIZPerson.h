//
//  DIZPerson.h
//  Meeting Tracker
//
//  Created by Quinton Harris on 2013.10.14.
//  Copyright (c) 2013 Quinton Harris. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DIZPerson : NSObject
{
    NSString *_name;
    NSNumber *_hourlyRate;
}

- (NSString *)name;
- (void)setName:(NSString *)theName;
- (NSNumber *)hourlyRate;
- (void)setHourlyRate:(NSNumber *)theRate;

+ (DIZPerson *)personWithName:(NSString *)theName
    hourlyRate:(double)theRate;

- (id)initWithName:(NSString *)theName hourlyRate:(double)theRate;

@end
