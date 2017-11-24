//
//  ViewController.m
//  KSingleBarChart
//
//  Created by tenghu on 2017/11/10.
//  Copyright © 2017年 tenghu. All rights reserved.
//

#import "ViewController.h"
#import "KSSBarChart.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width

@interface ViewController ()

@property (nonatomic, strong) KSSBarChart *chartView;
@property (nonatomic ,strong)UIScrollView *scroller;  //柱状图的

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.view.backgroundColor = [UIColor blackColor];
    
    NSArray *yValues = @[@"10",@"5",@"0",@"5",@"10",@"5",@"0",@"5",@"10",@"5"];
    NSArray *xLabels = @[@"百度竞价",@"360竞价",@"搜狗竞价",@"微博",@"陌陌",@"爱奇艺",@"加微信",@"QQ",@"渠道1",@"渠道2"];
    
    _scroller= [[UIScrollView alloc]initWithFrame:CGRectMake(0, 70,  SCREEN_WIDTH , 180)];
    _scroller.showsHorizontalScrollIndicator = YES;
    _scroller.contentSize = CGSizeMake(yValues.count*62+20, 0);
    _scroller.indicatorStyle=UIScrollViewIndicatorStyleWhite;
    [self.view addSubview:_scroller];
    
    
    _chartView = [[KSSBarChart alloc] initWithFrame:CGRectMake(0, 0, yValues.count*62+10, 180)];
    _chartView.xLabels = xLabels;
    _chartView.yValues = yValues;
    _chartView.yMaxNum = 10;
    _chartView.totalNum = 55;
    _chartView.storkColor = [UIColor redColor];
    _chartView.chartMargin = UIEdgeInsetsMake(20, 27, 50, 0);// 上左下右
    [_scroller addSubview:_chartView];
    [_chartView show];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
