//
//  PlayingCard.h
//  Matchismo
//
//  Created by Lmz on 2017/2/8.
//  Copyright © 2017年 CS193p. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface PlayingCard : Card

@property (copy, nonatomic) NSString *suit;
@property (assign, nonatomic) NSUInteger rank;

+ (NSArray *)validSuits;
+ (NSUInteger)maxRank;

@end
