//
//  PlayingCard.m
//  Matchismo
//
//  Created by Lmz on 2017/2/8.
//  Copyright © 2017年 CS193p. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

#pragma mark - Math cards

- (int)match:(NSArray *)otherCards { //重写match方法，适用于扑克牌比较
    int score = 0;
    int rankScoreLevel = 0;
    int suitScoreLevel = 0;
    
    // 通过递归得到花色和大小匹配的次数
    [self coreMatchCard:self
             otherCards:otherCards
         rankScoreLevel:&rankScoreLevel
         suitScoreLevel:&suitScoreLevel];
    
    score = [[PlayingCard rankScores][rankScoreLevel] intValue] +
            [[PlayingCard suitScores][suitScoreLevel] intValue];
    return score;
}

// 递归match核心比较方法，实现不定数量牌比较
- (void)coreMatchCard:(PlayingCard *)card
           otherCards:(NSArray *)otherCards
       rankScoreLevel:(int *)rankScoreLevel
       suitScoreLevel:(int *)suitScoreLevel {
    
    for (PlayingCard *otherCard in otherCards) {
        if (otherCard.rank == card.rank) {
            *rankScoreLevel += 1;
        } else if ([otherCard.suit isEqualToString:card.suit]) {
            *suitScoreLevel += 1;
        }
    }
    if (otherCards.count >= 1) {
        card = [otherCards lastObject];
        NSArray *leftCards = [otherCards subarrayWithRange:NSMakeRange(0, otherCards.count - 1)];
        [self coreMatchCard:card
                 otherCards:leftCards
             rankScoreLevel:rankScoreLevel
             suitScoreLevel:suitScoreLevel];
    }
}

#pragma mark - getters & setters

- (NSString *)contents {
    NSArray *rankStrings = [PlayingCard rankStrings];
    return  [rankStrings[self.rank] stringByAppendingString:self.suit];
}

@synthesize suit = _suit;
- (NSString *)suit {
    return _suit ? _suit : @"?";
}
- (void)setSuit:(NSString *)suit {
    if ([[PlayingCard validSuits] containsObject:suit]) {
        _suit = suit;
    }
}

- (void)setRank:(NSUInteger)rank {
    if (rank <= [PlayingCard maxRank]) {
        _rank = rank;
    }
}

#pragma mark - Tool methods

+ (NSArray *)rankStrings {
    return @[@"?", @"A", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"J", @"Q", @"K"];
}

+ (NSArray *)validSuits {
    return @[@"♠︎", @"♣︎", @"♥︎", @"♦︎"];
}

+ (NSUInteger)maxRank {
    return [self rankStrings].count - 1;
}

+ (NSArray *)rankScores {
    return @[@0, @4, @10, @22];
}

+ (NSArray *)suitScores {
    return @[@0, @1, @2, @3, @4, @5, @6, @8, @10, @13, @17, @23, @35];
}

@end
