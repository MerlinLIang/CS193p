//
//  SetCardDeck.m
//  Matchismo
//
//  Created by Lmz on 2017/2/15.
//  Copyright © 2017年 CS193p. All rights reserved.
//

#import "SetCardDeck.h"
#import "SetCard.h"

@implementation SetCardDeck

// designed initializer
- (instancetype)initWithSymbols:(NSArray *)symbols andColors:(NSArray *)colors {
    self = [super init];
    if (self) {
        if (symbols.count == 3 && colors.count == 3) {  //  判断初始化参数数量是否合法
            NSSet *validSymbolSet = [NSSet setWithArray:[SetCard validSymbols]];
            NSSet *symbolSet = [NSSet setWithArray:symbols];
            if ([symbolSet isSubsetOfSet:validSymbolSet]) { // 判断牌面是否合法
                for (int i = 0; i < colors.count; i++) {    // 判断颜色是否合法
                    if ([colors[i] intValue] > [SetCard maxColorEnum]) {
                        return nil;
                    }
                }
                
                // 创造卡组
                for (int num = 1; num<=3; num++) {    // number
                    for (NSString *symbol in symbols) { //symbol
                        for (int shad = 0; shad < 3; shad++) {   // shading
                            for (NSNumber *color in colors) {   //color
                                SetCard *card = [[SetCard alloc] init];
                                card.number = num;
                                card.symbol = symbol;
                                card.shading = shad;
                                card.color = [color intValue];
                                [self addCard:card];
                            }
                        }
                    }
                }
                // 创建完毕
                
            }
        }
    }
    return self;
}

@end
