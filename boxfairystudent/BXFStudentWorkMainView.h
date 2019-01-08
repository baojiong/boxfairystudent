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
    UIImageView *currentPageView;
    AVAudioPlayer *audioPlayer;
    BOOL isPlayAll;
    BOOL isPreview;
    
    NSArray *pageImages;
    NSArray *originSoundURLs;
}


@property(nonatomic, assign, readonly) int currentPageIndex;

@property(nonatomic, strong) BXFStudentWorkRecordView* recordView;
@property(nonatomic, strong) BXFStudentWorkTitleView* titleView;

- (instancetype)initWithFrame:(CGRect)frame andImages:(NSArray *)pageImagesArr andOriginSoundURLs:(NSArray *)originSoundURLsArr;
- (void)turnToFirstPage;

- (void)preview;    //听合成视频。

@end

NS_ASSUME_NONNULL_END
