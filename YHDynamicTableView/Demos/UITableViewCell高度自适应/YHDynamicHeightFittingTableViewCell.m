//
//  YHDynamicHeightFittingTableViewCell.m
//  YHDynamicTableView
//
//  Created by YEHAN on 2023/3/15.
//

#import "YHDynamicHeightFittingTableViewCell.h"
#import <Masonry/Masonry.h>

@interface YHDynamicHeightFittingTableViewCell ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView  *colorView;

@end

@implementation YHDynamicHeightFittingTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initUI];
    }
    return self;
}

- (void)setFrame:(CGRect)frame {
    frame.origin.x += 20;
    frame.size.width -= 20 * 2;
    [super setFrame:frame];
}

- (void (^)(YHDynamicHeightFittingTableViewCellConfigurator _Nullable))configurator {
    return ^(YHDynamicHeightFittingTableViewCellConfigurator _Nullable configurator) {
        !configurator ?: configurator(self.titleLabel,self.colorView);
    };
}

// MARK: - Private Methods

- (void)initUI {
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.colorView];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
    }];
    [self.colorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLabel.mas_bottom).mas_offset(10);
        make.centerX.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(50, 50));
        make.bottom.mas_equalTo(-10);
    }];
}

// MARK: - Setter & Getter

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightSemibold];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.numberOfLines = 0;
    }
    return _titleLabel;
}

- (UIView *)colorView {
    if (!_colorView) {
        _colorView = [[UIView alloc] initWithFrame:CGRectZero];
    }
    return _colorView;
}


@end
