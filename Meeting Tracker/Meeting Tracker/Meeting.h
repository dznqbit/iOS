//
//  DIZMeeting.h
//  Meeting Tracker
//
//  Created by Quinton Harris on 2013.10.14.
//  Copyright (c) 2013 Quinton Harris. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Meeting : NSObject
{
    NSDate *_startingTime;
    NSDate *_endingTime;
    
    NSMutableArray *_personsPresent;
}

- (NSString *)description;

- (NSDate *)startingTime;
- (void)setStartingTime:(NSDate *)theStartingTime;
- (NSDate *)endingTime;
- (void)setEndingTime:(NSDate *)theEndingTime;

- (NSMutableArray *)personsPresent;
- (void)setPersonsPresent:(NSMutableArray *)thePersonsPresent;
- (void)addToPersonsPresent:(id)thePerson;
- (void)removeFromPersonsPresent:(id)thePerson;

- (void)removeObjectFromPersonsPresentAtIndex:(NSUInteger)index;
- (void)insertObject:(id)theObject inPersonsPresentAtIndex:(NSUInteger)index;

- (NSUInteger)countOfPersonsPresent;
- (NSUInteger)elapsedSeconds;
- (double)elapsedHours;
- (NSString *)elapsedTimeDisplayString;

- (NSNumber *)accruedCost;
- (NSNumber *)totalBillingRate;

+ (Meeting *)meetingWithStooges;
+ (Meeting *)meetingWithCaptains;
+ (Meeting *)meetingWithMarxBrothers;

@end
