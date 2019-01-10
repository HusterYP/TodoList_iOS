//
//  ViewController.m
//  TodoList
//
//  Created by yuanping on 2019/1/8.
//  Copyright © 2019年 yuanping. All rights reserved.
//

/**
 * TodoList:
 * 标题，正文，是否完成，优先级
 * 支持新建，排序（创建时间，优先级）
 */

#import "ViewController.h"
#import "AddItemViewController.h"
#import "DataBean.h"
#import "CustomCell.h"

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate> {
    NSMutableArray *dataBeans;
    NSString *path;
    UITableView *tableView;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, true) lastObject];
    path = [path stringByAppendingPathComponent:@"Todo.txt"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:path]) {
        dataBeans = [[NSMutableArray alloc] init];
    } else {
        dataBeans = [[NSKeyedUnarchiver unarchiveObjectWithFile:path] mutableCopy];
    }
    
    [self.navigationController.navigationBar setHidden:NO];
    UIBarButtonItem *leftButtomItem = [[UIBarButtonItem alloc] initWithTitle:nil style:UIBarButtonItemStyleDone target:self action:nil];
    self.navigationItem.leftBarButtonItem = leftButtomItem;
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"Add" style:UIBarButtonItemStyleDone target:self action:@selector(addItem)];
    self.navigationItem.rightBarButtonItem = rightItem;
    tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    [tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return dataBeans.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"UITableViewCell";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    CustomCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell = [[CustomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
//    cell.textLabel.text = array[indexPath.row];
    DataBean *bean = dataBeans[indexPath.row];
    cell.title.text = bean.title;
    cell.content.text = bean.content;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    cell.date.text = [formatter stringFromDate:bean.date];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"Click Item");
    [tableView deselectRowAtIndexPath:indexPath animated:true];
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除";
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        if (dataBeans.count > indexPath.row) {
            DataBean *deleteBean = dataBeans[indexPath.row];
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:deleteBean.title message:@"Are you sure to delete the item ?" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *yes = [UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [dataBeans removeObjectAtIndex:indexPath.row];
                [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationLeft];
                [self saveData];
            }];
            [alert addAction:yes];
            
            UIAlertAction *no = [UIAlertAction actionWithTitle:@"No" style:UIAlertActionStyleDefault handler:nil];
            [alert addAction:no];
            
            [self presentViewController:alert animated:true completion:nil];
        }
    }
}

- (void) addItem {
    AddItemViewController *addItem = [[AddItemViewController alloc] initWithNibName:nil bundle:nil];
    addItem.delegate = self;
    [self.navigationController pushViewController:addItem animated:true];
}

- (void)addNewItemWithTitle:(NSString *)title content:(NSString *)content date:(NSDate *)date {
    DataBean *newBean = [[DataBean alloc] initWithTitle:title content:content date:date];
    [dataBeans addObject:newBean];
    [tableView reloadData];
    [self saveData];
}

- (void)saveData {
    [NSKeyedArchiver archiveRootObject:dataBeans toFile:path];
}

@end
