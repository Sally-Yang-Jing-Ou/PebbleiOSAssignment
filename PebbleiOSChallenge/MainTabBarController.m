//
//  MainTabBarController.m
//  PebbleiOSChallenge
//
//  Created by Sally Yang Jing Ou on 2015-06-03.
//  Copyright (c) 2015 Sally Yang Jing Ou. All rights reserved.
//

#import "MainTabBarController.h"

@interface MainTabBarController () {
    ColorReceiver* _colorReceiver;
    RGBColor* _baseColor;
}

@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    _commandHistory = [NSMutableArray array];
    _selectedCommands = [NSMutableSet set];

    _colorReceiver = [[ColorReceiver alloc] init];
    _colorReceiver.delegate = self;
    [_colorReceiver startConnection];
    
    CommandHistoryViewController* commandHistoryViewController = self.viewControllers[0];
    commandHistoryViewController.delegate = self;
    
    ColorReporterViewController* colorReporterViewController = self.viewControllers[1];
    colorReporterViewController.delegate = self;
    
    RGBColor* initialColor = [[RGBColor alloc] initWithCommandType:CommandTypeAbsolute red:127 green:127 blue:127];
    _baseColor = initialColor;
    [_commandHistory addObject:_baseColor];
}

#pragma mark - ColorReceiverDelegate

- (void)colorReceiver:(ColorReceiver *)colorReceiver didReceiveRGBColor:(RGBColor *)rgbColor {
    [_commandHistory insertObject:rgbColor atIndex:0];
    
    if (rgbColor.commandType == CommandTypeRelative) {
        [_selectedCommands addObject:rgbColor];
    } else {
        [_selectedCommands removeAllObjects];
        _baseColor = rgbColor;
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:UPDATE_COMMAND_NOTIFICATION object:nil];
}

#pragma mark - CommandHistoryDelegate

- (NSInteger)numberOfCommandsInCommandHistory {
    return _commandHistory.count;
}

- (BOOL)isColorSelectedInCommandHistoryAtIndex:(NSUInteger)index {
    return [_selectedCommands containsObject:_commandHistory[index]];
}

- (RGBColor*)rgbColorAtIndexInCommandHistory:(NSUInteger)index {
    return _commandHistory[index];
}

- (void)commandHistoryDidToggleRGBColorAtIndex:(NSUInteger)index {
    RGBColor* color = _commandHistory[index];
    if (color.commandType == CommandTypeRelative) {
        if ([_selectedCommands containsObject:color]) {
            [_selectedCommands removeObject:color];
        } else {
            [_selectedCommands addObject:color];
        }
    } else {
        [_selectedCommands removeAllObjects];
        _baseColor = color;
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:UPDATE_COMMAND_NOTIFICATION object:nil];
}

#pragma mark - ColorReporterDelegate

- (NSSet*)relativeColorsForColorReporter {
    return _selectedCommands;
}

- (RGBColor*)absoluteColorForColorReporter {
    return _baseColor;
}

@end
