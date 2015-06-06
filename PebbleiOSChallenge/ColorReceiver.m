//
//  SocketClient.m
//  PebbleiOSChallenge
//
//  Created by Sally Yang Jing Ou on 2015-06-03.
//  Copyright (c) 2015 Sally Yang Jing Ou. All rights reserved.
//

#import "ColorReceiver.h"
#import "RGBColor.h"

@interface ColorReceiver()

@property (nonatomic, strong) NSInputStream *inputStream;

@end

@implementation ColorReceiver

- (instancetype)init
{
    self = [super init];
    if (!self) {
        return nil;
    }
    
    CFReadStreamRef readStream;
    CFStreamCreatePairWithSocketToHost(NULL, (CFStringRef)@"localhost", 1234, &readStream, NULL);
    
    _inputStream = (__bridge NSInputStream *)readStream;
    _inputStream.delegate = self;
    [_inputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    
    return self;
}

- (void)startConnection
{
    [self.inputStream open];
}

- (void)closeConnection
{
    [self.inputStream close];
}

- (void)stream:(NSStream *)aStream handleEvent:(NSStreamEvent)eventCode
{
    switch (eventCode) {
            
        case NSStreamEventOpenCompleted:
            NSLog(@"Stream opened");
            break;
            
        case NSStreamEventHasBytesAvailable:
            if (aStream == self.inputStream) {
                
                uint8_t buffer[8];
                NSInteger len;
                
                while ([self.inputStream hasBytesAvailable]) {
                    len = [self.inputStream read:buffer maxLength:sizeof(buffer)];
                    if (len > 0) {
                        RGBColor* rgbColor = [[RGBColor alloc] initWithData:buffer];
                        [self.delegate colorReceiver:self didReceiveRGBColor:rgbColor];
                    }
                }
            }
            break;
            
        case NSStreamEventErrorOccurred:
            NSLog(@"Can not connect to the host!");
            break;
            
        case NSStreamEventEndEncountered:
            break;
            
        default:
            NSLog(@"Unknown event");
    }
}

@end
