//
//  ViewController.h
//  Matchismo
//
//  Created by Lmz on 2017/2/8.
//  Copyright © 2017年 Lmz. All rights reserved.
//  Abstract class, should implentation follew methods.

#import <UIKit/UIKit.h>
#import "Deck.h"
#import "CardMatchingGame.h"
#import "ScoreRecord.h"

@interface ViewController : UIViewController

@property (strong, nonatomic) CardMatchingGame *game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (strong, nonatomic) ScoreRecord *scoreRecord;

// abstract methods.
- (Deck *)createCardDeck;   // create a specify deck.
- (IBAction)touchCardButton:(UIButton *)sender; // do something when card was touched.
- (NSAttributedString *)cardFace:(Card *)card;  // return card content.
- (NSAttributedString *)titleForCard:(Card *)card;  // decide whether content should be card title.
- (UIImage *)backgroundImageForCard:(Card *)card;   // set card background image at different states.
- (NSString *)gameName;

// don't rewrite.
- (void)updateUI;
- (void)resetGame;

@end

