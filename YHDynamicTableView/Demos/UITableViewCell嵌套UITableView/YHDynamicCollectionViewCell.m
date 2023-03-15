//
//  YHDynamicCollectionViewCell.m
//  YHDynamicTableView
//
//  Created by YEHAN on 2023/3/15.
//

#import "YHDynamicCollectionViewCell.h"
#import <Masonry/Masonry.h>

@interface YHDynamicCollectionViewCell ()

@property (nonatomic, strong) UILabel *textLabel;

@end

@implementation YHDynamicCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}

- (void (^)(YHDynamicCollectionViewCellConfigurator _Nullable))configurator {
    return ^(YHDynamicCollectionViewCellConfigurator _Nullable configurator) {
        !configurator ?: configurator(self.textLabel);
    };
}

// MARK: - Setter & Getter

- (void)initUI {
    [self.contentView addSubview:self.textLabel];
    [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
}

- (UILabel *)textLabel {
    if (!_textLabel) {
        _textLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _textLabel.font = [UIFont systemFontOfSize:15 weight:UIFontWeightSemibold];
        _textLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _textLabel;
}

@end
