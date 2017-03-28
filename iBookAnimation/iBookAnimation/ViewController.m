//
//  ViewController.m
//  Demo
//
//  Created by canye on 16/6/15.
//  Copyright © 2016年 jingyu. All rights reserved.
//

#import "ViewController.h"
#import "BookCollectionViewCell.h"
#import "ReadViewController.h"
static NSString *const bookIdetifier = @"cell";
#define SCREENWIDTH [UIScreen mainScreen].bounds.size.width
#define SCREENHEIGHT [UIScreen mainScreen].bounds.size.height
@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UINavigationControllerDelegate>
@property (strong, nonatomic) UICollectionViewFlowLayout *flowLayout;

@end

@implementation ViewController

-(UICollectionViewFlowLayout *)flowLayout{
    if (!_flowLayout) {
        _flowLayout = [[UICollectionViewFlowLayout alloc]init];
        _flowLayout.itemSize = CGSizeMake((SCREENWIDTH - 20) / 3 - 20, 90);
        _flowLayout.minimumLineSpacing = 15;
        _flowLayout.minimumInteritemSpacing = 10;
    }
    return _flowLayout;
}
-(UICollectionView *)collectionView{
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(10, 0, (SCREENWIDTH - 20), SCREENHEIGHT) collectionViewLayout:self.flowLayout];
        _collectionView.delegate = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.dataSource = self;
        _collectionView.dataSource = self;
        [_collectionView registerNib:[UINib nibWithNibName:@"BookCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:bookIdetifier];
        _collectionView.showsVerticalScrollIndicator = NO;
    }
    return _collectionView;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear: animated];
    self.navigationController.delegate = self;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.collectionView];
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return 20;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    BookCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:bookIdetifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor redColor];
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    ReadViewController *read = [ReadViewController new];
    self.navigationController.delegate = read;
    self.bookCell = (BookCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    [self.navigationController pushViewController:read animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
