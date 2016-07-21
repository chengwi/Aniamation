//
//  WaterWaveViewController.m
//  AnimationSet
//
//  Created by gonghuiiOS on 16/7/20.
//  Copyright © 2016年 熊志华. All rights reserved.
//

#import "WaterWaveViewController.h"
#import "XZHWaterWave.h"

#define kSCREEN_HEIGHT [[UIScreen mainScreen]bounds].size.height
#define kSCREEN_WIDTH [[UIScreen mainScreen]bounds].size.width



@interface WaterWaveViewController ()<XZHWaterWaveDelegate>
/** 白色图片 */
@property (nonatomic, weak  ) UIImageView *pic_white;
/** 红色图片 */
@property (nonatomic, weak  ) UIImageView *pic_red;
/** 水波工具 */
@property (nonatomic, strong) XZHWaterWave *waterWave;
@end

@implementation WaterWaveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"水波荡漾";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self pic_white];
    [self pic_red];
    [self waterWave];
    self.waterWave.waterDepth = 0.5;
    
    // Do any additional setup after loading the view.
}

#pragma mark - ========================CFWaterWave Delegate========================
- (void)waterWave:(XZHWaterWave *)waterWave wavePath:(UIBezierPath *)path {
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.path = path.CGPath;
    self.pic_red.layer.mask = maskLayer;
}

#pragma mark - ========================Getter Setter========================
- (XZHWaterWave *)waterWave {
    if (_waterWave == nil) {
        CGRect frame = CGRectMake(self.pic_red.frame.origin.x, self.pic_red.frame.origin.y, self.pic_red.frame.size.width, self.pic_red.frame.size.height);
        _waterWave = [[XZHWaterWave alloc] initWithFrame:frame];
        _waterWave.delegate = self;
    }
    return _waterWave;
}

- (UIImageView *)pic_white {
    if (_pic_white == nil) {
        UIImageView *pic_white = [[UIImageView alloc] init];
        pic_white.frame        = CGRectMake((kSCREEN_WIDTH - 150) / 2, (kSCREEN_HEIGHT - 150) / 2, 150, 150);
        pic_white.image        = [UIImage imageNamed:@"pic_white"];
        pic_white.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:pic_white];
        _pic_white             = pic_white;
    }
    return _pic_white;
}

- (UIImageView *)pic_red {
    if (_pic_red == nil) {
        UIImageView *pic_red = [[UIImageView alloc] init];
        pic_red.frame        = self.pic_white.frame;
        pic_red.image        = [UIImage imageNamed:@"pic_red"];
        pic_red.backgroundColor = [UIColor blueColor];
        [self.view addSubview:pic_red];
        _pic_red             = pic_red;
    }
    return _pic_red;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
