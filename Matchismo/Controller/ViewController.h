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
@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *cardViews;
@property (strong, nonatomic) ScoreRecord *scoreRecord;

// abstract methods.
- (Deck *)createCardDeck;   // create a specify deck.

- (IBAction)touchCardView:(UIView *)sender; // do something when card was touched.
- (NSString *)gameName;
- (void)configureView; // set view data

/* For button card
- (NSAttributedString *)cardFace:(Card *)card;  // return card content.
- (NSAttributedString *)titleForCard:(Card *)card;  // decide whether content should be card title.
- (UIImage *)backgroundImageForCard:(Card *)card;   // set card background image at different states.
 */

// don't rewrite.
- (void)updateUI;
- (void)resetGame;

@end

