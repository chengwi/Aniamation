//
//  TestView.m
//  AnimationSet
//
//  Created by gonghuiiOS on 16/7/21.
//  Copyright © 2016年 熊志华. All rights reserved.
//

#import "TestView.h"

@implementation TestView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchAction)];
        self.userInteractionEnabled = YES;
        [self addGestureRecognizer:tap];
    }
    return self;
}
- (void)touchAction {
    if (self.agreeBlock) {
        self.agreeBlock();
    }
}
- (void)showInView:(UIView *)view {
    
    [view addSubview:self];
    
    
}

- (void)hidenView {
    [self removeFromSuperview];
}


- (void)dealloc {
    
    
}

@end
