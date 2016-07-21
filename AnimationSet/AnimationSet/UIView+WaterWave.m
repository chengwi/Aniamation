//
//  UIView+WaterWave.m
//  AnimationSet
//
//  Created by gonghuiiOS on 16/7/20.
//  Copyright © 2016年 熊志华. All rights reserved.
//

#import "UIView+WaterWave.h"
#import "objc/runtime.h"


static const void *timer = &timer;

static BOOL waveUp = NO;//全局变量
static CGFloat waveCurve = 1.5;
static CGFloat waveSpeed = 0;
static CGFloat waterDepth = 0;
@implementation UIView (WaterWave)

- (NSTimer *)timer {
    return objc_getAssociatedObject(self, timer);
}
- (void)setTimer:(NSTimer *)imageURL {
    objc_setAssociatedObject(self, timer, imageURL, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)waterWaveAnimateWithDepth:(CGFloat)depth {
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
    waterDepth = depth;
    waveSpeed = 0;
    waveCurve = 1.5;
    waveUp = NO;
    // 每次0.05秒执行一次动画
    self.timer = [NSTimer scheduledTimerWithTimeInterval:.05 target:self selector:@selector(waveAnimate) userInfo:nil repeats:YES];
}
- (void)waveAnimate {
    waveCurve += waveUp? 0.01f : -0.01f;
    if (waveCurve <= 1.f) {
        waveUp = YES;
    }else if (waveCurve >= 1.5f){
        waveUp = NO;
    }
    waveSpeed += 0.1f;
    
    [self createPath];
}
/**
 *  创建path回调给代理
 */
- (void)createPath {
    UIBezierPath * path = [[UIBezierPath alloc] init];
    CGFloat  waterDepthY = (1 - (waterDepth > 1.f? 1.f : waterDepth)) * self.frame.size.height;
    CGFloat y = waterDepthY;
    [path moveToPoint:CGPointMake(0, y)];
    path.lineWidth = 1;
    
    for (CGFloat x = 0; x <= self.frame.size.width; x++) {
        y = waveCurve * sin(x/180*M_PI + 4* waveSpeed/M_PI) * 5 + waterDepthY;
        [path addLineToPoint:CGPointMake(x, y)];
    }
    [path addLineToPoint:CGPointMake(self.frame.size.width, y)];
    [path addLineToPoint:CGPointMake(self.frame.size.width, self.frame.size.height)];
    [path addLineToPoint:CGPointMake(0, self.frame.size.height)];
    [path closePath];
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.path = path.CGPath;
    self.layer.mask = maskLayer;
    

}

- (void)stopWave {
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
}

@end
