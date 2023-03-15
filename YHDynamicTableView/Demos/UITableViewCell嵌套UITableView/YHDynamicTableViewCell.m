//
//  YHDynamicTableViewCell.m
//  YHDynamicTableView
//
//  Created by YEHAN on 2023/3/15.
//

#import "YHDynamicTableViewCell.h"
#import "YHDynamicCollectionViewCell.h"
#import "YHDynamicCollectionView.h"
#import "YHDynamicCollectionHeaderView.h"
#import "YHDynamicTableViewDefine.h"
#import <Masonry/Masonry.h>

static const CGFloat   kYHDynamicTableViewCellMargin = 20;
static const CGFloat   kYHDynamicComponentMargin     = 10;
static const NSInteger kYHDynamicCollectionColumn    = 5;

@interface YHDynamicTableViewCell ()
<
UICollectionViewDelegate,
UICollectionViewDataSource
>

@property (nonatomic, strong) YHDynamicCollectionView *collectionView;
@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation YHDynamicTableViewCell

- (CGSize)systemLayoutSizeFittingSize:(CGSize)targetSize withHorizontalFittingPriority:(UILayoutPriority)horizontalFittingPriority verticalFittingPriority:(UILayoutPriority)verticalFittingPriority {
    CGSize size = [super systemLayoutSizeFittingSize:targetSize withHorizontalFittingPriority:horizontalFittingPriority verticalFittingPriority:verticalFittingPriority];
    [self.collectionView layoutIfNeeded];
    CGSize collectionViewContentSize = self.collectionView.collectionViewLayout.collectionViewContentSize;
    return CGSizeMake(size.width, size.height + collectionViewContentSize.height);
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initUI];
    }
    return self;
}

- (void)setFrame:(CGRect)frame {
    frame.origin.x += kYHDynamicTableViewCellMargin;
    frame.size.width -= kYHDynamicTableViewCellMargin * 2;
    [super setFrame:frame];
}

- (void (^)(YHDynamicTableViewCellConfigurator _Nullable))configurator {
    return ^(YHDynamicTableViewCellConfigurator _Nullable configurator) {
        !configurator ?: configurator(self.titleLabel);
    };
}

// MARK: - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    YHDynamicCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass(YHDynamicCollectionViewCell.class) forIndexPath:indexPath];
    cell.backgroundColor = YHRandomColor;
    cell.configurator(^(UILabel * _Nonnull titleLabel) {
        titleLabel.text = [NSString stringWithFormat:@"%zd-%zd",indexPath.section,indexPath.row];
    });
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    YHDynamicCollectionHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass(YHDynamicCollectionHeaderView.class) forIndexPath:indexPath];
    headerView.configurator(^(UILabel * _Nonnull textLabel) {
        textLabel.text = [NSString stringWithFormat:@"collectionSection-%zd",indexPath.row];
    });
    return headerView;
}

- (void)setDataSource:(NSArray<NSNumber *> *)dataSource {
    _dataSource = dataSource;
    [self.collectionView reloadData];
}

// MARK: - Private Methods

- (void)initUI {
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.collectionView];

    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(kYHDynamicComponentMargin);
    }];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLabel.mas_bottom).mas_offset(kYHDynamicComponentMargin);
        make.left.mas_equalTo(kYHDynamicComponentMargin);
        make.bottom.right.mas_equalTo(-kYHDynamicComponentMargin);
    }];
}

- (UIViewController *)viewController {
    for (UIView *view = self; view; view = view.superview) {
        UIResponder *nextResponder = view.nextResponder;
        if ([nextResponder isKindOfClass:UIViewController.class]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

// MARK: - Setter & Getter

- (YHDynamicCollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing = 10;
        layout.minimumInteritemSpacing = (YHScreenWidth - 2 * kYHDynamicTableViewCellMargin - kYHDynamicCollectionColumn * 54 - kYHDynamicComponentMargin * 2) / (kYHDynamicCollectionColumn - 1);
        layout.itemSize = CGSizeMake(54, 82);
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.headerReferenceSize = CGSizeMake(0, 30);
        _collectionView = [[YHDynamicCollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.backgroundColor = UIColor.whiteColor;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.scrollEnabled = NO;
        if (@available (iOS 11, *)) {
            _collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
            self.viewController.automaticallyAdjustsScrollViewInsets = NO;
#pragma clang diagnostic pop
        }
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        
        [_collectionView registerClass:YHDynamicCollectionViewCell.class forCellWithReuseIdentifier:NSStringFromClass(YHDynamicCollectionViewCell.class)];
        [_collectionView registerClass:YHDynamicCollectionHeaderView.class forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass(YHDynamicCollectionHeaderView.class)];
    }
    return _collectionView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.font = [UIFont systemFontOfSize:15 weight:UIFontWeightBold];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

@end
