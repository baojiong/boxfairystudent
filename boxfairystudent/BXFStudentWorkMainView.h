//
//  BXFStudentWorkMainView.h
//  boxfairystudent
//
//  Created by 包炯 on 2018/12/24.
//  Copyright © 2018 包炯. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BXFStudentWorkRecordView.h"
#import "BXFStudentWorkTitleView.h"

NS_ASSUME_NONNULL_BEGIN

@interface BXFStudentWorkMainView : UIView<AVAudioPlayerDelegate>{
    int currentPageIndex;
    UIImageView *currentPageView;
    
    AVAudioPlayer *audioPlayer;
}

@property(nonatomic, copy) NSArray *pageImages;
@property(nonatomic, copy) NSArray *contentText;
@property(nonatomic, copy) NSArray *originSound;
@property(nonatomic, assign, readonly) int currentPageIndex;

@property(nonatomic, strong) BXFStudentWorkRecordView* recordView;
@property(nonatomic, strong) BXFStudentWorkTitleView* titleView;

- (void)turnToFirstPage;

@end

NS_ASSUME_NONNULL_END
