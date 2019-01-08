//
//  BXFStudentPeiYinViewController.h
//  boxfairystudent
//
//  Created by 包炯 on 2018/12/29.
//  Copyright © 2018 包炯. All rights reserved.
//

#import "BXFStudentViewController.h"
#import "BXFStudentWorkTitleView.h"
#import "BXFStudentWorkPeiYinView.h"
#import "BXFStudentWorkRecordView.h"

NS_ASSUME_NONNULL_BEGIN

@interface BXFStudentPeiYinViewController : BXFStudentViewController {
    BXFStudentWorkTitleView *titleView;
    BXFStudentWorkPeiYinView *mainView;
    BXFStudentWorkRecordView *recView;
}

@end

NS_ASSUME_NONNULL_END
