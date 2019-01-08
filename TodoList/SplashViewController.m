//
//  SplashViewController.m
//  TodoList
//
//  Created by yuanping on 2019/1/8.
//  Copyright © 2019年 yuanping. All rights reserved.
//
#import "SplashViewController.h"
#import "ViewController.h"

@interface SplashViewController() {
}

@end

@implementation SplashViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setHidden:true];
    CGRect frame = self.view.frame;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, frame.size.height / 2 - 60, frame.size.width, 120)];
    label.text = @"Manage Your Work !";
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor grayColor];
    label.font = [UIFont systemFontOfSize: 28];
    [self.view addSubview:label];
}

- (void)viewDidAppear:(BOOL)animated {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 2ull * NSEC_PER_SEC);
        dispatch_after(time, dispatch_get_main_queue(), ^{
            [self.navigationController pushViewController:[[ViewController alloc] initWithNibName:nil bundle:nil] animated:true];
        });
    });
}

@end
