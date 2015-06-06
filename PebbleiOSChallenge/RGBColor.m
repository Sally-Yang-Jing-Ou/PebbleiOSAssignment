//
//  RGBColor.m
//  PebbleiOSChallenge
//
//  Created by Sally Yang Jing Ou on 2015-06-03.
//  Copyright (c) 2015 Sally Yang Jing Ou. All rights reserved.
//

#import "RGBColor.h"

@interface RGBColor ()

@property (readwrite, nonatomic) NSInteger red;
@property (readwrite, nonatomic) NSInteger green;
@property (readwrite, nonatomic) NSInteger blue;
@property (readwrite, nonatomic) CommandType commandType;

@end

@implementation RGBColor

- (instancetype)initWithData:(CommandData)buffer {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    if (buffer[0] == 1) {
        [self parseColorsFromRelativeCommand:buffer];
    } else {
        [self parseColorsFromAbsoluteCommand:buffer];
    }
    
    return self;
}

- (instancetype)initWithCommandType:(CommandType)commandType red:(NSInteger)red green:(NSInteger)green blue:(NSInteger)blue {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    _commandType = commandType;
    _red = red;
    _green = green;
    _blue = blue;

    return self;
}

- (void)parseColorsFromRelativeCommand:(CommandData)buffer {
    self.commandType = CommandTypeRelative;
    self.red = (int16_t)(((uint16_t)buffer[1] << 8) + (uint16_t)buffer[2]);
    self.green = (int16_t)(((uint16_t)buffer[3] << 8) + (uint16_t)buffer[4]);
    self.blue = (int16_t)(((uint16_t)buffer[5] << 8) + (uint16_t)buffer[6]);
}

- (void)parseColorsFromAbsoluteCommand:(CommandData)buffer {
    self.commandType = CommandTypeAbsolute;
    self.red = buffer[1];
    self.green = buffer[2];
    self.blue = buffer[3];
}

@end
