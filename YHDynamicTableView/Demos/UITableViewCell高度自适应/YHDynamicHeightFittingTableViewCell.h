//
//  YHDynamicHeightFittingTableViewCell.h
//  YHDynamicTableView
//
//  Created by YEHAN on 2023/3/15.
//

#import <UIKit/UIKit.h>

typedef void (^YHDynamicHeightFittingTableViewCellConfigurator)(UILabel * _Nonnull titleLabel,UIView * _Nonnull colorView);

NS_ASSUME_NONNULL_BEGIN

@interface YHDynamicHeightFittingTableViewCell : UITableViewCell

@property (nonatomic, copy, nullable) void (^configurator)(YHDynamicHeightFittingTableViewCellConfigurator _Nullable configurator);

@end

NS_ASSUME_NONNULL_END
