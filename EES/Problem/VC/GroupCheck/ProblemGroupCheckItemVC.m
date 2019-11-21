//
//  ProblemGroupCheckItemVC.m
//  EES
//
//  Created by Albus on 2019-11-21.
//  Copyright © 2019 Zivos. All rights reserved.
//

#import "ProblemGroupCheckItemVC.h"
#import "ProblemCheckTitleView.h"

#import "ProblemGroupCheckDetailVC.h"

@interface ProblemGroupCheckItemVC () <ProblemCheckTitleViewDelegate, BasePageVCDelegate>

@property (nonatomic, strong) ProblemCheckTitleView *titleView;

@property (nonatomic, strong) BasePageVC *pageVC;

@end

@implementation ProblemGroupCheckItemVC

- (instancetype)init {
    self = [super init];
    if (self) {
        self.title = @"班组点检";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.titleView = [[ProblemCheckTitleView alloc] init];
    self.titleView.backgroundColor = HexColor(@"f1f1f1");
    self.titleView.delegate = self;
    [self.view addSubview:self.titleView];
    [self.titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.height.mas_equalTo(40);
    }];
    
    NSMutableArray *arrOfContentVC = [NSMutableArray array];
    for (int i = 0; i < 3; i++) {
        ProblemGroupCheckDetailVC *vcOfContnt = [[ProblemGroupCheckDetailVC alloc] init];
        vcOfContnt.state = i;
        [arrOfContentVC addObject:vcOfContnt];
    }
    
    self.pageVC = [[BasePageVC alloc] initWithArrOfContentVC:arrOfContentVC];
    self.pageVC.view.backgroundColor = HexColor(@"f1f1f1");
    self.pageVC.scrollDelegate = self;
    self.pageVC.view.frame = CGRectMake(0, 40, ScreenW, ScreenH - XBOTTOM_HEIGHT - 40 - 50);
    [self.view addSubview:self.pageVC.view];
    [self addChildViewController:self.pageVC];
    
    UIButton *btnConfirm = [UIButton buttonWithType:UIButtonTypeCustom];
    btnConfirm.titleLabel.font = [UIFont boldSystemFontOfSize:17];
    [btnConfirm setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnConfirm setTitle:@"提交" forState:UIControlStateNormal];
    [btnConfirm setBackgroundImage:[GlobalTool imageWithColor:HexColor(MAIN_COLOR)] forState:UIControlStateNormal];
    [self.view addSubview:btnConfirm];
    [btnConfirm mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.equalTo(self.view);
        make.right.mas_equalTo(self.view).offset(0);
        make.height.mas_equalTo(50);
    }];
}

#pragma mark ProblemCheckTitleViewDelegate

- (void)hasSelectedSegmentAtIndex:(NSInteger)index {
    [self.pageVC selectVCAtIndex:index];
}

#pragma mark BasePageVCDelegate

- (void)hasScrollToIndex:(NSInteger)index {
    [self.titleView tryToSelectSegmentAtIndex:index];
}

@end