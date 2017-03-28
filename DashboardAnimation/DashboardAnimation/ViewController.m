//
//  ViewController.m
//  DashboardAnimation
//
//  Created by gonghuiiOS on 17/3/28.
//  Copyright © 2017年 熊志华. All rights reserved.
//

#import "ViewController.h"
#import "DashBoardProgressView.h"
@interface ViewController ()
@property (nonatomic, strong) DashBoardProgressView *progress;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.progress = [[DashBoardProgressView alloc]initWithFrame:CGRectMake(20, 70, 280,280 )];
    self.progress.mainImageView.image = [UIImage imageNamed:@"backgroundImage@2x"];
    self.progress.percent = 0;
    [self.view addSubview:self.progress];
    
    
    
    UIButton *start = [UIButton buttonWithType:UIButtonTypeCustom];
    start.frame = CGRectMake(40, 400, 240, 40);
    [start setTitle:@"start" forState:UIControlStateNormal];
    [start addTarget:self action:@selector(start:) forControlEvents:UIControlEventTouchUpInside];
    start.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:start];
    
}

- (void)start:(UIButton *)btn{
    self.progress.percent = 90.0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
