//
//  ScoreRecord.m
//  Matchismo
//
//  Created by Lmz on 2017/2/23.
//  Copyright © 2017年 CS193p. All rights reserved.
//

#import "ScoreRecord.h"
#import "UserDefaultHelper.h"

@implementation ScoreRecord

- (NSArray *)sortArray:(NSArray *)array byKey:(NSString *)key { // sort a array by different keys in dictionary
  NSMutableArray *sortedArray = nil;
  if (!array.count) {
    return nil;
  } else {
    if ([key isEqualToString:@"Score"]) {
      sortedArray = [[NSMutableArray alloc] initWithArray:[array sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        NSInteger int1 = [(NSNumber *)(NSDictionary *)obj1[key] integerValue];
        NSInteger int2 = [(NSNumber *)(NSDictionary *)obj2[key] integerValue];
        return int1 < int2;
      }]];
    } else if ([key isEqualToString:@"Duiration"]) {
      sortedArray = [[NSMutableArray alloc] initWithArray:[array sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        NSInteger int1 = [(NSNumber *)(NSDictionary *)obj1[key] integerValue];
        NSInteger int2 = [(NSNumber *)(NSDictionary *)obj2[key] integerValue];
        return int1 > int2;
      }]];
    } else if ([key isEqualToString:@"GameDate"]) {
      sortedArray = [[NSMutableArray alloc] initWithArray:[array sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        NSDate *date1 = (NSDate *)(NSDictionary *)obj1[key];
        NSDate *date2 = (NSDate *)(NSDictionary *)obj2[key];
        return [date1 timeIntervalSinceDate:date2] < 0 ? 1 : 0;
      }]];
    }
  }
  return [sortedArray copy];
}

const int MAX_RECORD_COUNT = 10;
- (NSArray *)insertRecordInArray:(NSArray *)array withRecord:(NSDictionary *)record {   // insert record to records array, return new records array
  NSMutableArray *allRecords = [[NSMutableArray alloc] initWithArray:array];
  [allRecords addObject:record];
  allRecords = [[NSMutableArray alloc] initWithArray:[self sortArray:[allRecords copy] byKey:@"Score"]];
  while (allRecords.count > MAX_RECORD_COUNT) { // max records count is 10
    [allRecords removeLastObject];
  }
  return [allRecords copy];
}

- (NSArray *)recordsForGame:(NSString *)game {  // get user default item
  if ([game isEqualToString:@"PlayingCardGame"]) {
    return  [UserDefaultHelper readArrayFromDefaultByKey:@"PlayingCardGameRecords"];
  } else if ([game isEqualToString:@"SetCardGame"]) {
    return [UserDefaultHelper readArrayFromDefaultByKey:@"SetCardGameRecords"];
  }
  return nil;
}

- (void)writeRecords:(NSArray *)records ForGame:(NSString *)game {  // write score records to user default
  NSString *key = nil;
  if ([game isEqualToString:@"PlayingCardGame"] ||
      [game isEqualToString:@"SetCardGame"]) {
    key = [NSString stringWithFormat:@"%@Records", game];
  }
  [UserDefaultHelper writeArrayToDefault:records key:key];
}

- (void)newRecord:(NSInteger)score ForGame:(NSString *)game { // a new game record generate
  [self setDuiration:0]; // 0 has no meaning, this method don't need parameter
  self.score = score;
  NSDictionary *record = @{@"Score":@(self.score),
                           @"GameDate":self.gameDate,
                           @"Duiration":@(self.duiration)};
  NSArray *newRecords = [self insertRecordInArray:[self recordsForGame:game] withRecord:record];
  [self writeRecords:newRecords ForGame:game];
}

#pragma mark - getters & setters

- (NSDate *)gameDate {
  if (!_gameDate) {
    _gameDate = [[NSDate alloc] initWithTimeIntervalSinceNow:0];
  }
  return _gameDate;
}

- (void)setDuiration:(double)duiration {
  _duiration = [[NSDate dateWithTimeIntervalSinceNow:0] timeIntervalSinceDate:self.gameDate];
}

- (instancetype)init {
  self = [super init];
  if (self) {
    self.gameDate = [self gameDate];
  }
  return self;
}

@end

