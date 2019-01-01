//
//  BXFStudentWorkViewController.h
//  boxfairystudent
//
//  Created by 包炯 on 2018/12/24.
//  Copyright © 2018 包炯. All rights reserved.
//

#import "BXFStudentViewController.h"
#import "BXFStudentWorkTitleView.h"
#import "BXFStudentWorkMainView.h"
#import "BXFStudentWorkRecordView.h"

NS_ASSUME_NONNULL_BEGIN

@interface BXFStudentWorkViewController : BXFStudentViewController {
    BXFStudentWorkTitleView *titleView;
    BXFStudentWorkMainView *mainView;
    BXFStudentWorkRecordView *recView;
}

@property(nonatomic, copy) NSDictionary *pageInfo;
@property(nonatomic, copy) NSString *typeString;


@end

NS_ASSUME_NONNULL_END
