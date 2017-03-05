//
//  HighScoresViewController.m
//  Matchismo
//
//  Created by Lmz on 2017/2/22.
//  Copyright © 2017年 CS193p. All rights reserved.
//

#import "HighScoresViewController.h"
#import "ScoreRecord.h"

@interface HighScoresViewController ()

@property (strong, nonatomic) ScoreRecord *scoreRecord;
@property (weak, nonatomic) IBOutlet UIView *PlayingCardGameRecordView;
@property (weak, nonatomic) IBOutlet UIView *SetCardGameRecordView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *PlayingCardGameRecordViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *SetCardGameRecordViewHeight;

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
    // remove all subviews in tow records view
    for (int i = 4; i < self.PlayingCardGameRecordView.subviews.count;) {
        UIView *view = self.PlayingCardGameRecordView.subviews[i];
        [view removeFromSuperview];
    }
    for (int i = 4; i < self.SetCardGameRecordView.subviews.count;) {
        UIView *view = self.SetCardGameRecordView.subviews[i];
        [view removeFromSuperview];
    }
    
    self.PlayingCardGameRecordViewHeight.constant = 101;
    self.SetCardGameRecordViewHeight.constant = 101;
    
    int playingCardGameRecordsY = 93;
    NSArray *playingCardRecords = [self attributedRecordsForGame:@"PlayingCardGame" byKey:key];
    for (NSDictionary *record in playingCardRecords) {
        [self addSingleRecord:record intoView:self.PlayingCardGameRecordView atY:&playingCardGameRecordsY byViewConstraint:self.PlayingCardGameRecordViewHeight];
    }
    
    int setCardGameRecordsY = 77;
    NSArray *setCardRecords = [self attributedRecordsForGame:@"SetCardGame" byKey:key];
    for (NSDictionary *record in setCardRecords) {
        [self addSingleRecord:record intoView:self.SetCardGameRecordView atY:&setCardGameRecordsY byViewConstraint:self.SetCardGameRecordViewHeight];
    }
    self.SetCardGameRecordViewHeight.constant += 20;
}

// create single record and add it into view
- (void)addSingleRecord:(NSDictionary *)record intoView:(UIView *)view atY:(int *)Y byViewConstraint:(NSLayoutConstraint *)constraint {
    // position constant
    const int HEIGHT = 21;
    const int TIME_X = 27;
    const int TIME_WIDTH = 135;
    const int SCORE_X = 170;
    const int SCORE_WIDTH = 56;
    const int DUIRATION_X = 258;
    const int DUIRATION_WIDTH = 89;
    
    // create lables
    UILabel *time = [[UILabel alloc] initWithFrame:CGRectMake(TIME_X, *Y, TIME_WIDTH, HEIGHT)];
    UILabel *score = [[UILabel alloc] initWithFrame:CGRectMake(SCORE_X, *Y, SCORE_WIDTH, HEIGHT)];
    UILabel *duiration = [[UILabel alloc] initWithFrame:CGRectMake(DUIRATION_X, *Y, DUIRATION_WIDTH, HEIGHT)];
    
    // set Y for next row
    const int ROW_SPACE = 8;
    *Y = *Y + HEIGHT +ROW_SPACE;
    
    // set content of lables
    time.attributedText = record[@"GameDate"];
    score.attributedText = record[@"Score"];
    duiration.attributedText = record[@"Duiration"];
    
    // add labels to view
    [view addSubview:time];
    [view addSubview:score];
    [view addSubview:duiration];
    
    // modefy view contraint to adapt content
    constraint.constant = constraint.constant + HEIGHT + ROW_SPACE;
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
