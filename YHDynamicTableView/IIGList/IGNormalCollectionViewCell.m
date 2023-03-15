//
//  IGNormalCollectionViewCell.m
//  YHDynamicTableView
//
//  Created by YEHAN on 2023/3/15.
//

#import "IGNormalCollectionViewCell.h"
#import "IGConfigItem.h"
#import <Masonry/Masonry.h>

@interface IGNormalCollectionViewCell ()

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation IGNormalCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}

// MARK: - IGListBindable

- (void)bindViewModel:(id)viewModel {
    if ([viewModel isKindOfClass:IGConfigItem.class]) {
        self.titleLabel.text = ((IGConfigItem *)viewModel).title;
    } else if([viewModel isKindOfClass:NSNumber.class]) {
        self.titleLabel.text = ((NSNumber *)viewModel).stringValue;
    }
}

// MARK: - Setter & Getter

- (void)initUI {
    [self.contentView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.centerY.mas_equalTo(0);
    }];
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = UIColor.blackColor;
        _titleLabel.font = [UIFont systemFontOfSize:18];
    }
    return _titleLabel;
}

@end
