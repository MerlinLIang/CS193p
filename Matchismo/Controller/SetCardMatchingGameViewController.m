//
//  SetCardMatchingGameViewController.m
//  Matchismo
//
//  Created by Lmz on 2017/2/20.
//  Copyright © 2017年 CS193p. All rights reserved.
//

#import "SetCardMatchingGameViewController.h"
#import "SetCardDeck.h"
#import "SetCard.h"

@interface SetCardMatchingGameViewController ()

@end

@implementation SetCardMatchingGameViewController

- (NSString *)gameName {
    return @"SetCardGame";
}

#pragma mark - lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self updateUI];
}

#pragma mark - getters & setters

- (Deck *)createCardDeck {
    return [[SetCardDeck alloc] initWithSymbols:@[@"▲", @"●", @"◼︎"] andColors:@[@0, @3, @2]];
}

#pragma mark - Play game method
// 翻牌
- (IBAction)touchCardButton:(UIButton *)sender {    // when pick a card
    [self scoreRecord];
    NSUInteger chosenButtonIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:chosenButtonIndex cardCount: 2];   // matching mode, assume by settings
    [self updateUI];
}

#pragma mark - Card content

- (NSAttributedString *)cardFace:(Card *)card {
    if (![card isKindOfClass:[SetCard class]]) {
        return nil;
    }
    SetCard *targetCard = (SetCard *)card;
    NSMutableAttributedString *cardFace = [[NSMutableAttributedString alloc] init];
    UIFont *pfont = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    UIFontDescriptor *fd = [pfont fontDescriptor];
    UIFont *font = [UIFont fontWithDescriptor:fd size:18];
    for (int number = 0; number < targetCard.number; number++) {
        NSAttributedString *singleCardFace = [[NSAttributedString alloc] initWithString:targetCard.symbol
                                                                            attributes:@{NSStrokeColorAttributeName:[self colors][targetCard.color],
                                                                                         NSStrokeWidthAttributeName:[self patternShadingWidth][targetCard.shading],
                                                                                     NSForegroundColorAttributeName:[self patternColor:targetCard.color patternShading:targetCard.shading],
                                                                                                NSFontAttributeName:font}];
        [cardFace appendAttributedString:singleCardFace];
    }
    return [cardFace copy];
}

- (NSAttributedString *)titleForCard:(Card *)card {
    return [self cardFace:card];
}

- (UIImage *)backgroundImageForCard:(Card *)card {
    return [UIImage imageNamed:card.isChosen ? @"SetCardSelected" : @"SetCardNormal"];
}

#pragma mark - Card appearance methods

- (NSArray *)patternShadingWidth {
    return @[@-5, @-5, @5];
}

- (NSArray *)colors {
    return @[[UIColor redColor], [UIColor yellowColor], [UIColor blueColor], [UIColor greenColor], [UIColor orangeColor], [UIColor purpleColor], [UIColor grayColor], [UIColor whiteColor], [UIColor blueColor], [UIColor brownColor], [UIColor cyanColor]];
}

- (UIColor *)patternColor:(SetCardPatternColor)color patternShading:(SetCardPatternShading)shading {
    UIColor *patternColor = [self colors][color];
    switch (shading) {
        case SetCardPatternShadingSolid:
            break;
        case SetCardPatternShadingStriped:
            patternColor = [patternColor colorWithAlphaComponent:0.3];
            break;
        case SetCardPatternShadingOpen:
            patternColor = [UIColor colorWithWhite:1 alpha:0];
            break;
            
        default:
            break;
    }
    return patternColor;
}


@end
