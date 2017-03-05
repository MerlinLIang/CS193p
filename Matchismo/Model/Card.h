//
//  Card.h
//  Matchismo
//
//  Created by Lmz on 2017/2/8.
//  Copyright © 2017年 CS193p. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject

@property (copy, nonatomic) NSString *contents;

@property (assign, nonatomic, getter=isChosen) BOOL chosen;
@property (assign, nonatomic, getter=isMatched) BOOL matched;

- (int)match:(NSArray *)otherCards;


@end
