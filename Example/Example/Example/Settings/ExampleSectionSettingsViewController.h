//
//  ExampleSectionSettingsViewController.h
//  Example
//
//  Created by 徐臻 on 2024/6/3.
//

#import <UIKit/UIKit.h>
#import "ExampleSectionModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ExampleSectionSettingsViewController : UITableViewController

@property (nonatomic) NSInteger index;

@property (nonatomic) CGFloat lineSpacing;
@property (nonatomic) CGFloat interitemSpacing;

@property (nonatomic) UIEdgeInsets edgeInsets;

@property (nonatomic) ExampleSectionModelLineAlignmentStyle lineAlignmentStyle;
@property (nonatomic) XZCollectionViewInteritemAlignment interitemAlignment;

@property (nonatomic) CGSize headerSize;
@property (nonatomic) CGSize footerSize;

- (void)setDataForSection:(ExampleSectionModel *)section atIndex:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
