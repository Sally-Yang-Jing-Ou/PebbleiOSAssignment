//
//  MainTabBarController.m
//  PebbleiOSChallenge
//
//  Created by Sally Yang Jing Ou on 2015-06-03.
//  Copyright (c) 2015 Sally Yang Jing Ou. All rights reserved.
//

#import "MainTabBarController.h"

NSString * const NewCommandNotification = @"NewCommandNotification";

@interface MainTabBarController ()

@property (nonatomic, strong) ColorReceiver* colorReceiver; //color receiver client
@property (nonatomic, strong) RGBColor* baseColor;          //absolute color as base color from an absolute command

@property (readwrite, nonatomic, strong) NSMutableArray* commandHistory; //all commands from server
@property (readwrite, nonatomic, strong) NSMutableSet* selectedCommands; //all selected commands (relative and/or manual selected)

@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    _commandHistory = [NSMutableArray array];
    _selectedCommands = [NSMutableSet set];

    _colorReceiver = [[ColorReceiver alloc] init];      //initialize color receiver
    _colorReceiver.delegate = self;                     //color receiver delegate
    [_colorReceiver startConnection];                   //start to connect to server, open the stream
    
    self.commandHistoryViewController.delegate = self;  //first child view controller delegate
    self.colorReporterViewController.delegate = self;   //second child view controller delegate
    
    RGBColor* initialColor = [[RGBColor alloc] initWithCommandType:CommandTypeAbsolute red:127 green:127 blue:127]; //base color before everything
    _baseColor = initialColor;
    [_commandHistory addObject:_baseColor];             //add this initial color to command history
}

#pragma mark - ColorReceiverDelegate

- (void)colorReceiver:(ColorReceiver *)colorReceiver didReceiveRGBColor:(RGBColor *)rgbColor { //
    [self.commandHistory insertObject:rgbColor atIndex:0];
    
    if (rgbColor.commandType == CommandTypeRelative) {
        [self.selectedCommands addObject:rgbColor];
    } else {
        [self.selectedCommands removeAllObjects];
        self.baseColor = rgbColor;
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:NewCommandNotification object:nil]; //notify
}

#pragma mark - CommandHistoryDelegate

- (NSInteger)numberOfCommandsInCommandHistory {
    return self.commandHistory.count;
}

- (BOOL)isColorSelectedInCommandHistoryAtIndex:(NSUInteger)index {
    return [self.selectedCommands containsObject:self.commandHistory[index]];
}

- (RGBColor*)rgbColorAtIndexInCommandHistory:(NSUInteger)index {
    return self.commandHistory[index];
}

- (void)commandHistoryDidToggleRGBColorAtIndex:(NSUInteger)index {
    RGBColor* color = self.commandHistory[index];
    if (color.commandType == CommandTypeRelative) {
        if ([self.selectedCommands containsObject:color]) {
            [self.selectedCommands removeObject:color];
        } else {
            [self.selectedCommands addObject:color];
        }
    } else {
        [self.selectedCommands removeAllObjects];
        self.baseColor = color;
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:NewCommandNotification object:nil];
}

#pragma mark - ColorReporterDelegate

- (NSSet*)relativeColorsForColorReporter {
    return [self.selectedCommands copy];
}

- (RGBColor*)absoluteColorForColorReporter {
    return self.baseColor;
}

#pragma mark - Private Methods

- (CommandHistoryViewController *)commandHistoryViewController {
    if (self.viewControllers.count > 0) {
        return self.viewControllers[0];
    }
    
    return nil;
}

- (ColorReporterViewController *)colorReporterViewController {
    if (self.viewControllers.count > 1) {
        return self.viewControllers[1];
    }
    
    return nil;
}

@end
