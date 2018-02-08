//
//  SetCard.h
//  Matchismo
//
//  Created by Lmz on 2017/2/14.
//  Copyright © 2017年 CS193p. All rights reserved.
//

#import "Card.h"
#import "SetCardConstant.h"

@interface SetCard : Card

@property (assign, nonatomic) int number;
@property (assign, nonatomic) SetCardPatternSymbol symbol;
@property (assign, nonatomic) SetCardPatternShading shading;
@property (assign, nonatomic) SetCardPatternColor color;

+ (int)maxColorEnum;
@end
