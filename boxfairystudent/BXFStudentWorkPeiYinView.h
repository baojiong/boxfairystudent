//
//  BXFStudentWorkPeiYinView.h
//  boxfairystudent
//
//  Created by 包炯 on 2018/12/29.
//  Copyright © 2018 包炯. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BXFStudentWorkRecordView.h"
#import "BXFStudentWorkTitleView.h"

NS_ASSUME_NONNULL_BEGIN

@interface BXFStudentWorkPeiYinView : UIView

@property(nonatomic, strong) BXFStudentWorkRecordView* recordView;
@property(nonatomic, strong) BXFStudentWorkTitleView* titleView;

@property(nonatomic, copy) NSArray *contentText;
@property(nonatomic, copy) NSArray *originSound;
@property(nonatomic, copy) NSArray *schedule;
@property(nonatomic, assign, readonly) int currentSoundIndex;

@end

NS_ASSUME_NONNULL_END
