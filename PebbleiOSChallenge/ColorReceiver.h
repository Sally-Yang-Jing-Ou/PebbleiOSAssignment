//
//  ColorReceiver.h
//  PebbleiOSChallenge
//
//  Created by Sally Yang Jing Ou on 2015-06-03.
//  Copyright (c) 2015 Sally Yang Jing Ou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RGBColor.h"

@class ColorReceiver;
@protocol ColorReceiverDelegate <NSObject>

- (void)colorReceiver:(ColorReceiver *)colorReceiver didReceiveRGBColor:(RGBColor *)rgbColor;

@end

@interface ColorReceiver : NSObject <NSStreamDelegate>

@property (weak, nonatomic) id<ColorReceiverDelegate> delegate;

- (void)startConnection;

- (void)closeConnection;

@end
