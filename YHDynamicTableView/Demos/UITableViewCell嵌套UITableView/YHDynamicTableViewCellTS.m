//
//  YHDynamicTableViewCellTS.m
//  YHDynamicTableView
//
//  Created by YEHAN on 2023/3/16.
//

#import "YHDynamicTableViewCellTS.h"
#import <Masonry/Masonry.h>

@interface YHDynamicTableViewCellTS ()

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation YHDynamicTableViewCellTS

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

- (void (^)(YHDynamicTableViewCellTSConfigurator _Nullable))configurator {
    return ^(YHDynamicTableViewCellTSConfigurator _Nullable configurator) {
        !configurator ?: configurator(self.titleLabel);
    };
}

// MARK: - Private Methods

- (void)initUI {
    [self.contentView addSubview:self.titleLabel];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(10);
        make.height.mas_equalTo(20);
        make.bottom.right.mas_equalTo(-10);
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

@end
