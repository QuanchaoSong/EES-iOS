//
//  HomeFunctionModulesVC.m
//  EES
//
//  Created by Albus on 19/11/2019.
//  Copyright © 2019 Zivos. All rights reserved.
//

#import "HomeFunctionModulesVC.h"
#import "HomeFunctionModuleCell.h"

@interface HomeFunctionModulesVC () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *clv;

@end

@implementation HomeFunctionModulesVC

- (instancetype)init {
    self = [super init];
    if (self) {
        self.title = @"设备管理(EES)";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.clv = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    self.clv.clipsToBounds = YES;
    self.clv.backgroundColor = [UIColor clearColor];
    self.clv.delaysContentTouches = NO;
    self.clv.alwaysBounceVertical = YES;
    self.clv.showsHorizontalScrollIndicator = NO;
    self.clv.delegate = self;
    self.clv.dataSource = self;
    [self.clv registerClass:[HomeFunctionModuleCell class] forCellWithReuseIdentifier:HomeFunctionModuleCell.cellIdentifier];
    [self.view addSubview:self.clv];
    [self.clv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsZero);
    }];
}

#pragma mark UICollectionViewDelegate, UICollectionViewDataSource

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 9;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat width = floorf((ScreenW - 10*2 - 10*2)/3.0);
    return CGSizeMake(width, 100);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeZero;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    return CGSizeZero;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    return UIEdgeInsetsMake(20, 10, 20, 10);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 10;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 20;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HomeFunctionModuleCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:HomeFunctionModuleCell.cellIdentifier forIndexPath:indexPath];
    
    
    return cell;
}

@end