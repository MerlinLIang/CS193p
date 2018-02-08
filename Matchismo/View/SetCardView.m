//
//  SetCardView.m
//  Matchismo
//
//  Created by Lmz on 2018/1/24.
//  Copyright © 2018年 CS193p. All rights reserved.
//

#import "SetCardView.h"

@interface SetCardView()
@property (nonatomic, assign) CGFloat faceCardScaleFactor;
@end

@implementation SetCardView

- (void)drawRect:(CGRect)rect {
  [super drawRect:rect];
  
  [self drawPatterns];
}

#pragma mark - Patterns

#define PATTERN_VOFFSET1_PERCENTAGE 0.150
#define PATTERN_VOFFSET2_PERCENTAGE 0.270

- (CGPoint) patternMiddle { return CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2); }
- (CGPoint) twoPatternsPoint1 { return CGPointMake([self patternMiddle].x, [self patternMiddle].y - (self.bounds.size.height * PATTERN_VOFFSET1_PERCENTAGE)); }
- (CGPoint) twoPatternsPoint2 { return CGPointMake([self patternMiddle].x, [self patternMiddle].y + (self.bounds.size.height * PATTERN_VOFFSET1_PERCENTAGE)); }
- (CGPoint) threePatternsPoint1 { return CGPointMake([self patternMiddle].x, [self patternMiddle].y - (self.bounds.size.height * PATTERN_VOFFSET2_PERCENTAGE)); }
- (CGPoint) threePatternsPoint2 { return CGPointMake([self patternMiddle].x, [self patternMiddle].y + (self.bounds.size.height * PATTERN_VOFFSET2_PERCENTAGE)); }

- (void)drawPatterns {
  switch (self.number) {
    case 1:
      switch (self.symbol) {
        case SetCardPatternSymbolDiamond:
          [self drawDiamondAtPoint:[self patternMiddle]];
          break;
        case SetCardPatternSymbolSquiggle:
          [self drawSquiggleAtPoint:[self patternMiddle]];
          break;
        case SetCardPatternSymbolOval:
          [self drawOvalAtPoint:[self patternMiddle]];
          break;
      }
      break;
    case 2:
      switch (self.symbol) {
        case SetCardPatternSymbolDiamond:
          [self drawDiamondAtPoint:[self twoPatternsPoint1]];
          [self drawDiamondAtPoint:[self twoPatternsPoint2]];
          break;
        case SetCardPatternSymbolSquiggle:
          [self drawSquiggleAtPoint:[self twoPatternsPoint1]];
          [self drawSquiggleAtPoint:[self twoPatternsPoint2]];
          break;
        case SetCardPatternSymbolOval:
          [self drawOvalAtPoint:[self twoPatternsPoint1]];
          [self drawOvalAtPoint:[self twoPatternsPoint2]];
          break;
      }
      break;
    case 3:
      switch (self.symbol) {
        case SetCardPatternSymbolDiamond:
          [self drawDiamondAtPoint:[self threePatternsPoint1]];
          [self drawDiamondAtPoint:[self threePatternsPoint2]];
          [self drawDiamondAtPoint:[self patternMiddle]];
          break;
        case SetCardPatternSymbolSquiggle:
          [self drawSquiggleAtPoint:[self threePatternsPoint1]];
          [self drawSquiggleAtPoint:[self threePatternsPoint2]];
          [self drawSquiggleAtPoint:[self patternMiddle]];
          break;
        case SetCardPatternSymbolOval:
          [self drawOvalAtPoint:[self threePatternsPoint1]];
          [self drawOvalAtPoint:[self threePatternsPoint2]];
          [self drawOvalAtPoint:[self patternMiddle]];
          break;
      }
      break;
  }
}

#define PATTERN_HEIGHT_PERCENTAGE 0.200
#define PATTERN_WIDTH_PERCENTAGE 0.700
#define PATTERN_LINE_WIDTH_PERCENTAGE 0.02
#define PATTERN_LINE_WIDTH PATTERN_LINE_WIDTH_PERCENTAGE * self.bounds.size.width

- (void)drawDiamondAtPoint:(CGPoint)point {
  UIBezierPath *diamond = [UIBezierPath bezierPath];
  
  [diamond moveToPoint:CGPointMake(point.x, point.y-PATTERN_HEIGHT_PERCENTAGE*self.bounds.size.height/2)];
  [diamond addLineToPoint:CGPointMake(point.x+PATTERN_WIDTH_PERCENTAGE*self.bounds.size.width/2, point.y)];
  [diamond addLineToPoint:CGPointMake(point.x, point.y+PATTERN_HEIGHT_PERCENTAGE*self.bounds.size.height/2)];
  [diamond addLineToPoint:CGPointMake(point.x-PATTERN_WIDTH_PERCENTAGE*self.bounds.size.width/2, point.y)];
  [diamond closePath];
  
  diamond.lineWidth = PATTERN_LINE_WIDTH;
  if (self.shading == SetCardPatternShadingOpen) {
    [[self patternColor] setStroke];
    [diamond stroke];
  } else if (self.shading == SetCardPatternShadingSolid) {
    [[self patternColor] setFill];
    [diamond fill];
  } else {
    [self fillStripeInPath:diamond];
    [[self patternColor] setStroke];
    [diamond stroke];
  }
}

#define SQIGGLE_WIDTH_FACTOR 0.090
#define SQUIGGLE_WIDTH SQIGGLE_WIDTH_FACTOR * self.bounds.size.width
- (void)drawSquiggleAtPoint:(CGPoint)point {
  UIBezierPath *squiggle = [UIBezierPath bezierPath];
  
  CGPoint curvePoint1 = CGPointMake(point.x-PATTERN_WIDTH_PERCENTAGE*self.bounds.size.width/2, point.y-SQUIGGLE_WIDTH);
  CGPoint curvePoint2 = CGPointMake(point.x+PATTERN_WIDTH_PERCENTAGE*self.bounds.size.width/2, point.y-SQUIGGLE_WIDTH);
  CGPoint curvePoint3 = CGPointMake(point.x+PATTERN_WIDTH_PERCENTAGE*self.bounds.size.width/2, point.y+SQUIGGLE_WIDTH);
  CGPoint curvePoint4 = CGPointMake(point.x-PATTERN_WIDTH_PERCENTAGE*self.bounds.size.width/2, point.y+SQUIGGLE_WIDTH);
  
  [squiggle moveToPoint:curvePoint1];
  [squiggle addCurveToPoint:curvePoint2
              controlPoint1:CGPointMake(point.x-PATTERN_WIDTH_PERCENTAGE*self.bounds.size.width/8, curvePoint1.y-PATTERN_HEIGHT_PERCENTAGE*self.bounds.size.height/5*4-SQUIGGLE_WIDTH/2)
              controlPoint2:CGPointMake(point.x+PATTERN_WIDTH_PERCENTAGE*self.bounds.size.width/8, curvePoint1.y+PATTERN_HEIGHT_PERCENTAGE*self.bounds.size.height/5*4-SQUIGGLE_WIDTH/2)];
  [squiggle addQuadCurveToPoint:curvePoint3 controlPoint:CGPointMake(curvePoint3.x+SQUIGGLE_WIDTH, curvePoint2.y+SQUIGGLE_WIDTH/4)];
  [squiggle addCurveToPoint:curvePoint4
              controlPoint1:CGPointMake(point.x+PATTERN_WIDTH_PERCENTAGE*self.bounds.size.width/8, curvePoint3.y+PATTERN_HEIGHT_PERCENTAGE*self.bounds.size.height/5*4-SQUIGGLE_WIDTH/2)
              controlPoint2:CGPointMake(point.x-PATTERN_WIDTH_PERCENTAGE*self.bounds.size.width/8, curvePoint3.y-PATTERN_HEIGHT_PERCENTAGE*self.bounds.size.height/5*4-SQUIGGLE_WIDTH/2)];
  [squiggle addQuadCurveToPoint:curvePoint1 controlPoint:CGPointMake(curvePoint1.x-SQUIGGLE_WIDTH, curvePoint4.y-SQUIGGLE_WIDTH/4)];
  [squiggle closePath];
  
  squiggle.lineWidth = PATTERN_LINE_WIDTH;
  if (self.shading == SetCardPatternShadingOpen) {
    [[self patternColor] setStroke];
    [squiggle stroke];
  } else if (self.shading == SetCardPatternShadingSolid) {
    [[self patternColor] setFill];
    [squiggle fill];
  } else {
    [self fillStripeInPath:squiggle];
    [[self patternColor] setStroke];
    [squiggle stroke];
  }
}

- (void)drawOvalAtPoint:(CGPoint)point {
  UIBezierPath *oval = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(point.x-PATTERN_WIDTH_PERCENTAGE*self.bounds.size.width/2,
                                                                          point.y-PATTERN_HEIGHT_PERCENTAGE*self.bounds.size.height/2,
                                                                          PATTERN_WIDTH_PERCENTAGE*self.bounds.size.width,
                                                                          PATTERN_HEIGHT_PERCENTAGE*self.bounds.size.height)
                                                  cornerRadius:PATTERN_HEIGHT_PERCENTAGE*self.bounds.size.height];

  oval.lineWidth = PATTERN_LINE_WIDTH;
  if (self.shading == SetCardPatternShadingOpen) {
    [[self patternColor] setStroke];
    [oval stroke];
  } else if (self.shading == SetCardPatternShadingSolid) {
    [[self patternColor] setFill];
    [oval fill];
  } else {
    [self fillStripeInPath:oval];
    [[self patternColor] setStroke];
    [oval stroke];
  }
}

#define PATTERN_STRIPE_SAPCE 2
- (void)fillStripeInPath:(UIBezierPath *)path {
  UIBezierPath *stripe = [UIBezierPath bezierPath];
  for (int stripeLocationX = self.bounds.origin.x; stripeLocationX < self.bounds.size.width; stripeLocationX+=PATTERN_STRIPE_SAPCE) {
    [stripe moveToPoint:CGPointMake(stripeLocationX, self.bounds.origin.y)];
    [stripe addLineToPoint:CGPointMake(stripeLocationX, self.bounds.size.height)];
    [stripe closePath];
  }
  [stripe appendPath:path];
  
  CGContextSaveGState(UIGraphicsGetCurrentContext());{
    [path addClip];
    [[self patternColor] setStroke];
    stripe.lineWidth = PATTERN_LINE_WIDTH / 2;
    [stripe stroke];
  } CGContextRestoreGState(UIGraphicsGetCurrentContext());
}

- (UIColor *)patternColor {
  NSArray *colors =  @[[UIColor redColor],
                       [UIColor yellowColor],
                       [UIColor blueColor],
                       [UIColor greenColor],
                       [UIColor orangeColor],
                       [UIColor purpleColor],
                       [UIColor grayColor],
                       [UIColor whiteColor],
                       [UIColor blackColor],
                       [UIColor brownColor],
                       [UIColor cyanColor]];
  return colors[self.color];
}

#pragma mark - Initialization
- (void)setup {
  [super setup];
}

#pragma mark - Getters & Setters

- (void)setNumber:(int)number {
  _number = number;
  [self setNeedsDisplay];
}

- (void)setSymbol:(SetCardPatternSymbol)symbol {
  _symbol = symbol;
  [self setNeedsDisplay];
}

- (void)setColor:(SetCardPatternColor)color {
  _color = color;
  [self setNeedsDisplay];
}

- (void)setShading:(SetCardPatternShading)shading {
  _shading = shading;
  [self setNeedsDisplay];
}


#define DEFAULT_FACE_CARD_SCALE_FACTOR 0.800
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
