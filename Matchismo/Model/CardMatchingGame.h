//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Lmz on 2017/2/9.
//  Copyright © 2017年 CS193p. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"
#import "Card.h"

@interface CardMatchingGame : NSObject

@property (assign, nonatomic, readonly) NSInteger score;
@property (strong, nonatomic) NSArray *chosingCards;    // of Card
@property (assign, nonatomic) int scoreChange;
@property (assign, nonatomic) int chooseTimes;

// 使用该方法初始化游戏
- (instancetype)initWithCardCount:(NSUInteger)count
                        usingDeck:(Deck *)deck;
- (void)chooseCardAtIndex:(NSUInteger)index cardCount:(int)cardCount;    // 游戏的入口，玩家选牌时执行该方法
- (Card *)cardAtIndex:(NSUInteger)index;    // 返回目标牌

@end
