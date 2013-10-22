//
//  DIZPerson.h
//  Meeting Tracker
//
//  Created by Quinton Harris on 2013.10.14.
//  Copyright (c) 2013 Quinton Harris. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject
{
    NSString *_name;
    NSNumber *_hourlyRate;
}

- (NSString *)name;
- (void)setName:(NSString *)theName;
- (NSString *)description;
- (NSNumber *)hourlyRate;
- (void)setHourlyRate:(NSNumber *)theRate;

+ (Person *)personWithName:(NSString *)theName
    hourlyRate:(NSNumber *)theRate;

- (id)initWithName:(NSString *)theName hourlyRate:(NSNumber *)theRate;

@end