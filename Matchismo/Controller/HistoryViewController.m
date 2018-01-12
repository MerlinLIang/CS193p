//
//  HistoryViewController.m
//  Matchismo
//
//  Created by Lmz on 2017/2/20.
//  Copyright © 2017年 CS193p. All rights reserved.
//

#import "HistoryViewController.h"

@interface HistoryViewController ()
@property (weak, nonatomic) IBOutlet UITextView *historyTextView;

@end

@implementation HistoryViewController

#pragma mark - lifecycle

- (void)viewDidLoad {
  [super viewDidLoad];
  [self setHistoryTextViewContent];
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  [self.historyTextView scrollRangeToVisible:NSMakeRange(self.historyTextView.attributedText.length, 1)];
}

#pragma mark - set textView's content

- (void)setHistoryTextViewContent {
  NSMutableAttributedString *content = [[NSMutableAttributedString alloc] init];
  for (NSAttributedString *history in self.hintHistories) {
    [content appendAttributedString:history];
    [content appendAttributedString:[[NSAttributedString alloc] initWithString:@"\n" attributes:nil]];
  }
  self.historyTextView.attributedText = [content copy];
}

@end

