//
//  ExampleViewController.m
//  Example
//
//  Created by Xezun on 2023/7/27.
//

#import "ExampleViewController.h"
#import "ExampleCellModel.h"
#import "ExampleSectionModel.h"
#import "ExampleSectionHeaderFooterView.h"
#import "ExampleSectionSettingsViewController.h"
#import "ExampleSettingsViewController.h"
#import "ExampleCellSettingsViewController.h"

@import XZCollectionViewFlowLayout;


@interface ExampleViewController () <XZCollectionViewDelegateFlowLayout, ExampleSectionHeaderFooterViewDelegate> {
    NSArray<ExampleSectionModel *> *_dataArray;
}

@end

@implementation ExampleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadData];
    
    UICollectionView * const collectionView = self.collectionView;
    [collectionView registerClass:[ExampleSectionHeaderFooterView class]
       forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"Header"];
    [collectionView registerClass:[ExampleSectionHeaderFooterView class]
       forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"Footer"];
}

- (void)loadData {
    XZCollectionViewFlowLayout *layout = (id)self.collectionView.collectionViewLayout;
    UICollectionViewScrollDirection scrollDirection = layout.scrollDirection;
    NSMutableArray *sections = [NSMutableArray arrayWithCapacity:10];
    for (NSInteger section = 0; section < 10; section++) {
        ExampleSectionModel *model = [[ExampleSectionModel alloc] initWithScrollDirection:scrollDirection];
        [sections addObject:model];
    }
    _dataArray = sections.copy;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return _dataArray.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _dataArray[section].cells.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.contentView.backgroundColor = _dataArray[indexPath.section].cells[indexPath.item].color;
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    NSString *identifer = [kind isEqualToString:UICollectionElementKindSectionHeader] ? @"Header" : @"Footer";
    ExampleSectionHeaderFooterView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:identifer forIndexPath:indexPath];
    view.index = indexPath.section;
    view.delegate = self;
    return view;
}

- (enum XZCollectionViewLineAlignment)collectionView:(UICollectionView *)collectionView layout:(XZCollectionViewFlowLayout *)layout lineAlignmentForLineAtIndexPath:(NSIndexPath *)indexPath {
    return [_dataArray[indexPath.section] lineAlignmentForItemsInLine:indexPath.xz_line];
}

- (enum XZCollectionViewInteritemAlignment)collectionView:(UICollectionView *)collectionView layout:(XZCollectionViewFlowLayout *)layout interitemAlignmentForItemAtIndexPath:(NSIndexPath *)indexPath {
    ExampleSectionModel * const section = _dataArray[indexPath.section];
    ExampleCellModel    * const cell    = section.cells[indexPath.item];
    return cell.isCustomized ? cell.interitemAlignment : section.interitemAlignment;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return _dataArray[indexPath.section].cells[indexPath.item].size;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return _dataArray[section].lineSpacing;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return _dataArray[section].interitemSpacing;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return _dataArray[section].edgeInsets;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return _dataArray[section].headerSize;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    return _dataArray[section].footerSize;
}

- (void)didSelectHeaderFooterView:(ExampleSectionHeaderFooterView *)headerFooterView {
    [self performSegueWithIdentifier:@"SectionSettings" sender:headerFooterView];
}

- (IBAction)navBackButtonAction:(id)sender {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"点击 Header/Footer 可调整 Section 配置；\n点击 Cell 可调整 Cell 的配置。" preferredStyle:(UIAlertControllerStyleAlert)];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
}

- (IBAction)unwindToChangeScrollDirection:(UIStoryboardSegue *)unwindSegue {
    if ([unwindSegue.identifier isEqualToString:@"Horizontal"]) {
        XZCollectionViewFlowLayout *layout = (id)self.collectionView.collectionViewLayout;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    } else {
        XZCollectionViewFlowLayout *layout = (id)self.collectionView.collectionViewLayout;
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    }
    [self loadData];
    [self.collectionView reloadData];
}

- (IBAction)unwindToReloadData:(UIStoryboardSegue *)unwindSegue {
    [self loadData];
    [self.collectionView reloadData];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSString *identifier = segue.identifier;
    if ([identifier isEqualToString:@"SectionSettings"]) {
        ExampleSectionHeaderFooterView *view = sender;
        NSInteger const index = view.index;
        ExampleSectionModel *model = _dataArray[index];
        ExampleSectionSettingsViewController *vc = segue.destinationViewController;
        [vc setDataForSection:model atIndex:index];
    } else if ([identifier isEqualToString:@"Settings"]) {
        ExampleSettingsViewController *vc = segue.destinationViewController;
        vc.sections = _dataArray;
    } else if ([identifier isEqualToString:@"CellSettings"]) {
        NSIndexPath *indexPath = [self.collectionView indexPathForCell:sender];
        ExampleCellSettingsViewController *vc = segue.destinationViewController;
        [vc setDataWithModel:_dataArray[indexPath.section] indexPath:indexPath];
    }
}

- (IBAction)unwindToNavigateBack:(UIStoryboardSegue *)unwindSegue {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)unwindToConfirmSectionSettings:(UIStoryboardSegue *)unwindSegue {
    ExampleSectionSettingsViewController *vc = unwindSegue.sourceViewController;
    ExampleSectionModel *model = _dataArray[vc.index];
    model.lineSpacing        = vc.lineSpacing;
    model.interitemSpacing   = vc.interitemSpacing;
    model.edgeInsets         = vc.edgeInsets;
    model.lineAlignmentStyle = vc.lineAlignmentStyle;
    model.interitemAlignment = vc.interitemAlignment;
    model.headerSize = vc.headerSize;
    model.footerSize = vc.footerSize;
    [self.collectionView reloadData];
}

- (IBAction)unwindToConfirmCellSettings:(UIStoryboardSegue *)unwindSegue {
    ExampleCellSettingsViewController *vc = unwindSegue.sourceViewController;
    NSIndexPath *indexPath = vc.indexPath;
    ExampleCellModel *model = _dataArray[indexPath.section].cells[indexPath.item];
    model.size = vc.size;
    model.isCustomized = vc.isCustomized;
    model.interitemAlignment = vc.interitemAlignment;
    [self.collectionView reloadData];
}

@end

