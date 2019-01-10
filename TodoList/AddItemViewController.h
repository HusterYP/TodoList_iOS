//
//  AddItemViewController.h
//  TodoList
//
//  Created by yuanping on 2019/1/8.
//  Copyright © 2019年 yuanping. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AddItemDelegate <NSObject>

- (void)addNewItemWithTitle: (NSString *)title content: (NSString *)content date: (NSDate *)date;

@end

@interface AddItemViewController : UIViewController

@property(nonatomic, weak) id<AddItemDelegate> delegate;

@end


