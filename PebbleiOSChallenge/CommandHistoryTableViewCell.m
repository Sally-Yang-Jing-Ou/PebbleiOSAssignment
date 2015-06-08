//
//  CommandHistoryTableViewCell.m
//  PebbleiOSChallenge
//
//  Created by Sally Yang Jing Ou on 2015-06-03.
//  Copyright (c) 2015 Sally Yang Jing Ou. All rights reserved.
//

#import "CommandHistoryTableViewCell.h"

@implementation CommandHistoryTableViewCell

- (void)setCommandSelected:(BOOL)commandSelected { //select all relative(or manual) commands (with blue color)
    _commandSelected = commandSelected;
    if (commandSelected) {
        self.contentView.backgroundColor = [UIColor colorWithRed:0.6 green:0.7 blue:1.0 alpha:1];
    } else {
        self.contentView.backgroundColor = [UIColor clearColor]; //otherwise, cell color is clear
    }
}

- (void)setRGBColor:(RGBColor *)rgbColor { //display RGB colors (text) in cells from each commmand
    NSString* command = rgbColor.commandType == CommandTypeRelative ? @"Relative" : @"Absolute"; //determine the type of command
    self.textLabel.text = [NSString stringWithFormat:@"%@ - (R: %ld, G: %ld, B: %ld)", command, rgbColor.red, rgbColor.green, rgbColor.blue];
}

@end
