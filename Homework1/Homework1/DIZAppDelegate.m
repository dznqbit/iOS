//
//  DIZAppDelegate.m
//  Homework1
//
//  Created by Quinton Harris on 2013.10.08.
//  Copyright (c) 2013 Quinton Harris. All rights reserved.
//

#import "DIZAppDelegate.h"

@implementation DIZAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    [self updateSeasonsLabel:@"December"];
    [self updateNowLabel];
    [self updateSquareValue: [[self squareSlider] doubleValue]];
    [self zeroOneTwoCycleColor];
}

// Top Label

- (IBAction)topLabelHelloClick:(id)sender {
    [[self topLabel] setTitle:@"Hello"];
}

- (IBAction)topLabelGoodbyeClick:(id)sender {
    [[self topLabel] setTitle:@"Goodbye"];
}

- (IBAction)topLabelCopyClick:(id)sender {
    [
     [self topLabel]
     setTitle:[[self topLabelTextInput] stringValue]
     ];
}

// 0-1-2

- (IBAction)zeroOneTwoClick:(id)sender {
    NSInteger selectedIndex = [[self zeroOneTwoOutlet] selectedSegment];
    
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setNumberStyle:NSNumberFormatterSpellOutStyle];
    [numberFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en"]];
    NSString *numberString = [[numberFormatter stringFromNumber:[NSNumber numberWithInt:(int)selectedIndex]] capitalizedString];
    
    NSString *labelString = [NSString stringWithFormat:@"%d: %@", (int)selectedIndex, numberString];
    [[self zeroOneTwoLabel] setTitle:labelString];
    
    // [numberFormatter release]; ARC prevents this
}

- (void)zeroOneTwoCycleColor {
    NSTimeInterval timeInMilliseconds = [[NSDate date] timeIntervalSince1970];

    float   redColor = sin(timeInMilliseconds) / 2.5 + 0.4,
            greenColor = sin(timeInMilliseconds * 6) / 2.5 + 0.4,
            blueColor = sin(timeInMilliseconds * 7) / 2.5 + 0.4;
    
    [[self zeroOneTwoLabel] setTextColor:[NSColor colorWithCalibratedRed:redColor
                                                                   green:greenColor
                                                                    blue:blueColor
                                                                   alpha:1]
    ];
    
    [self performSelector:@selector(zeroOneTwoCycleColor) withObject:self afterDelay:0.002];
}

// Seasons

- (IBAction)winterClick:(id)sender { [self updateSeasonsLabel:@"December"]; }
- (IBAction)springClick:(id)sender { [self updateSeasonsLabel:@"March"]; }
- (IBAction)summerClick:(id)sender { [self updateSeasonsLabel:@"June"]; }
- (IBAction)fallClick:(id)sender   { [self updateSeasonsLabel:@"September"]; }
- (void)updateSeasonsLabel:(NSString *)seasonStart { [[self seasonsLabel] setTitle:seasonStart]; }

// Now Button

- (IBAction)nowButtonClick:(id)sender {  [self updateNowLabel]; }
- (void)updateNowLabel {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd/MM/yyyy, HH:mm:ss a"];
    [[self nowLabel] setTitle:[dateFormatter stringFromDate:[NSDate date]]];
}

// Square

- (IBAction)squareSliderUpdate:(id)sender { [self updateSquareValue: [[self squareSlider] doubleValue]]; }
- (void)updateSquareValue:(double)doubleValue {
    [[self squareValueLabel] setTitle:[NSString stringWithFormat:@"%.2f", doubleValue]];
    
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setNumberStyle:NSNumberFormatterSpellOutStyle];
    [numberFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en"]];
    [[self squareSquareLabel] setTitle:[numberFormatter stringFromNumber:[NSNumber numberWithDouble:(doubleValue * doubleValue)]]];
}

// Voice

- (IBAction)speechVoiceChoiceClick:(id)sender {
    NSString *voiceName = [[self speechVoiceChoiceOutlet] labelForSegment:[[self speechVoiceChoiceOutlet] selectedSegment]];
    
    BOOL continueSpeaking = [[self speechSynthesizer] isSpeaking];
    [[self speechSynthesizer] pauseSpeakingAtBoundary:NSSpeechWordBoundary];
    
    while ([[self speechSynthesizer] isSpeaking]) {
        [NSThread sleepForTimeInterval:0.1];
    }
    
    [[self speechSynthesizer] setVoice:[NSString stringWithFormat: @"com.apple.speech.synthesis.voice.%@", voiceName]];

    // speed gets reset, so set it again.
    [[self speechSynthesizer] setRate:[[self speechVoiceSpeedOutlet] floatValue]];
    
    if (continueSpeaking) {
        // Ehh... the position seems to get reset here. Bummer.
        [[self speechSynthesizer] startSpeakingString:[[self speechScriptOutlet] stringValue]];
    }
}

- (IBAction)speechVoiceSpeedUpdate:(id)sender {
    BOOL continueSpeaking = [[self speechSynthesizer] isSpeaking];
    
    [[self speechSynthesizer] pauseSpeakingAtBoundary:NSSpeechWordBoundary];
    
    while ([[self speechSynthesizer] isSpeaking]) {
        [NSThread sleepForTimeInterval:0.1];
    }
    
    [[self speechSynthesizer] setRate:[[self speechVoiceSpeedOutlet] floatValue]];
    
    if (continueSpeaking) {
        [[self speechSynthesizer] continueSpeaking];
    }
}

- (IBAction)speechSpeakClick:(id)sender {
    [[self speechSynthesizer] startSpeakingString:[[self speechScriptOutlet] stringValue]];
}

- (IBAction)speechShushClick:(id)sender {
    [[self speechSynthesizer] stopSpeaking];
}

@end