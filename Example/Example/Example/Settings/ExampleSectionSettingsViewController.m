//
//  ExampleSectionSettingsViewController.m
//  Example
//
//  Created by 徐臻 on 2024/6/3.
//

#import "ExampleSectionSettingsViewController.h"
#import "ExampleSelectNumberViewController.h"
#import "ExampleEdgeInsetsViewController.h"

typedef NS_ENUM(NSUInteger, ExampleSectionSelectNumberType) {
    ExampleSectionSelectNumberTypeLineSpacing       = 1,
    ExampleSectionSelectNumberTypeInteritemSpacing  = 2,
    ExampleSectionSelectNumberTypeHeaderWidth       = 3,
    ExampleSectionSelectNumberTypeHeaderHeight      = 4,
    ExampleSectionSelectNumberTypeFooterWidth       = 5,
    ExampleSectionSelectNumberTypeFooterHeight      = 6
};

@interface ExampleSectionSettingsViewController ()

@end

@implementation ExampleSectionSettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
    switch (indexPath.section) {
        case 0:
            switch (indexPath.row) {
                case 0:
                    cell.detailTextLabel.text = [NSString stringWithFormat:@"%ld", (long)self.lineSpacing];
                    break;
                case 1:
                    cell.detailTextLabel.text = [NSString stringWithFormat:@"%ld", (long)self.interitemSpacing];
                    break;
                case 2:
                    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", NSStringFromUIEdgeInsets(self.edgeInsets)];
                    break;
                default:
                    break;
            }
            break;
        case 1:
            switch (indexPath.row) {
                case 0:
                    cell.detailTextLabel.text = [NSString stringWithFormat:@"%ld", self.lineAlignmentStyle];
                    break;
                case 1:
                    cell.detailTextLabel.text = [NSString stringWithFormat:@"%ld", self.interitemAlignment];
                    break;
                default:
                    break;
            }
            break;
        case 2:
            switch (indexPath.row) {
                case 0:
                    cell.detailTextLabel.text = [NSString stringWithFormat:@"%.0f", self.headerSize.width];
                    break;
                case 1:
                    cell.detailTextLabel.text = [NSString stringWithFormat:@"%.0f", self.headerSize.height];
                    break;
                default:
                    break;
            }
            break;
        case 3:
            switch (indexPath.row) {
                case 0:
                    cell.detailTextLabel.text = [NSString stringWithFormat:@"%.0f", self.footerSize.width];
                    break;
                case 1:
                    cell.detailTextLabel.text = [NSString stringWithFormat:@"%.0f", self.footerSize.height];
                    break;
                default:
                    break;
            }
            break;
        
        
        default:
            break;
    }
    return cell;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSString *identifier = segue.identifier;
    if ([identifier isEqualToString:@"lineSpacing"]) {
        ExampleSelectNumberViewController *vc = segue.destinationViewController;
        vc.type = ExampleSectionSelectNumberTypeLineSpacing;
        vc.value = self.lineSpacing;
    } else if ([identifier isEqualToString:@"interitemSpacing"]) {
        ExampleSelectNumberViewController *vc = segue.destinationViewController;
        vc.type = ExampleSectionSelectNumberTypeInteritemSpacing;
        vc.value = self.interitemSpacing;
    } else if ([identifier isEqualToString:@"lineAlignment"]) {
        ExampleSelectNumberViewController *vc = segue.destinationViewController;
        vc.value = self.lineAlignmentStyle;
    } else if ([identifier isEqualToString:@"interitemAlignment"]) {
        ExampleSelectNumberViewController *vc = segue.destinationViewController;
        vc.value = self.interitemAlignment;
    } else if ([identifier isEqualToString:@"edgeInsets"]) {
        ExampleEdgeInsetsViewController *vc = segue.destinationViewController;
        vc.value = self.edgeInsets;
    } else if ([identifier isEqualToString:@"headerWidth"]) {
        ExampleSelectNumberViewController *vc = segue.destinationViewController;
        vc.type = ExampleSectionSelectNumberTypeHeaderWidth;
        vc.value = self.headerSize.width / 10;
    } else if ([identifier isEqualToString:@"headerHeight"]) {
        ExampleSelectNumberViewController *vc = segue.destinationViewController;
        vc.type = ExampleSectionSelectNumberTypeHeaderHeight;
        vc.value = self.headerSize.height / 10;
    } else if ([identifier isEqualToString:@"footerWidth"]) {
        ExampleSelectNumberViewController *vc = segue.destinationViewController;
        vc.type = ExampleSectionSelectNumberTypeFooterWidth;
        vc.value = self.footerSize.width / 10;
    } else if ([identifier isEqualToString:@"footerHeight"]) {
        ExampleSelectNumberViewController *vc = segue.destinationViewController;
        vc.type = ExampleSectionSelectNumberTypeFooterHeight;
        vc.value = self.footerSize.height / 10;
    }
}

- (IBAction)unwindToApplySelectValue:(UIStoryboardSegue *)unwindSegue {
    ExampleSelectNumberViewController *sourceViewController = unwindSegue.sourceViewController;
    if (sourceViewController.type == ExampleSectionSelectNumberTypeLineSpacing) {
        self.lineSpacing = sourceViewController.value;
    } else if (sourceViewController.type == ExampleSectionSelectNumberTypeInteritemSpacing) {
        self.interitemSpacing = sourceViewController.value;
    } else if (sourceViewController.type == ExampleSectionSelectNumberTypeHeaderWidth) {
        _headerSize.width = sourceViewController.value * 10;
    } else if (sourceViewController.type == ExampleSectionSelectNumberTypeHeaderHeight) {
        _headerSize.height = sourceViewController.value * 10;
    } else if (sourceViewController.type == ExampleSectionSelectNumberTypeFooterWidth) {
        _footerSize.width = sourceViewController.value * 10;
    } else if (sourceViewController.type == ExampleSectionSelectNumberTypeFooterHeight) {
        _footerSize.height = sourceViewController.value * 10;
    }
    [self.tableView reloadData];
}

- (IBAction)unwindToUpdateEdgeInsets:(UIStoryboardSegue *)unwindSegue {
    ExampleEdgeInsetsViewController *vc = unwindSegue.sourceViewController;
    self.edgeInsets = vc.value;
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:2 inSection:0];
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:(UITableViewRowAnimationNone)];
}

- (IBAction)unwindToUpdateLineAlignment:(UIStoryboardSegue *)unwindSegue {
    ExampleSelectNumberViewController *sourceViewController = unwindSegue.sourceViewController;
    self.lineAlignmentStyle = sourceViewController.value;
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:1];
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:(UITableViewRowAnimationNone)];
}

- (IBAction)unwindToUpdateInteritemAlignment:(UIStoryboardSegue *)unwindSegue {
    ExampleSelectNumberViewController *sourceViewController = unwindSegue.sourceViewController;
    self.interitemAlignment = sourceViewController.value;
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:1 inSection:1];
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:(UITableViewRowAnimationNone)];
}

#pragma mark - Public Methods

- (void)setDataForSection:(ExampleSectionModel *)section atIndex:(NSInteger)index {
    self.index              = index;
    self.lineSpacing        = section.lineSpacing;
    self.interitemSpacing   = section.interitemSpacing;
    self.edgeInsets         = section.edgeInsets;
    self.lineAlignmentStyle = section.lineAlignmentStyle;
    self.interitemAlignment = section.interitemAlignment;
    self.headerSize         = section.headerSize;
    self.footerSize         = section.footerSize;
}

@end
