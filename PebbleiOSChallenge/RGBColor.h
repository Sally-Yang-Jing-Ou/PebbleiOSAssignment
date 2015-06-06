//
//  RGBColor.h
//  PebbleiOSChallenge
//
//  Created by Sally Yang Jing Ou on 2015-06-03.
//  Copyright (c) 2015 Sally Yang Jing Ou. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef uint8_t* CommandData;

typedef NS_ENUM(NSInteger, CommandType) {
    CommandTypeRelative,
    CommandTypeAbsolute
};

@interface RGBColor : NSObject

@property (readonly, nonatomic) NSInteger red;
@property (readonly, nonatomic) NSInteger green;
@property (readonly, nonatomic) NSInteger blue;
@property (readonly, nonatomic) CommandType commandType;

- (id)initWithData:(CommandData)buffer;

- (id)initWithCommandType:(CommandType)commandType red:(NSInteger)red green:(NSInteger)green blue:(NSInteger)blue;

@end
