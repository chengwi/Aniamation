//
//  TranitionAniamation.m
//  Demo
//
//  Created by jingyu on 16/6/16.
//  Copyright © 2016年 jingyu. All rights reserved.
//

#import "TranitionAniamation.h"
#import "ViewController.h"
#import "BookCollectionViewCell.h"
#import "ReadViewController.h"

@interface TranitionAniamation ()
@property (assign, nonatomic) CGRect originRect;
@property(strong,nonatomic) id<UIViewControllerContextTransitioning> transitionContext;
@end


@implementation TranitionAniamation

+ (instancetype)transitionWithType:(PageTransitionType)type{
    return [[self alloc]initWithTransitionType:type];
}
- (instancetype)initWithTransitionType:(PageTransitionType)type{
    self = [super init];
    if (self) {
        _type = type;
    }
    return self;
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return 2;
}
//这儿是转场动画代理
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    self.transitionContext = transitionContext;
    switch (_type) {
        case PageTransitionTypePush:
            [self doPushAnimation:transitionContext];
            break;
            
        case PageTransitionTypePop:
            [self doPopAnimation:transitionContext];
            break;
    }
}


//push
- (void)doPushAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
    //这是转场动画将要跳转到的VC
    ReadViewController *toViewController = (ReadViewController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    //这儿是专场动画开始跳的那个vc
    ViewController *fromViewController = (ViewController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    //这个是选中的cell
    BookCollectionViewCell *currentCell =  fromViewController.bookCell;
    
    UIView *containerView = [transitionContext containerView];
    //创建临时视图以过渡
    UIView *tempView = [currentCell.imageView snapshotViewAfterScreenUpdates:NO];
    tempView.tag = 1001;
    //得到在新视图的位置 确保位置不会发生变化
    _originRect = [currentCell.imageView convertRect:currentCell.imageView.bounds toView: containerView];
     tempView.frame = _originRect;
    
    [containerView addSubview:toViewController.view];
    [containerView addSubview:tempView];
    toViewController.view.hidden = YES;

// 动画开始
    [UIView animateWithDuration:1.0 animations:^{
        tempView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        
    } completion:^(BOOL finished) {
        //设置其绕y轴旋转
        //动画
        fromViewController.view.hidden = YES;
        toViewController.view.hidden = NO;
        tempView.layer.anchorPoint = CGPointMake(0, 0.5);
        tempView.frame = CGRectMake(0, 0, tempView.frame.size.width, tempView.frame.size.height);
        CABasicAnimation *animation;
        animation=[CABasicAnimation animationWithKeyPath:@"transform.rotation.y"];
        animation.duration= 1.0;
        animation.delegate = self;
        animation.removedOnCompletion = YES;
        animation.fromValue = [NSNumber numberWithFloat:0];
        animation.toValue = [NSNumber numberWithFloat:-M_PI_2];
        [tempView.layer addAnimation:animation forKey:@"animateTransform"];
        
    }];
}

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
  //动画结束的回调
    [_transitionContext completeTransition:![_transitionContext transitionWasCancelled]];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.9 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [_transitionContext completeTransition:YES];
        UIView *tempView = [[_transitionContext containerView] viewWithTag:1001];
        tempView .hidden = YES;
    });
    
    /**
     *  
     id<UIViewControllerContextTransitioning> transitionContext = [anim valueForKey:@"transitionContext"];
     [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
     if ([transitionContext transitionWasCancelled]) {
     [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey].view.layer.mask = nil;
     }
     *
     *  @return <#return value description#>
     */
}

//pop
- (void)doPopAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
    ViewController* toViewController = (ViewController* )[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    ReadViewController* fromViewController = (ReadViewController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    UIView *containerView = [transitionContext containerView];
    
    [containerView addSubview:fromViewController.view];
    [containerView addSubview:toViewController.view];
    toViewController.view.hidden = YES;
    //获取临时视图
    UIView *showView = [containerView viewWithTag:1001];
    showView.hidden = NO;
    showView.alpha = 1;
    showView.layer.anchorPoint = CGPointMake(0, 0.5f);
    showView.frame = CGRectMake(0, 0, showView.frame.size.width, showView.frame.size.height);
    [containerView addSubview:showView];
    
    CABasicAnimation *animation;
    animation=[CABasicAnimation animationWithKeyPath:@"transform.rotation.y"];
    animation.duration= 1.0;
    animation.removedOnCompletion = YES;
    animation.fromValue = [NSNumber numberWithFloat:-M_PI_2];
    animation.toValue = [NSNumber numberWithFloat:0];
    [showView.layer addAnimation:animation forKey:@"animateTransform"];
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.9 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.5f animations:^{
            [toViewController.collectionView setContentSize:CGSizeMake(0, 0)];
            showView.frame = CGRectMake(10, 64, toViewController.bookCell.frame.size.width, toViewController.bookCell.frame.size.height);
//            showView.frame = currentCell.frame;
           NSLog(@"%f%f%f%f",_originRect.origin.x,_originRect.origin.y,_originRect.size.width,_originRect.size.height);
             [transitionContext completeTransition:YES];
        } completion:^(BOOL finished) {
            [showView removeFromSuperview];
            toViewController.view.hidden = NO;
        }];
    });
}

@end
