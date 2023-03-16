//
//  YHDynamicTableViewCellT.m
//  YHDynamicTableView
//
//  Created by YEHAN on 2023/3/16.
//

#import "YHDynamicTableViewCellT.h"
#include "YHDynamicTableViewDefine.h"
#import <Masonry/Masonry.h>
#import "UIView+YHExtention.h"
#import "YHDynamicTableViewCellTS.h"

static const CGFloat   kYHDynamicTableViewCellMarginT = 20;
static const CGFloat   kYHDynamicComponentMargin      = 10;

@interface YHDynamicTableViewCellT ()
<
UITableViewDelegate,
UITableViewDataSource
>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation YHDynamicTableViewCellT

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initUI];
    }
    return self;
}

- (void)setFrame:(CGRect)frame {
    frame.origin.x += kYHDynamicTableViewCellMarginT;
    frame.size.width -= kYHDynamicTableViewCellMarginT * 2;
    [super setFrame:frame];
}

- (CGSize)systemLayoutSizeFittingSize:(CGSize)targetSize withHorizontalFittingPriority:(UILayoutPriority)horizontalFittingPriority verticalFittingPriority:(UILayoutPriority)verticalFittingPriority {
    CGSize size = [super systemLayoutSizeFittingSize:targetSize withHorizontalFittingPriority:horizontalFittingPriority verticalFittingPriority:verticalFittingPriority];
    [self.tableView layoutIfNeeded];
    CGSize tableContentSize = self.tableView.contentSize;
    return CGSizeMake(targetSize.width, size.height + tableContentSize.height);
}

- (void (^)(YHDynamicTableViewCellTConfigurator _Nullable))configurator {
    return ^(YHDynamicTableViewCellTConfigurator _Nullable configurator) {
        !configurator ?: configurator(self.titleLabel);
    };
}

// MARK: - UITableViewDelegate & UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YHDynamicTableViewCellTS *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(YHDynamicTableViewCellTS.class) forIndexPath:indexPath];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = UIColor.orangeColor;
    cell.configurator(^(UILabel * _Nonnull titleLabel) {
        titleLabel.text = [self.dataSource[indexPath.row] stringByAppendingFormat:@": %zd-%zd",indexPath.section,indexPath.row];
    });
    return cell;
}

// MARK: - Private Methods

- (void)initUI {
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.tableView];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(kYHDynamicComponentMargin);
    }];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLabel.mas_bottom).mas_offset(kYHDynamicComponentMargin);
        make.left.mas_equalTo(kYHDynamicComponentMargin);
        make.bottom.right.mas_equalTo(-kYHDynamicComponentMargin);
    }];
}

// MARK: - Setter & Getter

- (void)setDataSource:(NSArray<NSString *> *)dataSource {
    _dataSource = dataSource;
    [self.tableView reloadData];
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor colorWithRed:244/255.0 green:245/255.0 blue:250/255.0 alpha:1];
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.showsVerticalScrollIndicator = NO;
        // 必须指定高度 不然有问题 暂时不知道什么原因
        _tableView.rowHeight = 40;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        if (@available (iOS 11, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
            self.ex_viewController.automaticallyAdjustsScrollViewInsets = NO;
#pragma clang diagnostic pop
        }
        if (@available (iOS 15, *)) {
            _tableView.sectionHeaderTopPadding = 0;
        }
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        [_tableView registerClass:YHDynamicTableViewCellTS.class forCellReuseIdentifier:NSStringFromClass(YHDynamicTableViewCellTS.class)];
    }
    return _tableView;
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
