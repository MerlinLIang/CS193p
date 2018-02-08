//
//  CardView.h
//  Matchismo
//
//  Created by Lmz on 2018/1/24.
//  Copyright © 2018年 CS193p. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CardView : UIView

@property (nonatomic, assign) BOOL isChoosed;

- (CGFloat)cornerScaleFactor;
- (CGFloat)cornerRadius;
- (void)setup;

@end
