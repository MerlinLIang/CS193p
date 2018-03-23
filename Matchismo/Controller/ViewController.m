//
//  ViewController.m
//  Matchismo
//
//  Created by Lmz on 2017/2/8.
//  Copyright © 2017年 Lmz. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *scoreLable;
@property (weak, nonatomic) IBOutlet UILabel *hintLable;

@end

@implementation ViewController

#pragma mark - getters & setters

- (ScoreRecord *)scoreRecord {
  if (!_scoreRecord) {
    _scoreRecord = [[ScoreRecord alloc] init];
  }
  return _scoreRecord;
}

- (CardMatchingGame *)game {
  if (!_game) {
    _game = [[CardMatchingGame alloc] initWithCardCount:self.cardViews.count
                                              usingDeck:[self createCardDeck]];
  }
  return _game;
}

- (Deck *)createCardDeck {  // abstract
  return nil;
}

#pragma mark - Play game method
// 翻牌
- (IBAction)touchCardView:(UIView *)sender {    // abstract
}

- (void)updateUI {
  [self configureView];
  
  /* For button card
//  for (UIButton *cardButton in self.cardButtons) {
//    NSUInteger cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
//    Card *card = [self.game cardAtIndex:cardButtonIndex];
//    [cardButton setAttributedTitle:[self titleForCard:card] forState:UIControlStateNormal];
//    [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
//    cardButton.enabled = !card.isMatched;
//  }
//  self.scoreLable.text = [NSString stringWithFormat:@"Score:%ld", self.game.score];
   */
}

- (void)configureView {}  // abstract

/* For card button
 - (NSAttributedString *)cardFace:(Card *)card { // abstract
 return nil;
 }
 
 - (NSAttributedString *)titleForCard:(Card *)card { // abstract
 return nil;
 }
 
 - (UIImage *)backgroundImageForCard:(Card *)card {  // abstract
 return nil;
 }
 */


//#pragma mark - Hint Lable
//// get content of hintLable
//- (void)textForHintLable {
//  NSString *textHead = [NSString stringWithFormat:@"STEP %d: ",self.game.chooseTimes];
//  NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:textHead
//                                                                                     attributes:@{NSForegroundColorAttributeName:[UIColor cyanColor],
//                                                                                                  NSStrokeColorAttributeName:[UIColor cyanColor],
//                                                                                                  NSStrokeWidthAttributeName:@-5}];
//  NSMutableAttributedString *chosingCardsText = [[NSMutableAttributedString alloc] init];
//  for (Card *card in self.game.chosingCards) {
//    [chosingCardsText appendAttributedString:[self cardFace:card]];
//    NSAttributedString *as = [[NSAttributedString alloc] initWithString:@" "];
//    [chosingCardsText appendAttributedString:as];
//  }
//  if (self.game.scoreChange == 0) {   // 返回零分，只显示被选择的卡片
//    [attributedText appendAttributedString:chosingCardsText];
//  } else if (self.game.scoreChange > 0) {     // 返回正数，表示匹配成功
//    NSAttributedString *as = [[NSAttributedString alloc] initWithString:@"Matched "
//                                                             attributes:@{NSForegroundColorAttributeName:[UIColor cyanColor]}];
//    NSAttributedString *asScore = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"for %d points", self.game.scoreChange]
//                                                                  attributes:@{NSForegroundColorAttributeName:[UIColor cyanColor]}];
//    [attributedText appendAttributedString:as];
//    [attributedText appendAttributedString:chosingCardsText];
//    [attributedText appendAttributedString:asScore];
//  } else if (self.game.scoreChange < 0) {     // 返回负数，表示匹配失败
//    NSAttributedString *asScore = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"don't match! %d points penalty!", -self.game.scoreChange]
//                                                                  attributes:@{NSForegroundColorAttributeName:[UIColor cyanColor]}];
//    [attributedText appendAttributedString:chosingCardsText];
//    [attributedText appendAttributedString:asScore];
//  }
//  UIFont *sysFont = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
//  UIFontDescriptor *fd = [sysFont fontDescriptor];
//  UIFont *font = [UIFont fontWithDescriptor:fd size:17];
//  [attributedText addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, attributedText.length)];
//}


#pragma mark - Reset Game method
// 重置游戏
- (IBAction)newGame:(UIBarButtonItem *)sender {
  if (self.scoreRecord) {
    [self.scoreRecord newRecord:self.game.score ForGame:[self gameName]];
  }
  [self resetGame];
}

- (void)resetGame {
  self.game = nil;
  [self updateUI];
  self.hintLable.text = @"";
  self.scoreRecord = nil;
}

- (NSString *)gameName {    // abstract
  return nil;
}

@end











