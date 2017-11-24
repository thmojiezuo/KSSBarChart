//
//  KSSBar.h
//  KSingleBarChart
//
//  Created by tenghu on 2017/11/24.
//  Copyright © 2017年 tenghu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KSSBar : UIView

@property (nonatomic, assign)float barProgress;//柱子长度 0-1之间
@property (nonatomic, strong)UIColor *barColor;//柱的颜色
@property (nonatomic, copy)NSString *barText;//数值

@end
