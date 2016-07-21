//
//  UIView+WaterWave.m
//  AnimationSet
//
//  Created by gonghuiiOS on 16/7/20.
//  Copyright © 2016年 熊志华. All rights reserved.
//

#import "UIView+WaterWave.h"
#import "objc/runtime.h"

static const void *imageURLKey = &imageURLKey;
//static const void *waveUp = &waveUp;
//static const void *waveCurve = &waveCurve;
static const void *waveSpeed = &waveSpeed;


static BOOL waveUp = NO;//全局变量
static CGFloat waveCurve = NO;

@implementation UIView (WaterWave)

- (NSString *)imageURL {
    return objc_getAssociatedObject(self, imageURLKey);
}
- (void)setImageURL:(NSString *)imageURL {
    objc_setAssociatedObject(self, imageURLKey, imageURL, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


- (void)waterWaveAnimateWithDepth:(CGFloat)depth {
    // 每次0.05秒执行一次动画
    [NSTimer scheduledTimerWithTimeInterval:.05 target:self selector:@selector(waveAnimate) userInfo:nil repeats:YES];
}
- (void)waveAnimate {
    
}
@end
