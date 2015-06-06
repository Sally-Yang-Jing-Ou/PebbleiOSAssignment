//
//  MainTabBarController.h
//  PebbleiOSChallenge
//
//  Created by Sally Yang Jing Ou on 2015-06-03.
//  Copyright (c) 2015 Sally Yang Jing Ou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ColorReceiver.h"
#import "CommandHistoryViewController.h"
#import "ColorReporterViewController.h"

extern NSString * const NewCommandNotification;

@interface MainTabBarController : UITabBarController <ColorReceiverDelegate, CommandHistoryDelegate, ColorReporterDelegate>

@property (readonly, nonatomic) NSMutableArray* commandHistory;
@property (readonly, nonatomic) NSMutableSet* selectedCommands;

@end
