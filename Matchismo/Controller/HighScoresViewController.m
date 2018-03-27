//
//  HighScoresViewController.m
//  Matchismo
//
//  Created by Lmz on 2017/2/22.
//  Copyright © 2017年 CS193p. All rights reserved.
//

#import "HighScoresViewController.h"
#import "ScoreRecord.h"

typedef enum : NSUInteger {
  PlayingCardGame,
  SetCardGame,
} GameType;

@interface HighScoresViewController ()

@property (strong, nonatomic) ScoreRecord *scoreRecord;
@property (weak, nonatomic) IBOutlet UIStackView *PlayingCardTimeStack;
@property (weak, nonatomic) IBOutlet UIStackView *PlayingCardScoreStack;
@property (weak, nonatomic) IBOutlet UIStackView *PlayingCardDuirationStack;
@property (weak, nonatomic) IBOutlet UIStackView *SetCardTimeStack;
@property (weak, nonatomic) IBOutlet UIStackView *SetCardScoreStack;
@property (weak, nonatomic) IBOutlet UIStackView *SetCardDuirationStack;

@end

@implementation HighScoresViewController

#pragma mark - Order
- (IBAction)orderByTime:(UIBarButtonItem *)sender {
  [self initUIWithKey:@"GameDate"];
}

- (IBAction)orderByScore:(UIBarButtonItem *)sender {
  [self initUIWithKey:nil];
}

- (IBAction)orderByDuiration:(UIBarButtonItem *)sender {
  [self initUIWithKey:@"Duiration"];
}


#pragma mark - Init settings
// get attributed content of game records by game name
- (NSArray *)attributedRecordsForGame:(NSString *)game byKey:(NSString *)key {
  NSMutableArray *attributedRecords = [[NSMutableArray alloc] init];
  
  // get records and find special record
  NSArray *records = [self.scoreRecord recordsForGame:game];
  id maxScoreRecord = [records firstObject];
  if ([key isEqualToString:@"GameDate"]) {
    records = [self.scoreRecord sortArray:records byKey:key];
  } else if ([key isEqualToString:@"Duiration"]) {
    records = [self.scoreRecord sortArray:records byKey:key];
  }
  id minDuirationRecored = [[self.scoreRecord sortArray:records byKey:@"Duiration"] firstObject];
  id lastGameRecord = [[self.scoreRecord sortArray:records byKey:@"GameDate"] firstObject];
  
  // set attributedRecords
  for (NSDictionary *record in records) {
    NSAttributedString *score = nil;
    NSAttributedString *duiration = nil;
    NSAttributedString *gameDate = nil;
    
    // creat attributed string for record
    NSString *strScore = [(NSNumber *)record[@"Score"] stringValue];
    if ([maxScoreRecord isEqual:record]) {
      score = [[NSAttributedString alloc] initWithString:strScore attributes:@{NSForegroundColorAttributeName : [UIColor yellowColor]}];
    } else {
      score = [[NSAttributedString alloc] initWithString:strScore attributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    }
    
    NSString *strDuiration = [NSString stringWithFormat:@"%d Sec", (int)[(NSNumber *)record[@"Duiration"] doubleValue]];
    if ([minDuirationRecored isEqual:record]) {
      duiration = [[NSAttributedString alloc] initWithString:strDuiration attributes:@{NSForegroundColorAttributeName : [UIColor yellowColor]}];
    } else {
      duiration = [[NSAttributedString alloc] initWithString:strDuiration attributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    }
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd";
    NSString *strGameDate = [dateFormatter stringFromDate:(NSDate *)record[@"GameDate"]];
    if ([lastGameRecord isEqual:record]) {
      gameDate = [[NSAttributedString alloc] initWithString:strGameDate attributes:@{NSForegroundColorAttributeName : [UIColor yellowColor]}];
    } else {
      gameDate = [[NSAttributedString alloc] initWithString:strGameDate attributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    }
    
    // wrap attributed strings to dictionary, add it to attributedRecords
    NSDictionary *recordDict = @{@"Score":score, @"Duiration":duiration, @"GameDate":gameDate};
    [attributedRecords addObject:recordDict];
  }
  
  return  attributedRecords;
}

// initial UI
- (void)initUIWithKey:(NSString *)key {
  // remove all records in stacks
  [self clearStack:self.PlayingCardTimeStack];
  [self clearStack:self.PlayingCardScoreStack];
  [self clearStack:self.PlayingCardDuirationStack];
  [self clearStack:self.SetCardTimeStack];
  [self clearStack:self.SetCardScoreStack];
  [self clearStack:self.SetCardDuirationStack];
  
  // add records to stacks
  NSArray *playingCardRecords = [self attributedRecordsForGame:@"PlayingCardGame" byKey:key];
  for (NSDictionary *record in playingCardRecords) {
    [self addSingleRecord:record toGame:PlayingCardGame];
  }
  
  NSArray *setCardRecords = [self attributedRecordsForGame:@"SetCardGame" byKey:key];
  for (NSDictionary *record in setCardRecords) {
    [self addSingleRecord:record toGame:SetCardGame];
  }
}

// create single record and add it into view
- (void)addSingleRecord:(NSDictionary *)record toGame:(GameType)game {
  // create lables
  UILabel *time = [self recordLable];
  UILabel *score = [self recordLable];
  UILabel *duiration = [self recordLable];
  
  // set content of lables
  time.attributedText = record[@"GameDate"];
  score.attributedText = record[@"Score"];
  duiration.attributedText = record[@"Duiration"];
  
  // add lables to stacks
  if (game == PlayingCardGame) {
    [self.PlayingCardTimeStack addArrangedSubview:time];
    [self.PlayingCardScoreStack addArrangedSubview:score];
    [self.PlayingCardDuirationStack addArrangedSubview:duiration];
  } else if (game == SetCardGame) {
    [self.SetCardTimeStack addArrangedSubview:time];
    [self.SetCardScoreStack addArrangedSubview:score];
    [self.SetCardDuirationStack addArrangedSubview:duiration];
  }
}

// get a record label
- (UILabel *)recordLable {
  UILabel *record = [[UILabel alloc] initWithFrame:CGRectZero];
  record.textAlignment = NSTextAlignmentCenter;
  return record;
}

// remove records in stack
- (void)clearStack:(UIStackView *)stack {
  for (UILabel *lable in stack.arrangedSubviews) {
    if (lable.tag == 2) {
      continue;
    }
    [lable removeFromSuperview];
  }
}

#pragma mark - Lifecycle

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  [self initUIWithKey:nil];   // nil means default sequence(by score)
}


#pragma mark - getters & setters

- (ScoreRecord *)scoreRecord {
  if (!_scoreRecord) {
    _scoreRecord = [[ScoreRecord alloc] init];
  }
  return _scoreRecord;
}

@end

