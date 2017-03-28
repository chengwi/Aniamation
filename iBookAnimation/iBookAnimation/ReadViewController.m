//
//  ReadViewController.m
//  Demo
//
//  Created by canye on 16/6/15.
//  Copyright © 2016年 jingyu. All rights reserved.
//

#import "ReadViewController.h"
#import "TranitionAniamation.h"
@interface ReadViewController ()

@end

@implementation ReadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"冰与火之歌";
    
    self.imageView = [[UIImageView alloc]initWithFrame:self.view.frame];
    self.imageView.image = [UIImage imageNamed:@"002.jpg"];
    [self.view addSubview:self.imageView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

//此方法会先于viewDidLoad方法调用，所有在viewDidLoad方法里设置self.navigationController.delegate = self是无效的。
- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                  animationControllerForOperation:(UINavigationControllerOperation)operation
                                               fromViewController:(UIViewController *)fromVC
                                                 toViewController:(UIViewController *)toVC
{
    
    return [TranitionAniamation transitionWithType:operation==UINavigationControllerOperationPush?PageTransitionTypePush:PageTransitionTypePop];
}

@end
