//
//  SetCardView.h
//  Matchismo
//
//  Created by Lmz on 2018/1/24.
//  Copyright © 2018年 CS193p. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SetCardConstant.h"
#import "CardView.h"

@interface SetCardView : CardView

@property (nonatomic, assign) int number;
@property (nonatomic, assign) SetCardPatternSymbol symbol;
@property (nonatomic, assign) SetCardPatternShading shading;
@property (nonatomic, assign) SetCardPatternColor color;

@end
