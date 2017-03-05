//
//  ViewController.m
//  Matchismo
//
//  Created by Lmz on 2017/2/8.
//  Copyright © 2017年 Lmz. All rights reserved.
//

#import "ViewController.h"
#import "HistoryViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *scoreLable;
@property (weak, nonatomic) IBOutlet UILabel *hintLable;
@property (strong, nonatomic) NSMutableArray *hintHistories;    // of NSAttributedString

@end

@implementation ViewController

#pragma mark - getters & setters

- (ScoreRecord *)scoreRecord {
    if (!_scoreRecord) {
        _scoreRecord = [[ScoreRecord alloc] init];
    }
    return _scoreRecord;
}

- (NSMutableArray *)hintHistories {
    if (!_hintHistories) {
        _hintHistories = [[NSMutableArray alloc] init];
    }
    return _hintHistories;
}

- (CardMatchingGame *)game {
    if (!_game) {
        _game = [[CardMatchingGame alloc] initWithCardCount:self.cardButtons.count
                                                  usingDeck:[self createCardDeck]];
    }
    return _game;
}

- (Deck *)createCardDeck {  // abstract
    return nil;
}

#pragma mark - Play game method
// 翻牌
- (IBAction)touchCardButton:(UIButton *)sender {    // abstract
}

- (void)updateUI {
    for (UIButton *cardButton in self.cardButtons) {
        NSUInteger cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardButtonIndex];
        [cardButton setAttributedTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
    }
    self.scoreLable.text = [NSString stringWithFormat:@"Score:%ld", self.game.score];
    [self textForHintLable];
    self.hintLable.attributedText = [self.hintHistories lastObject];
}

- (NSAttributedString *)cardFace:(Card *)card { // abstract
    return nil;
}

- (NSAttributedString *)titleForCard:(Card *)card { // abstract
    return nil;
}

- (UIImage *)backgroundImageForCard:(Card *)card {  // abstract
    return nil;
}

#pragma mark - Hint Lable
// get content of hintLable
- (void)textForHintLable {
    NSString *textHead = [NSString stringWithFormat:@"STEP %d: ",self.game.chooseTimes];
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:textHead
                                                                                       attributes:@{NSForegroundColorAttributeName:[UIColor cyanColor],
                                                                                                    NSStrokeColorAttributeName:[UIColor cyanColor],
                                                                                                    NSStrokeWidthAttributeName:@-5}];
    NSMutableAttributedString *chosingCardsText = [[NSMutableAttributedString alloc] init];
    for (Card *card in self.game.chosingCards) {
        [chosingCardsText appendAttributedString:[self cardFace:card]];
        NSAttributedString *as = [[NSAttributedString alloc] initWithString:@" "];
        [chosingCardsText appendAttributedString:as];
    }
    if (self.game.scoreChange == 0) {   // 返回零分，只显示被选择的卡片
        [attributedText appendAttributedString:chosingCardsText];
    } else if (self.game.scoreChange > 0) {     // 返回正数，表示匹配成功
        NSAttributedString *as = [[NSAttributedString alloc] initWithString:@"Matched "
                                                                 attributes:@{NSForegroundColorAttributeName:[UIColor cyanColor]}];
        NSAttributedString *asScore = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"for %d points", self.game.scoreChange]
                                                                                                 attributes:@{NSForegroundColorAttributeName:[UIColor cyanColor]}];
        [attributedText appendAttributedString:as];
        [attributedText appendAttributedString:chosingCardsText];
        [attributedText appendAttributedString:asScore];
    } else if (self.game.scoreChange < 0) {     // 返回负数，表示匹配失败
        NSAttributedString *asScore = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"don't match! %d points penalty!", -self.game.scoreChange]
                                                                      attributes:@{NSForegroundColorAttributeName:[UIColor cyanColor]}];
        [attributedText appendAttributedString:chosingCardsText];
        [attributedText appendAttributedString:asScore];
    }
    UIFont *sysFont = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    UIFontDescriptor *fd = [sysFont fontDescriptor];
    UIFont *font = [UIFont fontWithDescriptor:fd size:17];
    [attributedText addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, attributedText.length)];
    [self.hintHistories addObject:attributedText];
}


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
    self.hintHistories = nil;
    self.scoreRecord = nil;
}

- (NSString *)gameName {    // abstract
    return nil;
}

#pragma mark - Segue 

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"Show History"]) {
        if ([segue.destinationViewController isKindOfClass:[HistoryViewController class]]) {
            HistoryViewController *hvc = (HistoryViewController *)segue.destinationViewController;
            hvc.hintHistories = self.hintHistories;
        }
    }
}

@end










