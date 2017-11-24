//
//  KSSBarChart.m
//  KSingleBarChart
//
//  Created by tenghu on 2017/11/24.
//  Copyright © 2017年 tenghu. All rights reserved.
//

#import "KSSBarChart.h"
#import "KSSBar.h"

@implementation KSSBarChart

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        
    }
    return self;
}
-(void)show{
    
    [self setNeedsDisplay];
    
    CGFloat groupWidth = 3;
    CGFloat barHeight = self.bounds.size.height - _chartMargin.top - _chartMargin.bottom;
    CGFloat barWidth = 5;
    
    NSInteger aa = _yValues.count;
    for (int i = 0; i < aa; i ++) {
        
        CGFloat bar_x = _chartMargin.left + i*(groupWidth+59);
        KSSBar *bar = [[KSSBar alloc]initWithFrame:CGRectMake(bar_x, _chartMargin.top, barWidth, barHeight)];
        
        NSString *yValue = _yValues[i];
        bar.barProgress = yValue.floatValue/_yMaxNum;
        bar.barColor = _storkColor;
        bar.barText = yValue;
        [self addSubview:bar];
        
    }
}

- (void)drawRect:(CGRect)rect {
    
    [super drawRect:rect];
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGFloat xLabelWidth = 59;
    CGFloat xLabelHeight = 20;
    UIFont  *font = [UIFont systemFontOfSize:11];//设置
    //比例
    [_yValues enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CGRect rect = CGRectMake( idx*(xLabelWidth+3), self.bounds.size.height-_chartMargin.bottom+3, xLabelWidth, xLabelHeight);
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(2, 2)];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.path = maskPath.CGPath;
        maskLayer.fillColor = [UIColor colorWithWhite:1 alpha:0.04].CGColor;
        [self.layer addSublayer:maskLayer];
        
        NSString *string = @"";
        CGFloat pp = [obj floatValue] / _totalNum;
        NSString *st = [NSString stringWithFormat:@"%.1f%%",pp*100];
        if ([st containsString:@".0"]) {
            NSArray *arr = [st componentsSeparatedByString:@"."];
            string = [NSString stringWithFormat:@"%@%%",arr[0]];
        }else{
            string = st;
        }
        CGRect rect2 = CGRectMake( idx*(xLabelWidth+3), self.bounds.size.height-_chartMargin.bottom+6, xLabelWidth, xLabelHeight);
        NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
        style.lineBreakMode = NSLineBreakByWordWrapping;
        style.alignment = NSTextAlignmentCenter;
        [string drawWithRect:rect2 options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font, NSParagraphStyleAttributeName:style, NSForegroundColorAttributeName:[UIColor blueColor]} context:nil];
        
    }];
    //x轴数据
    [_xLabels enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CGRect rect = CGRectMake( idx*(xLabelWidth+3), self.bounds.size.height-_chartMargin.bottom+25, xLabelWidth, xLabelHeight);
        NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
        style.lineBreakMode = NSLineBreakByWordWrapping;
        style.alignment = NSTextAlignmentCenter;
        [obj drawWithRect:rect options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font, NSParagraphStyleAttributeName:style, NSForegroundColorAttributeName:[UIColor whiteColor]} context:nil];
        
    }];
    
    CGContextSetLineWidth(context, 0.5);
    CGContextSetStrokeColorWithColor(context, [UIColor grayColor].CGColor); //设置线的颜色为灰色
    
    CGFloat heighty = (self.bounds.size.height - _chartMargin.top - _chartMargin.bottom)/4;
    for (int i = 1; i < 5; i ++) {
        CGContextMoveToPoint(context, 0, (self.bounds.size.height-_chartMargin.bottom+2)-i*heighty); //设置线的起始点
        CGContextAddLineToPoint(context, self.bounds.size.width-_chartMargin.right, (self.bounds.size.height-_chartMargin.bottom+2)-i*heighty); //设置线中间的一个点
        CGContextStrokePath(context);//直接把所有的点连起来
    }
    
    //y轴虚线
    CGContextSetLineWidth(context, 2);
    CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:128/255.0 green:128/255.0 blue:128/255.0 alpha:1].CGColor);
    CGFloat lengths[] = {0.2,5};
    CGContextSetLineDash(context, 0, lengths,2);
    CGContextMoveToPoint(context, 0, 0); //设置线的起始点
    CGContextAddLineToPoint(context, 0, self.bounds.size.height-_chartMargin.bottom); //设置线中间的一个点
    CGContextStrokePath(context);//直接把所有的点连起来
    
    
}


@end
