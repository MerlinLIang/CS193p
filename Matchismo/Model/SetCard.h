//
//  SetCard.h
//  Matchismo
//
//  Created by Lmz on 2017/2/14.
//  Copyright © 2017年 CS193p. All rights reserved.
//

#import "Card.h"

typedef enum{
    SetCardPatternShadingSolid,
    SetCardPatternShadingStriped,
    SetCardPatternShadingOpen
}SetCardPatternShading;

typedef enum {
    SetCardPatternColorRed,
    SetCardPatternColorYellow,
    SetCardPatternColorBlue,
    SetCardPatternColorGreen,
    SetCardPatternColorOrange,
    SetCardPatternColorPurple,
    SetCardPatternColorGrey,
    SetCardPatternColorWhite,
    SetCardPatternColorBlack,
    SetCardPatternColorbrown,
    SetCardPatternColorsyan
}SetCardPatternColor;

@interface SetCard : Card

@property (assign, nonatomic) int number;
@property (copy, nonatomic) NSString *symbol;
@property (assign, nonatomic) SetCardPatternShading shading;
@property (assign, nonatomic) SetCardPatternColor color;

+ (NSArray *)validSymbols;
+ (int)maxColorEnum;
@end
