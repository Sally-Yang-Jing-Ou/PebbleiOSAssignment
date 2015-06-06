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

@property (nonatomic, strong) ColorReceiver* colorReceiver;
@property (nonatomic, strong) RGBColor* baseColor;

@property (readwrite, nonatomic, strong) NSMutableArray* commandHistory;
@property (readwrite, nonatomic, strong) NSMutableSet* selectedCommands;

@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    _commandHistory = [NSMutableArray array];
    _selectedCommands = [NSMutableSet set];

    _colorReceiver = [[ColorReceiver alloc] init];
    _colorReceiver.delegate = self;
    [_colorReceiver startConnection];
    
    self.commandHistoryViewController.delegate = self;
    self.colorReporterViewController.delegate = self;
    
    RGBColor* initialColor = [[RGBColor alloc] initWithCommandType:CommandTypeAbsolute red:127 green:127 blue:127];
    _baseColor = initialColor;
    [_commandHistory addObject:_baseColor];
}

#pragma mark - ColorReceiverDelegate

- (void)colorReceiver:(ColorReceiver *)colorReceiver didReceiveRGBColor:(RGBColor *)rgbColor {
    [self.commandHistory insertObject:rgbColor atIndex:0];
    
    if (rgbColor.commandType == CommandTypeRelative) {
        [self.selectedCommands addObject:rgbColor];
    } else {
        [self.selectedCommands removeAllObjects];
        self.baseColor = rgbColor;
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:NewCommandNotification object:nil];
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
