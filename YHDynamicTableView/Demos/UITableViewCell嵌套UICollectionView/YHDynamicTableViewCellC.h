//
//  YHDynamicTableViewCellC.h
//  YHDynamicTableView
//
//  Created by YEHAN on 2023/3/15.
//

#import <UIKit/UIKit.h>

typedef void (^YHDynamicTableViewCellCConfigurator)(UILabel * _Nonnull titleLabel);

NS_ASSUME_NONNULL_BEGIN

@interface YHDynamicTableViewCellC : UITableViewCell

@property (nonatomic, copy, nullable, readonly) void (^configurator)(YHDynamicTableViewCellCConfigurator _Nullable configurator);
@property (nonatomic, strong) NSArray <NSNumber *> *dataSource;

@end

NS_ASSUME_NONNULL_END
