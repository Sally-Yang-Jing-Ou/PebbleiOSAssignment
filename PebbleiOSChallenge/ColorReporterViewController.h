//
//  SecondViewController.h
//  PebbleiOSChallenge
//
//  Created by Sally Yang Jing Ou on 2015-06-03.
//  Copyright (c) 2015 Sally Yang Jing Ou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RGBColor.h"

@protocol ColorReporterDelegate

- (NSSet*)relativeColorsForColorReporter;
- (RGBColor*)absoluteColorForColorReporter;

@end


@interface ColorReporterViewController : UIViewController

@property (nonatomic, weak) id<ColorReporterDelegate> delegate;

@end

