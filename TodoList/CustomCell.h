//
//  CustomCell.h
//  TodoList
//
//  Created by yuanping on 2019/1/8.
//  Copyright © 2019年 yuanping. All rights reserved.
//

#import<UIKit/UIKit.h>

@interface CustomCell : UITableViewCell
@property(nonatomic, strong, readonly) UILabel *title;
@property(nonatomic, strong, readonly) UILabel *content;
@property(nonatomic, strong, readonly) UILabel *date;
@end
