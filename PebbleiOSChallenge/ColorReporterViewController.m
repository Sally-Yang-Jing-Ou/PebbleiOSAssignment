//
//  ColorReporterViewController.m
//  PebbleiOSChallenge
//
//  Created by Sally Yang Jing Ou on 2015-06-03.
//  Copyright (c) 2015 Sally Yang Jing Ou. All rights reserved.
//

#import "ColorReporterViewController.h"
#import "MainTabBarController.h"

@interface ColorReporterViewController ()

@property (weak, nonatomic) IBOutlet UIView *colorReporterContainer;
@property (weak, nonatomic) IBOutlet UILabel *colorReporterLabel;

@end

@implementation ColorReporterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.colorReporterContainer.layer.cornerRadius = 8.0f;
    [self updateColorLabel];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateColorLabel) name:NewCommandNotification object:nil];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)updateColorLabel {
    NSSet* relativeColors = [self.delegate relativeColorsForColorReporter];
    RGBColor* baseColor = [self.delegate absoluteColorForColorReporter];
    
    NSInteger red = [[relativeColors valueForKeyPath:@"@sum.red"] integerValue];
    NSInteger green = [[relativeColors valueForKeyPath:@"@sum.green"] integerValue];
    NSInteger blue = [[relativeColors valueForKeyPath:@"@sum.blue"] integerValue];
    
    red = MAX(MIN(red + baseColor.red, 255), 0);
    green = MAX(MIN(green + baseColor.green, 255), 0);
    blue = MAX(MIN(blue + baseColor.blue, 255), 0);
    
    self.view.backgroundColor = [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:1];
    self.colorReporterLabel.text = [NSString stringWithFormat:@"R: %ld, G: %ld, B: %ld", red, green, blue];
}

@end
