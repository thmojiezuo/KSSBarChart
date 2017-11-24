//
//  KSSBarChart.h
//  KSingleBarChart
//
//  Created by tenghu on 2017/11/24.
//  Copyright © 2017年 tenghu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KSSBarChart : UIView

@property (nonatomic, assign)UIEdgeInsets chartMargin;
@property (nonatomic,assign)CGFloat yMaxNum;//y 轴最大值
@property (nonatomic,assign)NSInteger totalNum; //总和
@property (nonatomic, strong)NSArray<NSString *> *xLabels;
@property (nonatomic, strong)NSArray<NSString *> *yValues;
@property (nonatomic, strong)UIColor *storkColor;

- (void)show;//显示柱状图

@end
