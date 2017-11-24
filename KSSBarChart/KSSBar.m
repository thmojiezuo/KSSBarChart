//
//  KSSBar.m
//  KSingleBarChart
//
//  Created by tenghu on 2017/11/24.
//  Copyright © 2017年 tenghu. All rights reserved.
//

#import "KSSBar.h"

#define XLabelFontSize 10
#define BarTextFont  9
#define BarAnimationDuration 1.0
#define TextAnimationDuration 2.0

static CABasicAnimation* fadeAnimation(){
    CABasicAnimation* fadeAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    fadeAnimation.fromValue = [NSNumber numberWithFloat:0.0];
    fadeAnimation.toValue = [NSNumber numberWithFloat:1.0];
    fadeAnimation.duration = TextAnimationDuration;
    return fadeAnimation;
}
@interface KSSBar ()

@property (nonatomic, strong)CAShapeLayer *barLayer; //柱状层
@property (nonatomic, strong)UIBezierPath *barPath; //柱状赛贝尔路径
@property (nonatomic, strong)CATextLayer *textLayer; //数值文字显示层

@end

@implementation KSSBar

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
        
        _barLayer = [CAShapeLayer new];
        
        [self.layer addSublayer:_barLayer];
        
        _barLayer.lineCap = kCALineCapRound;
        
        _barLayer.frame = self.bounds;
        
        
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    
    _textLayer.position = CGPointMake(self.bounds.size.width/2 , self.bounds.size.height*(1-_barProgress)-9);
    
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation.duration = BarAnimationDuration;
    pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    pathAnimation.fromValue = @0.0f;
    pathAnimation.toValue = @1.0f;
    [_barLayer addAnimation:pathAnimation forKey:nil];
    
    if (_textLayer) {
        CABasicAnimation *fade = fadeAnimation();
        [self.textLayer addAnimation:fade forKey:nil];
    }
    
}

// 设置百分百（显示动画）
- (void)setProgress{
    
    if (_barProgress == 0.0) {
        return;
    }
    
    _barPath = [UIBezierPath bezierPath];
    [_barPath setLineWidth:5];
    _barLayer.lineWidth = 5;
    [_barPath setLineCapStyle:kCGLineCapSquare];
    _barLayer.strokeEnd = 1.0;
    [_barPath moveToPoint:CGPointMake(self.bounds.origin.x+self.bounds.size.width/2, self.bounds.size.height)];
    [_barPath addLineToPoint:CGPointMake(self.bounds.origin.x+self.bounds.size.width/2, (self.bounds.size.height)*(1-_barProgress)+5)];
    
    _barLayer.path = _barPath.CGPath;
    
    
}



//设置柱子颜色
- (void)setBarColor:(UIColor *)barColor{
    _barColor = barColor;
    _barLayer.strokeColor = barColor.CGColor;
    _barLayer.fillColor = barColor.CGColor;
}


//设置柱子进度
- (void)setBarProgress:(float)progress{
    _barProgress = progress;
    [self setProgress];
}

- (CATextLayer *)textLayer{
    if (!_textLayer) {
        _textLayer = [CATextLayer layer];
        
        _textLayer.foregroundColor = _barColor.CGColor;
        _textLayer.fontSize = 7.5;
        _textLayer.alignmentMode = kCAAlignmentCenter;
        _textLayer.contentsScale = [[UIScreen mainScreen] scale];
        CGRect bounds = _barLayer.bounds;
        bounds.size.height = BarTextFont;
        bounds.size.width *= 4.5;
        _textLayer.bounds = bounds;
        
        [_textLayer setMasksToBounds:YES];
        [_textLayer setBorderColor:_barLayer.strokeColor];
        [_textLayer setBorderWidth:0.5];
        [_textLayer setCornerRadius:2];
        
        [self.layer addSublayer:_textLayer];
        
        
    }
    return _textLayer;
}


//设置数值
- (void)setBarText:(NSString*)text{
    self.textLayer.string = text;
}

-(void)dealloc{
    
    
    _barLayer = nil; //柱状层
    _barPath = nil; //柱状赛贝尔路径
    _textLayer = nil; //数值文字显示层
    
    
}



@end
