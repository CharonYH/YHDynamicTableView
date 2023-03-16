//
//  YHDynamicTableViewCellTS.h
//  YHDynamicTableView
//
//  Created by YEHAN on 2023/3/16.
//

#import <UIKit/UIKit.h>

typedef void (^YHDynamicTableViewCellTSConfigurator)(UILabel * _Nonnull titleLabel);

NS_ASSUME_NONNULL_BEGIN

@interface YHDynamicTableViewCellTS : UITableViewCell

@property (nonatomic, copy, nullable, readonly) void (^configurator)(YHDynamicTableViewCellTSConfigurator _Nullable configurator);

@end

NS_ASSUME_NONNULL_END
