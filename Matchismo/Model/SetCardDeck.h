//
//  SetCardDeck.h
//  Matchismo
//
//  Created by Lmz on 2017/2/15.
//  Copyright © 2017年 CS193p. All rights reserved.
//

#import "Deck.h"

@interface SetCardDeck : Deck

// designed initializer
- (instancetype)initWithSymbols:(NSArray *)symbols andColors:(NSArray *)colors;

@end
