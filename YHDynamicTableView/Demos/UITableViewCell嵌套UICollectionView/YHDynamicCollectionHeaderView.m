//
//  YHDynamicCollectionHeaderView.m
//  YHDynamicTableView
//
//  Created by YEHAN on 2023/3/15.
//

#import "YHDynamicCollectionHeaderView.h"
#import <Masonry/Masonry.h>

@interface YHDynamicCollectionHeaderView ()

@property (nonatomic, strong) UILabel *textLabel;

@end

@implementation YHDynamicCollectionHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}

- (void (^)(YHDynamicCollectionHeaderViewConfigurator _Nullable))configurator {
    return ^(YHDynamicCollectionHeaderViewConfigurator _Nullable configurator) {
        !configurator ?: configurator(self.textLabel);
    };
}

// MARK: - Private Methods

- (void)initUI {
    [self addSubview:self.textLabel];
    [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.centerX.mas_equalTo(0);
    }];
}

// MARK: - Setter & Getter

- (UILabel *)textLabel {
    if (!_textLabel) {
        _textLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _textLabel.font = [UIFont systemFontOfSize:15 weight:UIFontWeightSemibold];
        _textLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _textLabel;
}

@end
