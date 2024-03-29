//
//  ProblemReportItemCell.m
//  EES
//
//  Created by Albus on 20/11/2019.
//  Copyright © 2019 Zivos. All rights reserved.
//

#import "ProblemReportItemCell.h"

@interface ProblemReportItemCell ()

@property (nonatomic, strong) UIImageView *imgvOfSelection;

@property (nonatomic, strong) UILabel *txtOfTime;

@property (nonatomic, strong) UILabel *txtOfTitle;

// 产线
@property (nonatomic, strong) UILabel *txtOfChanxian;

// 报修
@property (nonatomic, strong) UILabel *txtOfBaoxiu;

// 角色
@property (nonatomic, strong) UILabel *txtOfRole;

// 类型
@property (nonatomic, strong) UILabel *txtOfType;

// 单号
@property (nonatomic, strong) UILabel *txtOfOrderNumber;

// 现象
@property (nonatomic, strong) UILabel *txtOfProblemDetail;


@property (nonatomic, strong) UIView *grayLine;

@end

@implementation ProblemReportItemCell

- (void)initSubviews {
    self.imgvOfSelection = [[UIImageView alloc] init];
    self.imgvOfSelection.contentMode = UIViewContentModeScaleAspectFit;
//    self.imgvOfSelection.backgroundColor = RANDOM_COLOR;
    self.imgvOfSelection.image = [UIImage imageNamed:@"selected_icon"];
    [self.contentView addSubview:self.imgvOfSelection];
    [self.imgvOfSelection mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-8);
        make.centerY.equalTo(self.contentView);
        make.width.height.mas_equalTo(15);
    }];
    
    self.txtOfTime = [UILabel quickLabelWithFont:[UIFont systemFontOfSize:15] textColor:HexColor(@"999999") parentView:self.contentView];
    [self.txtOfTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.imgvOfSelection.mas_left).offset(-5);
        make.top.offset(10);
        make.height.mas_equalTo(21);
    }];
    
    self.txtOfTitle = [UILabel quickLabelWithFont:[UIFont boldSystemFontOfSize:17] textColor:HexColor(MAIN_COLOR_BLACK) parentView:self.contentView];
    [self.txtOfTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.txtOfTime);
        make.left.offset(10);
        make.right.equalTo(self.txtOfTime.mas_left).offset(-5);
    }];
    
    self.txtOfChanxian = [UILabel quickLabelWithFont:[UIFont systemFontOfSize:15] textColor:HexColor(@"999999") parentView:self.contentView];
    [self.txtOfChanxian mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.txtOfTitle);
        make.top.equalTo(self.txtOfTitle.mas_bottom).offset(0);
        make.height.mas_equalTo(21);
    }];
    
    self.txtOfBaoxiu = [UILabel quickLabelWithFont:[UIFont systemFontOfSize:15] textColor:HexColor(@"999999") parentView:self.contentView];
    self.txtOfBaoxiu.textAlignment = NSTextAlignmentRight;
    self.txtOfBaoxiu.adjustsFontSizeToFitWidth = YES;
    [self.txtOfBaoxiu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.txtOfChanxian);
        make.height.mas_equalTo(21);
        make.right.equalTo(self.txtOfTime);
        make.left.equalTo(self.txtOfChanxian.mas_right).offset(3);
    }];
    
    
    self.txtOfRole = [UILabel quickLabelWithFont:[UIFont systemFontOfSize:15] textColor:HexColor(@"999999") parentView:self.contentView];
    [self.txtOfRole mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.txtOfChanxian);
        make.top.equalTo(self.txtOfChanxian.mas_bottom).offset(0);
        make.height.mas_equalTo(21);
    }];
    
    self.txtOfType = [UILabel quickLabelWithFont:[UIFont systemFontOfSize:15] textColor:HexColor(@"999999") parentView:self.contentView];
    self.txtOfType.textAlignment = NSTextAlignmentRight;
    self.txtOfType.adjustsFontSizeToFitWidth = YES;
    [self.txtOfType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.txtOfRole);
        make.height.mas_equalTo(21);
        make.right.equalTo(self.txtOfTime);
        make.left.equalTo(self.txtOfRole.mas_right).offset(3);
    }];
    
    self.txtOfOrderNumber = [UILabel quickLabelWithFont:[UIFont systemFontOfSize:15] textColor:HexColor(@"999999") parentView:self.contentView];
    [self.txtOfOrderNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.txtOfRole);
        make.top.equalTo(self.txtOfRole.mas_bottom).offset(0);
        make.height.mas_equalTo(21);
    }];
    
    
    self.txtOfProblemDetail = [UILabel quickLabelWithFont:[UIFont systemFontOfSize:15] textColor:HexColor(@"999999") parentView:self.contentView];
    [self.txtOfProblemDetail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.txtOfOrderNumber);
        make.top.equalTo(self.txtOfOrderNumber.mas_bottom).offset(0);
        make.height.mas_greaterThanOrEqualTo(21);
        make.right.equalTo(self.txtOfTime);
        make.bottom.offset(-10);
    }];
    
    self.grayLine = [[UIView alloc] init];
    self.grayLine.backgroundColor = HexColor(@"dddddd");
    [self.contentView addSubview:self.grayLine];
    [self.grayLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.contentView);
        make.height.mas_equalTo(1);
    }];
}

- (void)showSelected:(BOOL)ifSelected {
    self.imgvOfSelection.hidden = (!ifSelected);
}

- (void)resetSubviewsWithData:(ReportListItemModel *)data {
    self.txtOfTitle.text = [NSString stringWithFormat:@"%@|%@", data.EquipCode, data.EquipName];
    
    self.txtOfTime.text = AVOIDNULL(data.ReuqestTimeFormat);
    
    self.txtOfChanxian.text = [NSString stringWithFormat:@"产线：%@", data.LineName];
    
    self.txtOfBaoxiu.text = [NSString stringWithFormat:@"报修：%@", data.RequestOperator];
    
    self.txtOfRole.text = [NSString stringWithFormat:@"角色：%@", data.RoleName];
    
    self.txtOfType.text = [NSString stringWithFormat:@"类型：%@", data.BMTypeName];
    
    self.txtOfOrderNumber.text = [NSString stringWithFormat:@"单号：%@", data.BMRequestNO];
    
    self.txtOfProblemDetail.text = [NSString stringWithFormat:@"现象：%@",data.ItemDesc];
}

@end
