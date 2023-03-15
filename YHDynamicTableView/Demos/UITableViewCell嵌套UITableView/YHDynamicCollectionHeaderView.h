//
//  YHDynamicCollectionHeaderView.h
//  YHDynamicTableView
//
//  Created by YEHAN on 2023/3/15.
//

#import <UIKit/UIKit.h>

typedef void (^YHDynamicCollectionHeaderViewConfigurator) (UILabel * _Nonnull textLabel);

NS_ASSUME_NONNULL_BEGIN

@interface YHDynamicCollectionHeaderView : UICollectionReusableView

@property (nonatomic, copy, nullable, readonly) void (^configurator)(YHDynamicCollectionHeaderViewConfigurator _Nullable configurator);

@end

NS_ASSUME_NONNULL_END
