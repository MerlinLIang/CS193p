//
//  PlayingCardView.m
//  SuperCard
//
//  Created by Lmz on 2018/1/7.
//  Copyright © 2018年 Lmz. All rights reserved.
//

#import "PlayingCardView.h"

@interface PlayingCardView()
@property (nonatomic, assign) CGFloat faceCardScaleFactor;
@end

@implementation PlayingCardView

- (CGFloat)cornerOffset { return [self cornerRadius] / 3.0; }

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
  [super drawRect:rect];
  
  if (self.faceUp) {
    UIImage *faceImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@%@", [self rankAsString], self.suit]];
    if (faceImage) {
      CGRect imageRect = CGRectInset(self.bounds,
                                     self.bounds.size.width * (1.0-self.faceCardScaleFactor ),
                                     self.bounds.size.height * (1.0-self.faceCardScaleFactor));
      [faceImage drawInRect:imageRect];
    } else {
      [self drawPips];
    }
    
    [self drawCorners];
  } else {
    [[UIImage imageNamed:@"cardback"] drawInRect:self.bounds];
  }
}

- (NSString *)rankAsString {
  return @[@"?", @"A", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"J", @"Q", @"K"][self.rank];
}

- (void)drawCorners {
  NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
  paragraphStyle.alignment = NSTextAlignmentCenter;
  
  UIFont *cornerFont = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
  cornerFont = [cornerFont fontWithSize:cornerFont.pointSize * [self cornerScaleFactor]];
  
  NSAttributedString *cornerText = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@\n%@", [self rankAsString], self.suit] attributes:@{ NSFontAttributeName : cornerFont, NSParagraphStyleAttributeName : paragraphStyle }];
  
  CGRect textBounds;
  textBounds.origin = CGPointMake([self cornerOffset], [self cornerOffset]);
  textBounds.size = [cornerText size];
  [cornerText drawInRect:textBounds];
  
  CGContextRef context = UIGraphicsGetCurrentContext();
  CGContextTranslateCTM(context, self.bounds.size.width, self.bounds.size.height);
  CGContextRotateCTM(context, M_PI);
  [cornerText drawInRect:textBounds];
}

#pragma mark - Pips

#define PIP_HOFFSET_PERCENTAGE 0.165
#define PIP_VOFFSET1_PERCENTAGE 0.090
#define PIP_VOFFSET2_PERCENTAGE 0.175
#define PIP_VOFFSET3_PERCENTAGE 0.270

- (void)drawPips {
  if ((self.rank == 1) || (self.rank == 5) || (self.rank == 9) || (self.rank == 3)) {
    [self drawPipsWithHorizontalOffset:0 verticalOffset:0 mirroredVertically:NO];
  }
  
  if ((self.rank == 6) || (self.rank == 7) || (self.rank == 8)) {
    [self drawPipsWithHorizontalOffset:PIP_HOFFSET_PERCENTAGE verticalOffset:0 mirroredVertically:NO];
  }
  
  if ((self.rank == 2) || (self.rank == 3) || (self.rank == 7) || (self.rank == 8) || (self.rank == 10)) {
    [self drawPipsWithHorizontalOffset:0 verticalOffset:PIP_VOFFSET2_PERCENTAGE mirroredVertically:(self.rank != 7)];
  }
  
  if ((self.rank == 4) || (self.rank == 5) || (self.rank == 6) || (self.rank == 7) || (self.rank == 8) || (self.rank == 9) || (self.rank == 10)) {
    [self drawPipsWithHorizontalOffset:PIP_HOFFSET_PERCENTAGE verticalOffset:PIP_VOFFSET3_PERCENTAGE mirroredVertically:YES];
  }
  
  if ((self.rank == 9) || (self.rank == 10)) {
    [self drawPipsWithHorizontalOffset:PIP_HOFFSET_PERCENTAGE verticalOffset:PIP_VOFFSET1_PERCENTAGE mirroredVertically:YES];
  }
}

#define PIP_FONT_SCALE_FACTOR 0.009
- (void)drawPipsWithHorizontalOffset:(CGFloat)hoffset
                      verticalOffset:(CGFloat)voffset
                          upsideDown:(BOOL)upsideDown {
  if (upsideDown) {
    [self pushContextAndRotateUpsideDown];
  }
  CGPoint middle = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
  UIFont *pipFont = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
  pipFont = [pipFont fontWithSize:([pipFont pointSize] * self.bounds.size.width * PIP_FONT_SCALE_FACTOR)];
  NSAttributedString *attributedSuit = [[NSAttributedString alloc] initWithString:self.suit attributes:@{ NSFontAttributeName : pipFont}];
  CGSize pipSize = [attributedSuit size];
  CGPoint pipOrigin = CGPointMake(
                                  middle.x-pipSize.width/2.0-hoffset*self.bounds.size.width,
                                  middle.y-pipSize.height/2.0-voffset*self.bounds.size.height
                                  );
  [attributedSuit drawAtPoint:pipOrigin];
  if (hoffset) {
    pipOrigin.x += hoffset*2.0*self.bounds.size.width;
    [attributedSuit drawAtPoint:pipOrigin];
  }
  if (upsideDown) {
    [self popContext];
  }
}

- (void)drawPipsWithHorizontalOffset:(CGFloat)hoffset
                      verticalOffset:(CGFloat)voffset
                  mirroredVertically:(BOOL)mirroredVertically {
  [self drawPipsWithHorizontalOffset:hoffset verticalOffset:voffset upsideDown:NO];
  if (mirroredVertically) {
    [self drawPipsWithHorizontalOffset:hoffset verticalOffset:voffset upsideDown:YES];
  }
}

- (void)pushContextAndRotateUpsideDown {
  CGContextRef context = UIGraphicsGetCurrentContext();
  CGContextSaveGState(context);
  CGContextTranslateCTM(context, self.bounds.size.width, self.bounds.size.height);
  CGContextRotateCTM(context, M_PI);
}

- (void)popContext {
  CGContextRestoreGState(UIGraphicsGetCurrentContext());
}

#pragma mark - Gesture
- (void)pinch:(UIPinchGestureRecognizer *)gesture {
  if ((gesture.state == UIGestureRecognizerStateEnded) || (gesture.state == UIGestureRecognizerStateChanged)) {
    self.faceCardScaleFactor *= gesture.scale;
    gesture.scale = 1.0;
  }
}

#pragma mark - Initialization
- (void)setup {
  [super setup];
  
  self.faceUp = YES;
}

#pragma mark - Getters & Setters
- (void)setSuit:(NSString *)suit {
  _suit = suit;
  [self setNeedsDisplay];
}

- (void)setRank:(NSUInteger)rank {
  _rank = rank;
  [self setNeedsDisplay];
}

- (void)setFaceUp:(BOOL)faceUp {
  _faceUp = faceUp;
  [self setNeedsDisplay];
}

#define DEFAULT_FACE_CARD_SCALE_FACTOR 0.80
@synthesize faceCardScaleFactor = _faceCardScaleFactor;
- (CGFloat)faceCardScaleFactor {
  if (!_faceCardScaleFactor) {
    _faceCardScaleFactor = DEFAULT_FACE_CARD_SCALE_FACTOR;
  }
  return  _faceCardScaleFactor;
}

- (void)setFaceCardScaleFactor:(CGFloat)faceCardScaleFactor {
  _faceCardScaleFactor = faceCardScaleFactor;
  [self setNeedsDisplay];
}

@end
