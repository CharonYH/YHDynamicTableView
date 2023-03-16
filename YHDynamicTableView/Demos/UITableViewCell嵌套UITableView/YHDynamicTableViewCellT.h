//
//  YHDynamicTableViewCellT.h
//  YHDynamicTableView
//
//  Created by YEHAN on 2023/3/16.
//

#import <UIKit/UIKit.h>

typedef void (^YHDynamicTableViewCellTConfigurator)(UILabel * _Nonnull titleLabel);

NS_ASSUME_NONNULL_BEGIN

@interface YHDynamicTableViewCellT : UITableViewCell

@property (nonatomic, strong) NSArray <NSString *> *dataSource;
@property (nonatomic, copy, nullable, readonly) void (^configurator)(YHDynamicTableViewCellTConfigurator _Nullable configurator);

@end

NS_ASSUME_NONNULL_END
