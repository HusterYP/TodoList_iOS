//
//  DataBean.m
//  TodoList
//
//  Created by yuanping on 2019/1/8.
//  Copyright © 2019年 yuanping. All rights reserved.
//

#import "DataBean.h"

@interface DataBean() {
    
}

@end

@implementation DataBean

- (instancetype)initWithTitle:(NSString *)title content:(NSString *)content date:(NSDate *)date {
    self = [super init];
    if (self) {
        _title = title;
        _content = content;
        _date = date;
    }
    return self;
}



- (void)encodeWithCoder:(nonnull NSCoder *)aCoder {
    [aCoder encodeObject:self.title forKey:@"Title"];
    [aCoder encodeObject:self.content forKey:@"Content"];
    [aCoder encodeObject:self.date forKey:@"Date"];
}

- (nullable instancetype)initWithCoder:(nonnull NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        self.title = [aDecoder decodeObjectForKey:@"Title"];
        self.content = [aDecoder decodeObjectForKey:@"Content"];
        self.date = [aDecoder decodeObjectForKey:@"Date"];
    }
    return self;
}

@end
