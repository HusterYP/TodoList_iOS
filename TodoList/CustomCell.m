//
//  CustomCell.m
//  TodoList
//
//  Created by yuanping on 2019/1/8.
//  Copyright © 2019年 yuanping. All rights reserved.
//

#import "CustomCell.h"

@interface CustomCell() {
}

@end

@implementation CustomCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _title = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 150, 30)];
        _content = [[UILabel alloc] initWithFrame:CGRectMake(10, 40, 200, 20)];
        _date = [[UILabel alloc] initWithFrame:CGRectMake(250, 40, 200, 10)];
        [_date setFont:[UIFont systemFontOfSize:12]];
        [_date setTextColor:[UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:1]];
        [_title setFont:[UIFont systemFontOfSize:18]];
        [_title setTextColor:[UIColor blackColor]];
        [_content setFont:[UIFont systemFontOfSize:12]];
        [_content setTextColor:[UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:1]];
        [self.contentView addSubview:_title];
        [self.contentView addSubview:_content];
        [self.contentView addSubview:_date];
    }
    return self;
}

@end
