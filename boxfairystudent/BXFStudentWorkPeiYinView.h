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

@interface BXFStudentWorkPeiYinView : UIView<AVAudioPlayerDelegate> {
    AVPlayer *player;
    //AVPlayerItem *playerItem;
    //playbackTimeObserver;
    NSString *totalTime;
    UISlider *videoSlider;
    
    AVAudioPlayer *audioPlayer;
    //    float currentStartTime;
    //    float currentEndTime;
    
    NSURL *videoUrl;
    //@property(nonatomic, copy) NSArray *originSoundURLs;
    NSArray *schedule;
    
    
    BOOL isPlayAll;
    BOOL isPreview;
    
    BOOL inStage;
    
    
}

@property(nonatomic, strong) BXFStudentWorkRecordView *recordView;
@property(nonatomic, strong) BXFStudentWorkTitleView *titleView;


@property(nonatomic, assign, readonly) int currentStage;

- (instancetype)initWithFrame:(CGRect)frame andVideoURL:(NSURL *)videoURL andSchedule:(NSArray *)scheduleArr;
- (void)turnToFirstStage;
- (void)preview:(UIButton *)sender;   //听合成视频。

@end

NS_ASSUME_NONNULL_END

