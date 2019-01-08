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

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate> {
    NSArray *array;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setHidden:YES];
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    array = [NSArray arrayWithObjects:nil];
    [tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"UITableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.textLabel.text = array[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"Click Item");
    [tableView deselectRowAtIndexPath:indexPath animated:true];
}

@end
