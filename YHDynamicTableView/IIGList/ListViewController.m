//
//  ListViewController.m
//  YHDynamicTableView
//
//  Created by YEHAN on 2023/3/15.
//

#import "ListViewController.h"
#import "IGConfigItem.h"
#import "IGNormalCollectionViewCell.h"
#import <Masonry/Masonry.h>

@interface ListViewController () <IGListAdapterDataSource>

@property (nonatomic, strong) IGListAdapter *adapter;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray<IGConfigItem *> *items;

@end

@implementation ListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.items = [self setUpItems];
    self.adapter.collectionView = self.collectionView;
    self.adapter.dataSource = self;
    [self initUI];
}

// MARK: - IGListSingleSectionControllerDelegate

- (void)didSelectSectionController:(IGListSingleSectionController *)sectionController withObject:(IGConfigItem *)object {
    UIViewController *vc = [[NSClassFromString(object.viewControllerName) alloc] init];
    if (vc) {
        vc.title = object.title;
        vc.view.backgroundColor = UIColor.whiteColor;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

// MARK: - IGListAdapterDataSource

- (NSArray<id<IGListDiffable>> *)objectsForListAdapter:(IGListAdapter *)listAdapter {
    return self.items;
}

- (IGListSectionController *)listAdapter:(IGListAdapter *)listAdapter sectionControllerForObject:(id)object {
    IGListSingleSectionController *sectionController = [[IGListSingleSectionController alloc] initWithCellClass:IGNormalCollectionViewCell.class configureBlock:^(NSString *_Nonnull item, __kindof UICollectionViewCell<IGListBindable> * _Nonnull cell) {
        [cell bindViewModel:item];
    } sizeBlock:^CGSize(NSString  *_Nonnull item, id<IGListCollectionContext>  _Nullable collectionContext) {
        return CGSizeMake(collectionContext.containerSize.width, 50);
    }];
    sectionController.selectionDelegate = self;
    return sectionController;
}

- (UIView *)emptyViewForListAdapter:(IGListAdapter *)listAdapter {
    return nil;
}

// MARK: - Private Methods

- (void)initUI {
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
}

- (NSArray <IGConfigItem *> *)setUpItems {
    return @[
        [IGConfigItem configItem:@"UITableViewCell高度自适应" viewControllerName:@"YHDynamicTableViewCellHeightViewController"],
        [IGConfigItem configItem:@"UITableView自适应高度" viewControllerName:@"YHDynamicTableViewHeightViewController"],
        [IGConfigItem configItem:@"UITableViewCell嵌套UICollectionView自适应高度" viewControllerName:@"YHDynamicTableViewControllerC"],
        [IGConfigItem configItem:@"UITableViewCell嵌套UITableView自适应高度" viewControllerName:@"YHDynamicTableViewControllerT"]
    ];
}

// MARK: Setter & Getter

- (IGListAdapter *)adapter {
    if (!_adapter) {
        _adapter = [[IGListAdapter alloc] initWithUpdater:[[IGListAdapterUpdater alloc] init] viewController:self workingRangeSize:0];
    }
    return _adapter;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:[[UICollectionViewFlowLayout alloc] init]];
        _collectionView.backgroundColor = UIColor.whiteColor;
    }
    return _collectionView;
}

@end
