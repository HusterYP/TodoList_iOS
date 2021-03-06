//
//  AddItemViewController.m
//  TodoList
//
//  Created by yuanping on 2019/1/8.
//  Copyright © 2019年 yuanping. All rights reserved.
//

#import "AddItemViewController.h"
#import "DataBean.h"

@interface AddItemViewController() {
    UITextField *title;
    UITextView *content;
    UIButton *commit;
    DataBean *oldBean;
    int oldBeanIndex;
}

@end

@implementation AddItemViewController

- (instancetype)initWithOldData: (DataBean *)oldBean index: (int)oldBeanIndex {
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        self->oldBean = oldBean;
        self->oldBeanIndex = oldBeanIndex;
    }
    return self;
}

- (void)viewDidLoad {
    self.view.backgroundColor = [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1];
//    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithTitle:nil style:UIBarButtonItemStyleDone target:self action:nil];
//    self.navigationItem.leftBarButtonItem = leftItem;
    
    if (oldBean == nil) {
        [self setViewWithNewItem];
    } else {
        [self setViewWithOldItem];
    }
}

- (void) setViewWithOldItem {
    [self setViewWithNewItem];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"Edit" style:UIBarButtonItemStyleDone target:self action:@selector(edit:)];
    self.navigationItem.rightBarButtonItem = rightItem;
    [title setText:oldBean.title];
    [content setText:oldBean.content];
    title.enabled = false;
    [content setEditable:false];
}

- (void) setViewWithNewItem {
    CGRect frame = self.view.frame;
    CGRect tabBarRect = [[UIApplication sharedApplication] statusBarFrame];
    title = [[UITextField alloc] initWithFrame:CGRectMake(10, tabBarRect.size.height + 50, frame.size.width - 20, 40)];
    title.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    title.placeholder = @"Title";
    title.borderStyle = UITextBorderStyleRoundedRect;
    content = [[UITextView alloc] initWithFrame:CGRectMake(10, tabBarRect.size.height + 100, frame.size.width - 20, 600)];
    commit = [[UIButton alloc] initWithFrame:CGRectMake(10, tabBarRect.size.height + 720, 120, 40)];
    [commit setTitle:@"Commit" forState:UIControlStateNormal];
    commit.backgroundColor = [UIColor whiteColor];
    [commit setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [commit addTarget:self action:@selector(commitMsg:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:title];
    [self.view addSubview:content];
    [self.view addSubview:commit];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleDone target:self action:@selector(cancel:)];
    
    self.navigationItem.leftBarButtonItem = leftItem;
    [title becomeFirstResponder];
}

- (void) commitMsg: (UIButton *)bt {
    if (oldBean == nil) {
        NSString *titleMsg = title.text;
        NSString *contentMsg = content.text;
        if (titleMsg == nil || titleMsg.length == 0) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Warning" message:@"Please input the title" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil];
            [alert addAction:cancel];
            [self presentViewController:alert animated:true completion:nil];
        } else  {
            NSDate *curDate = [NSDate date];
            [_delegate addNewItemWithTitle:titleMsg content:contentMsg date:curDate];
            [self.navigationController popViewControllerAnimated:true];
        }
    } else {
        oldBean.title = title.text;
        oldBean.content = content.text;
        [_delegate updateOldBeanAtIndex:oldBeanIndex newBean:oldBean];
        [self.navigationController popViewControllerAnimated:true];
    }
}

- (void) cancel:(UIBarButtonItem *)bt {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Warning" message:@"Are you sure to cancel ?" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *yes = [UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [self.navigationController popViewControllerAnimated:true];
    }];
    [alert addAction:yes];
    UIAlertAction *no = [UIAlertAction actionWithTitle:@"No" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:no];
    [self presentViewController:alert animated:true completion:nil];
}

- (void)edit:(UIBarButtonItem *)bt {
    title.enabled = true;
    [content setEditable:true];
    [title becomeFirstResponder];
}

@end
