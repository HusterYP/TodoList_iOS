//
//  AddItemViewController.h
//  TodoList
//
//  Created by yuanping on 2019/1/8.
//  Copyright © 2019年 yuanping. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DataBean;

@protocol AddItemDelegate <NSObject>

- (void)addNewItemWithTitle: (NSString *)title content: (NSString *)content date: (NSDate *)date;

- (void)updateOldBeanAtIndex: (int)oldBeanIndex newBean: (DataBean *)newBean;

@end

@interface AddItemViewController : UIViewController

@property(nonatomic, weak) id<AddItemDelegate> delegate;

- (instancetype)initWithOldData: (DataBean *)oldBean index: (int)oldBeanIndex;

@end


