//
//  LvNormalSlider.h
//  EnjoySelf
//
//  Created by guangbo on 14-10-16.
//  Copyright (c) 2014年 光波 彭. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  自定义直线slider
 */
@interface LvNormalSlider : UIControl

/**
 *  value between 0.0 and 1.0
 */
@property (nonatomic) CGFloat value;

@property (nonatomic) UIColor *trackColor;
@property (nonatomic) UIColor *sliderBackgroundColor;

/**
 *  线宽
 */
@property (nonatomic) CGFloat sliderLineWidth;

/**
 *  手柄大小
 */
@property (nonatomic) CGFloat handleSize;
/**
 *  手柄阴影大小
 */
@property (nonatomic) CGFloat handleShadowSize;

@end
