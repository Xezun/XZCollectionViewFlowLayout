//
//  ExampleSelectSectionViewController.h
//  Example
//
//  Created by 徐臻 on 2024/6/3.
//

#import <UIKit/UIKit.h>
#import "ExampleSectionModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ExampleSelectSectionViewController : UITableViewController

@property (nonatomic, copy) NSArray<ExampleSectionModel *> *sections;

@end

NS_ASSUME_NONNULL_END
