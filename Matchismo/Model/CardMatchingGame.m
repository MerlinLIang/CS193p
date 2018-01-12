//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Lmz on 2017/2/9.
//  Copyright © 2017年 CS193p. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()
@property (assign, nonatomic, readwrite) NSInteger score;
@property (strong, nonatomic) NSMutableArray *cards;   // of Card
@property (strong, nonatomic) NSMutableArray *cardsForMatch;    // of Card
@end

@implementation CardMatchingGame

- (int)chooseTimes {
  if (!_chooseTimes) {
    _chooseTimes = 0;
  }
  return _chooseTimes;
}

- (NSArray *)chosingCards {
  if (!_chosingCards) {
    _chosingCards = [[NSArray alloc] init];
  }
  return _chosingCards;
}

- (NSMutableArray *)cardsForMatch {
  if (!_cardsForMatch) {
    _cardsForMatch = [[NSMutableArray alloc] init];
  }
  return _cardsForMatch;
}

- (NSArray *)cards {
  if (!_cards) {
    _cards = [[NSMutableArray alloc] init];
  }
  return _cards;
}

- (instancetype)initWithCardCount:(NSUInteger)count
                        usingDeck:(Deck *)deck {
  self = [super init];
  if (self) {
    // 从牌堆内抽游戏用的牌，保存在cards内
    for (int i = 0; i < count; i++) {
      Card *card = [deck drawRandomCard];
      if (card) {
        [self.cards addObject:card];
      } else {
        self = nil;
        break;
      }
    }
  }
  return  self;
}

- (Card *)cardAtIndex:(NSUInteger)index {
  return (index < self.cards.count) ? self.cards[index] : nil;
}

static const int MISMATCH_PENALTY = 2;  // 选错惩罚分数
static const int MATCH_BONUS = 4;       // 选对分数红利
static const int COST_TO_CHOOSE = 1;    // 选牌减分

- (void)chooseCardAtIndex:(NSUInteger)index cardCount:(int)cardCount {
  self.scoreChange = 0;
  Card *card = [self cardAtIndex:index];
  if (![card isMatched]) {    // 判断牌是否匹配完毕，如果没匹配过，才进行操作
    if ([card isChosen]) {  // 判断牌是否被选中
      card.chosen = NO;   // 玩家点击被选中的牌，取消该牌选中
      [self.cardsForMatch removeObject:card]; // 将取消选中的牌从带比较牌堆中移除
      self.chosingCards = [self.cardsForMatch copy]; // 设置选择中的牌
    } else {                // 如果该牌没被选中，则进行匹配
      if (self.cardsForMatch.count < cardCount) { // 选中的牌不够比较
        [self.cardsForMatch addObject:card];
        card.chosen = YES;
        self.chosingCards = [self.cardsForMatch copy];
      } else if (self.cardsForMatch.count == cardCount) { // 选中的牌足够比较
        int matchScore = [card match:[self.cardsForMatch copy]];     // 对找到的牌进行匹配
        if (matchScore > 0) {   // 选对加分
          self.score += matchScore * MATCH_BONUS;
          for (Card *otherCard in self.cardsForMatch) {
            otherCard.matched = YES;
          }
          card.matched = YES;
          card.chosen = YES;
          self.chosingCards = [[self.cardsForMatch copy] arrayByAddingObject:card];
          self.scoreChange = matchScore *MATCH_BONUS;
        } else {            // 选错减分
          self.score -= MISMATCH_PENALTY * cardCount;
          for (Card *otherCard in self.cardsForMatch) {
            otherCard.chosen = NO;
          }
          self.chosingCards = [[self.cardsForMatch copy] arrayByAddingObject:card];
          self.scoreChange = - MISMATCH_PENALTY * cardCount;
        }
        self.cardsForMatch = nil;
      }
      self.score -= COST_TO_CHOOSE;
    }
    self.chooseTimes++;
  }
}

@end

