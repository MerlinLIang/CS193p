//
//  SettingsViewController.m
//  Matchismo
//
//  Created by Lmz on 2017/2/28.
//  Copyright © 2017年 CS193p. All rights reserved.
//

#import "SettingsViewController.h"
#import "UserDefaultHelper.h"

@interface SettingsViewController ()
@property (weak, nonatomic) IBOutlet UISegmentedControl *playingCardModeSeg;

@end

@implementation SettingsViewController

#pragma mark - event
- (IBAction)playingCardMatchingMode:(UISegmentedControl *)sender {
  [UserDefaultHelper writeIntegerToDefault:sender.selectedSegmentIndex + 1 key:@"PlayingCardMathcingMode"];
}

- (IBAction)resetPlayingCardScoreRecords:(id)sender {
  [UserDefaultHelper removeDefaultForKey:@"PlayingCardGameRecords"];
}
- (IBAction)resetSetCardGameScoreRecords:(id)sender {
  [UserDefaultHelper removeDefaultForKey:@"SetCardGameRecords"];
}

 
#pragma mark - lifecycle

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  NSInteger selectedIndex = (NSUInteger)[UserDefaultHelper readIntegerFromDefaultByKey:@"PlayingCardMathcingMode"];
  if (!selectedIndex) {
    selectedIndex = 2;
  }
  self.playingCardModeSeg.selectedSegmentIndex = selectedIndex - 1;
}

@end

