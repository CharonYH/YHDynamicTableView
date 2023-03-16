//
//  YHDynamicCollectionViewCell.h
//  YHDynamicTableView
//
//  Created by YEHAN on 2023/3/15.
//

#import <UIKit/UIKit.h>

typedef void (^YHDynamicCollectionViewCellConfigurator) (UILabel * _Nonnull textLabel);

NS_ASSUME_NONNULL_BEGIN

@interface YHDynamicCollectionViewCell : UICollectionViewCell

@property (nonatomic, copy, nullable, readonly) void (^configurator)(YHDynamicCollectionViewCellConfigurator _Nullable configurator);

@end

NS_ASSUME_NONNULL_END
