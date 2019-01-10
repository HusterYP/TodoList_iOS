//
//  DataBean.h
//  TodoList
//
//  Created by yuanping on 2019/1/8.
//  Copyright © 2019年 yuanping. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataBean : NSObject<NSCoding>

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSDate *date;

- (instancetype) initWithTitle: (NSString *)title content: (NSString *)content date: (NSDate *)date;

@end
