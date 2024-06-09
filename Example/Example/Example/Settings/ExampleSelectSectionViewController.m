//
//  ExampleSelectSectionViewController.m
//  Example
//
//  Created by 徐臻 on 2024/6/3.
//

#import "ExampleSelectSectionViewController.h"
#import "ExampleSectionSettingsViewController.h"

@interface ExampleSelectSectionViewController ()

@end

@implementation ExampleSelectSectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _sections.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.textLabel.text = [NSString stringWithFormat:@"Section %ld", indexPath.row];
    
    return cell;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
    ExampleSectionModel *model = _sections[indexPath.section];
    ExampleSectionSettingsViewController *vc = segue.destinationViewController;
    [vc setDataForSection:model atIndex:indexPath.section];
}

@end
