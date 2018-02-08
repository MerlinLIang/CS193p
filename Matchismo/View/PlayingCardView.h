//
//  PlayingCardView.h
//  SuperCard
//
//  Created by Lmz on 2018/1/7.
//  Copyright © 2018年 Lmz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CardView.h"

@interface PlayingCardView : CardView

@property (nonatomic, assign) NSUInteger rank;
@property (nonatomic, strong) NSString *suit;
@property (nonatomic, assign) BOOL faceUp;

- (void)pinch:(UIPinchGestureRecognizer *)gesture;

@end
