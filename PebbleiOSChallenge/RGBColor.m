//
//  RGBColor.m
//  PebbleiOSChallenge
//
//  Created by Sally Yang Jing Ou on 2015-06-03.
//  Copyright (c) 2015 Sally Yang Jing Ou. All rights reserved.
//

#import "RGBColor.h"

@implementation RGBColor

- (id)initWithData:(CommandData)buffer {
    self = [super self];
    if (self) {
        if(buffer[0] == 1) {
            [self parseColorsFromRelativeCommand:buffer];
        } else {
            [self parseColorsFromAbsoluteCommand:buffer];
        }
    }
    return self;
}

- (id)initWithCommandType:(CommandType)commandType red:(NSInteger)red green:(NSInteger)green blue:(NSInteger)blue {
    self = [super self];
    if (self) {
        _commandType = commandType;
        _red = red;
        _green = green;
        _blue = blue;
    }
    return self;
}

- (void)parseColorsFromRelativeCommand:(CommandData)buffer {
    _commandType = CommandTypeRelative;
    _red = (int16_t)(((uint16_t)buffer[1] << 8) + (uint16_t)buffer[2]);
    _green = (int16_t)(((uint16_t)buffer[3] << 8) + (uint16_t)buffer[4]);
    _blue = (int16_t)(((uint16_t)buffer[5] << 8) + (uint16_t)buffer[6]);
}

- (void)parseColorsFromAbsoluteCommand:(CommandData)buffer {
    _commandType = CommandTypeAbsolute;
    _red = buffer[1];
    _green = buffer[2];
    _blue = buffer[3];
}

@end
