//
//  ProblemPeriodicalMaintenanceItemCell.h
//  EES
//
//  Created by Albus on 2019-11-21.
//  Copyright © 2019 Zivos. All rights reserved.
//

#import "ASTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@class PeriodicalMaintenanceItemModel;

@interface ProblemPeriodicalMaintenanceItemCell : ASTableViewCell

- (void)resetSubviewsWithData:(PeriodicalMaintenanceItemModel *)data;

@end

NS_ASSUME_NONNULL_END
