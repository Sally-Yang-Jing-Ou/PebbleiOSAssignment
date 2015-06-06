//
//  CommandTableViewCell.m
//  PebbleiOSChallenge
//
//  Created by Sally Yang Jing Ou on 2015-06-03.
//  Copyright (c) 2015 Sally Yang Jing Ou. All rights reserved.
//

#import "CommandHistoryTableViewCell.h"

@implementation CommandHistoryTableViewCell

- (void)setCommandSelected:(BOOL)commandSelected {
    _commandSelected = commandSelected;
    if (commandSelected) {
        self.contentView.backgroundColor = [UIColor colorWithRed:0.6 green:0.7 blue:1.0 alpha:1];
    } else {
        self.contentView.backgroundColor = [UIColor clearColor];
    }
}

- (void)setRGBColor:(RGBColor *)rgbColor {
    NSString* command = rgbColor.commandType == CommandTypeRelative ? @"Relative" : @"Absolute";
    self.textLabel.text = [NSString stringWithFormat:@"%@ - (R: %ld, G: %ld, B: %ld)", command, rgbColor.red, rgbColor.green, rgbColor.blue];
}

@end
