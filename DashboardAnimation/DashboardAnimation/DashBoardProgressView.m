//
//  DashBoardProgressView.m
//  DashboardAnimation
//
//  Created by gonghuiiOS on 17/3/28.
//  Copyright © 2017年 熊志华. All rights reserved.
//

#import "DashBoardProgressView.h"
#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define DEGREES_TO_RADIANS(angle) (M_PI*(angle)/180.0) //把角度转换成弧度
#define RGB(r, g, b) [UIColor colorWithRed:(r)/255.f green:(g)/255.f blue:(b)/255.f alpha:1.f]


@interface DashBoardProgressView ()

@property (nonatomic, strong) CAShapeLayer *bottomShapeLayer;
@property (nonatomic, strong) CAShapeLayer *progressLayer;
@property (nonatomic, strong) CAGradientLayer *gradientLayer; // 渐变进度条
@property (nonatomic, strong) UIView *markerView; // 光标

@property (nonatomic ,assign) CGFloat radius;
@property (nonatomic, assign) CGFloat lineWidth; // 弧线宽度
@property (nonatomic, assign) CGFloat stareAngle; // 开始角度
@property (nonatomic, assign) CGFloat endAngle; // 结束角度
@end


@implementation DashBoardProgressView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.radius = self.frame.size.width - 10;
        self.stareAngle = -200;
        self.endAngle = 20;
        self.lineWidth = 2;
        [self drawCicre];
        
    }
    
    return self;
}

-(UIImageView *)mainImageView{
    if (_mainImageView == nil) {
        _mainImageView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, self.radius,  self.radius * 2 / 3)];
        [self addSubview:_mainImageView];
    }
    return _mainImageView;
}

-(void)drawCicre{
    //绘制底线
    CGPoint circleCenter = CGPointMake(self.frame.size.width / 2, self.frame.size.width / 2);
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:circleCenter radius:self.radius / 2 startAngle:DEGREES_TO_RADIANS(self.stareAngle) endAngle:DEGREES_TO_RADIANS(self.endAngle) clockwise:YES];
    self.bottomShapeLayer = [CAShapeLayer layer];
    self.bottomShapeLayer.fillColor = [[UIColor clearColor] CGColor];
    self.bottomShapeLayer.strokeColor = [[UIColor  colorWithRed:206.f / 256.f green:241.f / 256.f blue:227.f alpha:1.f] CGColor];
    self.bottomShapeLayer.opacity = 1;
    self.bottomShapeLayer.lineCap = kCALineCapRound;
    self.bottomShapeLayer.lineWidth = self.lineWidth;
    self.bottomShapeLayer.path = [path CGPath];
    [self.layer addSublayer:self.bottomShapeLayer];
    
    //绘制渐变线
    self.progressLayer = [CAShapeLayer layer];
    self.progressLayer.fillColor =  [[UIColor clearColor] CGColor];
    self.progressLayer.strokeColor  = [[UIColor whiteColor] CGColor];
    self.progressLayer.lineCap = kCALineCapRound;
    self.progressLayer.lineWidth = self.lineWidth;
    self.progressLayer.path = [path CGPath];
    self.progressLayer.strokeEnd = 0;
    [self.bottomShapeLayer setMask:self.progressLayer];
    
    self.gradientLayer = [CAGradientLayer layer];
    self.gradientLayer.frame = self.bounds;
    [self.gradientLayer setColors:[NSArray arrayWithObjects:
                                   (id)[RGB(255, 99, 71) CGColor],
                                   (id)[RGB(255, 236, 139) CGColor],
                                   (id)[RGB(238, 238, 0) CGColor],
                                   (id)[RGB(127, 255, 0) CGColor],
                                   nil]];
    [self.gradientLayer setLocations:@[@0.2, @0.5, @0.7, @1]];
    [self.gradientLayer setStartPoint:CGPointMake(0, 0)];
    [self.gradientLayer setEndPoint:CGPointMake(1, 0)];
    [self.gradientLayer setMask:self.progressLayer];
    [self.layer addSublayer:self.gradientLayer];
    [self animationWithStartAngle:DEGREES_TO_RADIANS(self.stareAngle)
                         endAngle:DEGREES_TO_RADIANS(self.stareAngle + 220 * 0)];
    
}
- (void)animationWithStartAngle:(CGFloat)startAngle endAngle:(CGFloat)endAngle {
    
    // 前面移动光标的关键帧动画
    CAKeyframeAnimation *pathAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    pathAnimation.calculationMode = kCAAnimationPaced;
    pathAnimation.fillMode = kCAFillModeForwards;
    pathAnimation.removedOnCompletion = NO;
    pathAnimation.duration = 2;
    pathAnimation.repeatCount = 1;
    
    // 设置动画路径
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddArc(path, NULL, self.frame.size.width / 2, self.frame.size.height / 2, (self.radius - 4 / 2) / 2, startAngle, endAngle, 0);
    pathAnimation.path = path;
    CGPathRelease(path);
    
    self.markerView.frame = CGRectMake(-100, self.frame.size.height, 6, 6);
    self.markerView.layer.cornerRadius = 3;
    
    [self.markerView.layer addAnimation:pathAnimation forKey:@"move"];
}
//线条移动的动画
- (void)circleAnimation {
    
    [CATransaction begin];
    [CATransaction setDisableActions:NO];
    [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]];
    [CATransaction setAnimationDuration:0];
    self.progressLayer.strokeEnd = 0;
    [CATransaction commit];
    
    [CATransaction begin];
    [CATransaction setDisableActions:NO];
    [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]];
    [CATransaction setAnimationDuration:2];
    self.progressLayer.strokeEnd = _percent / 100.0;
    [CATransaction commit];
    
}
- (void)setPercent:(CGFloat)percent {
    _percent = percent;
    [self setPercent:percent animated:YES];
}

- (void)setPercent:(CGFloat)percent animated:(BOOL)animated {
    
    [NSTimer scheduledTimerWithTimeInterval:0 target:self selector:@selector(circleAnimation) userInfo:nil repeats:NO];
    
    [self animationWithStartAngle:DEGREES_TO_RADIANS(self.stareAngle)
                         endAngle:DEGREES_TO_RADIANS(self.stareAngle + 220 * percent / 100)];
}

- (UIView *)markerView {
    
    if (nil == _markerView) {
        _markerView = [[UIView alloc] init];
        _markerView.backgroundColor = RGB(32, 178, 170);
        _markerView.alpha = 0.7;
        _markerView.layer.shadowColor = RGB(32, 178, 170).CGColor;
        _markerView.layer.shadowOffset = CGSizeMake(0, 0);
        _markerView.layer.shadowRadius = 3.f;
        _markerView.layer.shadowOpacity = 1;
        [self addSubview:_markerView];
    }
    return _markerView;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
