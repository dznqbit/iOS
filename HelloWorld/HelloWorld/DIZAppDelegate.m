//
//  DIZAppDelegate.m
//  HelloWorld
//
//  Created by Quinton Harris on 2013.09.30.
//      . All rights reserved.
//

#import "DIZAppDelegate.h"

@implementation DIZAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
}

- (IBAction)sayHello:(id)sender {
    NSLog(@"hey sayHello");
    NSLog(@"%@ is my synth", self.speechSynthesizer);
    NSLog(@"%@", [NSDate date]);
    
    [[self speechSynthesizer] startSpeakingString:@"hello"];
}

@end