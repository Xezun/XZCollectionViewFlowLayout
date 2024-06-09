//
//  ExampleCellSettingsViewController.h
//  Example
//
//  Created by 徐臻 on 2024/6/5.
//

#import <UIKit/UIKit.h>
#import "ExampleSectionModel.h"
#import "ExampleCellModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ExampleCellSettingsViewController : UITableViewController

@property (nonatomic) CGSize size;
@property (nonatomic) XZCollectionViewInteritemAlignment interitemAlignment;
@property (nonatomic, setter=setCustomized:) BOOL isCustomized;

@property (nonatomic) NSIndexPath *indexPath;

- (void)setDataWithModel:(ExampleSectionModel *)model indexPath:(NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END
