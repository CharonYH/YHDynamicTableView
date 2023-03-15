//
//  YHDynamicTableViewHeightViewController.m
//  YHDynamicTableView
//
//  Created by YEHAN on 2023/3/15.
//

#import "YHDynamicTableViewHeightViewController.h"
#import "YHDynamicTableViewDefine.h"
#import <Masonry/Masonry.h>

typedef NS_ENUM(NSInteger, YHDynamicBarButtonItemType) {
    YHDynamicBarButtonItemTypeAdd = 0,
    YHDynamicBarButtonItemTypeDelete = 1
};

@interface YHDynamicTableViewHeightViewController ()
<
UITableViewDelegate,
UITableViewDataSource
>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) NSMutableArray <NSNumber *> *dataSource;

@end

@implementation YHDynamicTableViewHeightViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self configObserver];
    [self configButtonBarItems];
}

// MARK: - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if (context == (__bridge void *)self.tableView) {
        if ([keyPath isEqualToString:@"contentSize"]) {
            [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(Status_And_Navigation_Height());
                make.left.right.mas_equalTo(0);
                make.height.mas_equalTo(self.tableView.contentSize.height);
            }];
        }
    }
}

// MARK: - UITableViewDelegate & UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(UITableViewCell.class) forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"%zd-%zd",indexPath.section,indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightSemibold];
    return cell;
}

// MARK: - Private Methods

- (void)initUI {
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.titleLabel];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(Status_And_Navigation_Height());
        make.left.right.mas_equalTo(0);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.tableView.mas_bottom).mas_offset(10);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.centerX.mas_equalTo(0);
    }];
}

- (void)configObserver {
    [self.tableView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:(__bridge void *)self.tableView];
}

- (void)configButtonBarItems {
    UIBarButtonItem *addDataSourceItem = [[UIBarButtonItem alloc] initWithTitle:@"添加数据" style:UIBarButtonItemStyleDone target:self action:@selector(navigationBarButtonItemClick:)];
    addDataSourceItem.tag = YHDynamicBarButtonItemTypeAdd;
    UIBarButtonItem *deleteDataSourceItem = [[UIBarButtonItem alloc] initWithTitle:@"删除数据" style:UIBarButtonItemStyleDone target:self action:@selector(navigationBarButtonItemClick:)];
    deleteDataSourceItem.tag = YHDynamicBarButtonItemTypeDelete;
    self.navigationItem.rightBarButtonItems = @[deleteDataSourceItem,addDataSourceItem];
}

- (void)navigationBarButtonItemClick:(UIBarButtonItem *)sender {
    switch (sender.tag) {
        case YHDynamicBarButtonItemTypeAdd:
            [self.dataSource addObject:@(self.dataSource.count + 1)];
            break;
        case YHDynamicBarButtonItemTypeDelete:
            [self.dataSource removeLastObject];
            break;
        default:
            break;
    }
    [self.tableView reloadData];
}

// MARK: - Setter & Getter

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor colorWithRed:244/255.0 green:245/255.0 blue:250/255.0 alpha:1];
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        if (@available (iOS 11, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
            self.automaticallyAdjustsScrollViewInsets = NO;
#pragma clang diagnostic pop
        }
        if (@available (iOS 15, *)) {
            _tableView.sectionHeaderTopPadding = 0;
        }
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        [_tableView registerClass:UITableViewCell.class forCellReuseIdentifier:NSStringFromClass(UITableViewCell.class)];
    }
    return _tableView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont systemFontOfSize:25 weight:UIFontWeightSemibold];
        _titleLabel.text = @"自适应高度UITableView下方的视图.初始化UITableView可以带初始化数据，也可以等数据回来后在reload.";
        _titleLabel.backgroundColor = UIColor.blueColor;
        _titleLabel.numberOfLines = 0;
    }
    return _titleLabel;
}

- (NSMutableArray<NSNumber *> *)dataSource {
    if (!_dataSource) {
        _dataSource = @[@1,@2].mutableCopy;
    }
    return _dataSource;
}

@end
