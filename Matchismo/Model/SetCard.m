//
//  SetCard.m
//  Matchismo
//
//  Created by Lmz on 2017/2/14.
//  Copyright © 2017年 CS193p. All rights reserved.
//

#import "SetCard.h"

@implementation SetCard

#pragma mark - Match cards

- (int)match:(NSArray *)otherCards {
  int score = 0;
  
  int setCount = 0 ;
  if (otherCards.count != 2) {    // 当传入两张牌时才具备判断set的条件,是set返回正数，不是返回负数，不能判断返回0
    return score;
  } else {
    if ([otherCards[0] isKindOfClass:[self class]] &&
        [otherCards[1] isKindOfClass:[self class]]) {   // 验证数组内对象类型
      
      // 对四个属性行进比较,每一个属性满足set的条件，isSetCount +1
      [self isNumberSet:&setCount withArray:otherCards];
      [self isSymbolSet:&setCount withArray:otherCards];
      [self isShadingSet:&setCount withArray:otherCards];
      [self isColorSet:&setCount withArray:otherCards];
      
      if (setCount == 4) {
        score = 40;
      } else {
        score = -1;
      }
    }
  }
  
  return score;
}



- (void)isSymbolSet:(int *)setCount withArray:(NSArray *)otherCards {
  SetCard *card1 = nil;
  SetCard *card2 = nil;
  if ([otherCards.firstObject isKindOfClass:[SetCard class]]) {
    card1 = (SetCard *)otherCards.firstObject;
  }
  if ([otherCards.lastObject isKindOfClass:[SetCard class]]) {
    card2 = (SetCard *)otherCards.lastObject;
  }
  if (card1 && card2) {
    if ((self.symbol == card1.symbol) &&
        (self.symbol == card2.symbol)) {
      *setCount = *setCount + 1;
    } else if (!(self.symbol == card1.symbol) &&
               !(self.symbol == card2.symbol) &&
               !(card1.symbol == card2.symbol)) {
      *setCount = *setCount + 1;
    }
  }
}

- (void)isIntSet:(int *)setCount withArray:(NSArray *)integers {
  int ints[3];
  for (int i = 0; i< integers.count; i++) {
    ints[i] = [integers[i] intValue];
  }
  if (ints[0] == ints[1] &&
      ints[0] == ints[2]) {
    *setCount = *setCount + 1;
  } else if (ints[0] != ints[1] &&
             ints[0] != ints[2] &&
             ints[1] != ints[2]) {
    *setCount = *setCount + 1;
  }
}

- (void)isNumberSet:(int *)setCount withArray:(NSArray *)otherCards {
  
  [self isIntSet:setCount withArray:@[@(self.number),
                                      @([(SetCard *)otherCards[0] number]),
                                      @([(SetCard *)otherCards[1] number])]];
}

- (void)isShadingSet:(int *)setCount withArray:(NSArray *)otherCards {
  
  [self isIntSet:setCount withArray:@[@(self.shading),
                                      @([(SetCard *)otherCards[0] shading]),
                                      @([(SetCard *)otherCards[1] shading])]];
}

- (void)isColorSet:(int *)setCount withArray:(NSArray *)otherCards {
  
  [self isIntSet:setCount withArray:@[@(self.color),
                                      @([(SetCard *)otherCards[0] color]),
                                      @([(SetCard *)otherCards[1] color])]];
}


#pragma mark - getters & setters

const NSUInteger MAX_NUMBER = 3;
- (void)setNumber:(int)number {
  if (number <= MAX_NUMBER) {
    _number = number;
  }
}

const int MAX_SYMBOL_VALUE = 3;
- (void)setSymbol:(SetCardPatternSymbol)symbol {
  if ((symbol > 0) && (symbol <= MAX_SYMBOL_VALUE)) {
    _symbol = symbol;
  }
}

const int MAX_SHADING_VALUE = 2;
- (void)setShading:(SetCardPatternShading)shading {
  if (shading <= MAX_SHADING_VALUE) {
    _shading = shading;
  }
}

- (void)setColor:(SetCardPatternColor)color {
  if (color <= [SetCard maxColorEnum]) {
    _color = color;
  }
}


#pragma mark - Tool methods


+ (int)maxColorEnum {
  return 10;
}

@end

