//
//  CommandHistoryViewController.h
//  PebbleiOSChallenge
//
//  Created by Sally Yang Jing Ou on 2015-06-03.
//  Copyright (c) 2015 Sally Yang Jing Ou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RGBColor.h"

@protocol CommandHistoryDelegate

- (void)commandHistoryDidToggleRGBColorAtIndex:(NSUInteger)index;
- (BOOL)isColorSelectedInCommandHistoryAtIndex:(NSUInteger)index;
- (NSInteger)numberOfCommandsInCommandHistory;
- (RGBColor*)rgbColorAtIndexInCommandHistory:(NSUInteger)index;

@end

@interface CommandHistoryViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) id<CommandHistoryDelegate> delegate;

- (void)updateData;

@end

