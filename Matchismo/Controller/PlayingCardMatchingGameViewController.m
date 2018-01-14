//
//  PlayingCardMatchingGameViewController.m
//  Matchismo
//
//  Created by Lmz on 2017/2/20.
//  Copyright © 2017年 CS193p. All rights reserved.
//

#import "PlayingCardMatchingGameViewController.h"
#import "PlayingCardDeck.h"
#import "UserDefaultHelper.h"

@interface PlayingCardMatchingGameViewController ()

@property (assign, nonatomic) int matchingMode;

@end

@implementation PlayingCardMatchingGameViewController

#pragma mark - getters & setters

- (Deck *)createCardDeck {  // get a playing card deck
  return [[PlayingCardDeck alloc] init];
}

- (void)setMatchingMode:(int)matchingMode {
  _matchingMode = matchingMode;
  [self resetGame];
}

#pragma mark - Play game method
// 翻牌
- (IBAction)touchCardButton:(UIButton *)sender {    // when pick a card
  [self scoreRecord];
  NSUInteger chosenButtonIndex = [self.cardButtons indexOfObject:sender];
  [self.game chooseCardAtIndex:chosenButtonIndex cardCount:self.matchingMode];   // matching mode, assume by settings
  [self updateUI];
}

#pragma mark - Card content

- (NSAttributedString *)cardFace:(Card *)card { // get card face
  NSString *content = card.contents;
  UIColor *titleColor = nil;
  if ([content hasSuffix: @"♠︎"] ||
      [content hasSuffix: @"♣︎"]) {
    titleColor = [UIColor blackColor];
  } else {
    titleColor = [UIColor redColor];
  }
  NSAttributedString *cardTitle = [[NSAttributedString alloc] initWithString:content
                                                                  attributes:@{NSForegroundColorAttributeName:titleColor}];
  return cardTitle;
}

- (NSAttributedString *)titleForCard:(Card *)card { // set card face
  NSAttributedString *cardTitle = card.isChosen ? [[NSAttributedString alloc] initWithAttributedString:[self cardFace:card]] : [[NSAttributedString alloc] initWithString:@""];
  return cardTitle;
}

- (UIImage *)backgroundImageForCard:(Card *)card {  // set card bgimage
  return [UIImage imageNamed:card.isChosen ? @"CardFront" : @"CardBack"];
}

#pragma mark - lifecycle

- (void)viewDidLoad {
  [super viewDidLoad];
  self.matchingMode = (int)[UserDefaultHelper readIntegerFromDefaultByKey:@"PlayingCardMathcingMode"];
  if (!self.matchingMode) {
    self.matchingMode = 2;
    [UserDefaultHelper writeIntegerToDefault:2 key:@"PlayingCardMathcingMode"];
  }
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  int savedMatchingMode = (int)[UserDefaultHelper readIntegerFromDefaultByKey:@"PlayingCardMathcingMode"];
  if (savedMatchingMode != self.matchingMode) {
    self.matchingMode = savedMatchingMode;
  }
}

#pragma mark - Tools

- (NSString *)gameName {
  return @"PlayingCardGame";
}
@end

