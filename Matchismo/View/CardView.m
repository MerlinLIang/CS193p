//
//  CardView.m
//  Matchismo
//
//  Created by Lmz on 2018/1/24.
//  Copyright © 2018年 CS193p. All rights reserved.
//

#import "CardView.h"

@implementation CardView

#pragma mark - Draw

#define CORNER_FONT_STANDARD_HEIGHT 200.0
#define CORNER_RADIUS 12

- (CGFloat)cornerScaleFactor { return self.bounds.size.height / CORNER_FONT_STANDARD_HEIGHT; }
- (CGFloat)cornerRadius { return CORNER_RADIUS * [self cornerScaleFactor]; }
// - (CGFloat)cornerOffset { return [self cornerRadius] / 3.0; }

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
  // Drawing code
  UIBezierPath *roundedRect = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:[self cornerRadius]];
  
  [roundedRect addClip];
  
  [[UIColor whiteColor] setFill];
  UIRectFill(self.bounds);
  
  [[UIColor blackColor] setStroke];
  [roundedRect stroke];
}

#pragma mark - Initialization
- (void)setup {
  self.backgroundColor = nil;
  self.opaque = NO;
  self.contentMode = UIViewContentModeRedraw;
}

- (void)awakeFromNib {
  [super awakeFromNib];
  [self setup];
}

#pragma mark - Getters & Setters
- (void)setIsChoosed:(BOOL)isChoosed {
  _isChoosed = isChoosed;
  [self setNeedsDisplay];
}

@end
