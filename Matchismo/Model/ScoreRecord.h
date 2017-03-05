//
//  ScoreRecord.h
//  Matchismo
//
//  Created by Lmz on 2017/2/23.
//  Copyright © 2017年 CS193p. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ScoreRecord : NSObject

@property (assign, nonatomic) NSInteger score;
@property (strong, nonatomic) NSDate *gameDate;
@property (assign, nonatomic) double duiration;

- (void)newRecord:(NSInteger)score ForGame:(NSString *)game;  // generate a new record
- (NSArray *)recordsForGame:(NSString *)game;    // get records
- (NSArray *)sortArray:(NSArray *)array byKey:(NSString *)key;

@end
