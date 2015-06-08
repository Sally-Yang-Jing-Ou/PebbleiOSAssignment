//
//  CommandHistoryTableViewCell.h
//  PebbleiOSChallenge
//
//  Created by Sally Yang Jing Ou on 2015-06-03.
//  Copyright (c) 2015 Sally Yang Jing Ou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RGBColor.h"

@interface CommandHistoryTableViewCell : UITableViewCell

@property (nonatomic, getter=isCommandSelected) BOOL commandSelected; //for selected cells (commands)
- (void)setRGBColor:(RGBColor *)rgbColor;                             //RGB colors(text) from each command

@end
