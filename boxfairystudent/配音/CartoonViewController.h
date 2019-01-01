//
//  CartoonViewController.h
//  boxfairystudent
//
//  Created by 包炯 on 2018/12/23.
//  Copyright © 2018 包炯. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BXFStudentViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface CartoonViewController : BXFStudentViewController

- (instancetype)initWithCartoonsInfo:(NSDictionary *)cartoonsInfo;

@property(nonatomic, weak)IBOutlet UILabel *titleLabel;

@end

NS_ASSUME_NONNULL_END
