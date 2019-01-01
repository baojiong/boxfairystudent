//
//  BookshelfViewController.h
//  boxfairystudent
//
//  Created by 包炯 on 2018/12/21.
//  Copyright © 2018 包炯. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BXFStudentViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface BookshelfViewController : BXFStudentViewController

- (instancetype)initWithBooksInfo:(NSDictionary *)booksInfo;

@property(nonatomic, weak)IBOutlet UILabel *titleLabel;

@end

NS_ASSUME_NONNULL_END
