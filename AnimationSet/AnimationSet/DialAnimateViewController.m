//
//  DialAnimateViewController.m
//  AnimationSet
//
//  Created by gonghuiiOS on 16/7/20.
//  Copyright © 2016年 熊志华. All rights reserved.
//

#import "DialAnimateViewController.h"
#import "XZHWaterWave.h"
#import "TestView.h"
@interface DialAnimateViewController ()
@property (nonatomic, strong) XZHWaterWave *water;
@end

@implementation DialAnimateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    TestView *view = [[TestView alloc] initWithFrame:CGRectMake(50, 100, 100, 100)];
    view.backgroundColor = [UIColor redColor];
    [self.view addSubview:view];
    __weak DialAnimateViewController *myself = self;
    view.agreeBlock = ^(){
        myself.water = [[XZHWaterWave alloc] init];
        NSLog(@"点击率");
    };
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)dealloc {


}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
