//
//  BXFStudentWorkPeiYinView.m
//  boxfairystudent
//
//  Created by 包炯 on 2018/12/29.
//  Copyright © 2018 包炯. All rights reserved.
//

#import "BXFStudentWorkPeiYinView.h"

static const int kImageMargin = 15;
//static const int kImageWidth = 1334/3.2;
//static const int kImageHeight = 750/3.2;
static const int kPageButtonSideMargin = 10;
static const int kPageButtonBottomMargin = 20;
static const int kPageButtonHeight = 30;
static const int kPageButtonWidth = 100;


@implementation BXFStudentWorkPeiYinView

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

- (instancetype)initWithFrame:(CGRect)frame andVideoURL:(NSURL *)videoURL andSchedule:(NSArray *)scheduleArr {
    if(self = [super initWithFrame:frame]) {
        videoUrl = videoURL;
        schedule = [NSArray arrayWithArray:scheduleArr];
        
        [self initData];
        self.autoresizesSubviews = YES;
        
        [self addAvPlayer];
        
        UIButton *previousButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [previousButton setTitle:@"< Previous" forState:UIControlStateNormal];
        previousButton.frame = CGRectMake(kPageButtonSideMargin, self.bounds.size.height - kPageButtonHeight - kPageButtonBottomMargin, kPageButtonWidth, kPageButtonHeight);
        previousButton.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleRightMargin;
        [previousButton addTarget:nil action:@selector(previousStage:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:previousButton];
        
        UIButton *nextButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [nextButton setTitle:@"Next >" forState:UIControlStateNormal];
        nextButton.frame = CGRectMake(self.bounds.size.width - kPageButtonWidth - kPageButtonSideMargin, self.bounds.size.height - kPageButtonHeight - kPageButtonBottomMargin, kPageButtonWidth, kPageButtonHeight);
        nextButton.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin;
        [nextButton addTarget:nil action:@selector(nextStage:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:nextButton];
        
        UIButton *playButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [playButton setTitle:@"play" forState:UIControlStateNormal];
        playButton.frame = CGRectMake(self.bounds.size.width /2  - kPageButtonWidth, self.bounds.size.height - kPageButtonHeight - kPageButtonBottomMargin, kPageButtonWidth, kPageButtonHeight);
        playButton.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin;
        [playButton addTarget:nil action:@selector(playCurrentStage) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:playButton];
        
        UIButton *playAllButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [playAllButton setTitle:@"play all" forState:UIControlStateNormal];
        playAllButton.frame = CGRectMake(self.bounds.size.width /2 - kPageButtonWidth / 2, self.bounds.size.height - kPageButtonHeight - kPageButtonBottomMargin, kPageButtonWidth, kPageButtonHeight);
        playAllButton.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin;
        [playAllButton addTarget:nil action:@selector(playTotalVideo:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:playAllButton];
        
        UIButton *previewButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [previewButton setTitle:@"preview" forState:UIControlStateNormal];
        previewButton.frame = CGRectMake(self.bounds.size.width /2 + kPageButtonWidth / 2, self.bounds.size.height - kPageButtonHeight - kPageButtonBottomMargin, kPageButtonWidth, kPageButtonHeight);
        previewButton.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin;
        [previewButton addTarget:nil action:@selector(preview:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:previewButton];
        
    }
    return self;
}

- (void)initData {
    //    _pageImages = @[[UIImage imageNamed:@"K1-19A-248"], [UIImage imageNamed:@"K1-1A-2"]];
    //    _contentText= @[@"a cat says meow", @"hi, elmo"];
    _currentStage = 0;
    
    //playbackTimeObserver;
    totalTime = @"00:00/00:00";
    
    //    currentStartTime = 0.0f;
    //    currentEndTime = 0.0f;
    isPlayAll = YES;
    isPreview = NO;
    
    inStage = NO;
}

- (void)addAvPlayer {
    float imageWidth = self.bounds.size.width - kImageMargin * 2;
    float imageHeight = 750 * ( imageWidth / 1334);
    
    //NSURL *sourceMovieURL = [NSURL URLWithString:@"https://up2.v.sharedaka.com/video/ochvq0DnXEoqyzQMxScNGCXuecvs1546512175677.mp4"];
    
    AVAsset *movieAsset = [AVURLAsset URLAssetWithURL:videoUrl options:nil];
    
    AVPlayerItem *playerItem = [AVPlayerItem playerItemWithAsset:movieAsset];
    [playerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];// 监听status属性
    [playerItem addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];// 监听loadedTimeRanges属性
    player = [AVPlayer playerWithPlayerItem:playerItem];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(moviePlayDidEnd:) name:AVPlayerItemDidPlayToEndTimeNotification object:playerItem];
    
    AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:player];
    
    playerLayer.frame = CGRectMake(self.bounds.size.width - imageWidth - kImageMargin, kImageMargin, imageWidth, imageHeight);
    
    playerLayer.videoGravity = AVLayerVideoGravityResizeAspect;
    
    [self.layer addSublayer:playerLayer];
}

- (void)moviePlayDidEnd:(AVPlayerItem *)playerItem {
    
}

- (void)previousStage:(UIButton *)sender {
    [player pause];
    isPlayAll = NO;
    isPreview = NO;
    inStage = NO;
    _currentStage--;
    if(_currentStage < 0) {
        _currentStage = 0;
        NSLog(@"已经第一段了");
    }
    self.recordView.currentIndex = self.currentStage;
    self.titleView.titleLabel.text = [NSString stringWithFormat:@"已完成 %d/%d", _currentStage, (int)schedule.count];
    //CGFloat currentStartTime = [schedule[self.currentStage][0] floatValue];
    //currentEndTime = [_schedule[_currentStage][1] floatValue];
    //currentPageView.image = _pageImages[_currentPageIndex];
    [self playFrom:[schedule[self.currentStage][0] floatValue]];
    
}

- (void)playFrom:(CGFloat)startTime {
    //self.playBtn.selected = YES;
    NSTimeInterval second = startTime;//self.playSlider.value;
    
    __weak __typeof(self) wself = self;
    [player.currentItem seekToTime: CMTimeMake(second,1) completionHandler:^(BOOL finished){
        __strong typeof(wself) sself = wself;
        [sself->player play];
    }];
    //[self timerStar];
}

- (void)playCurrentStage {
    //self.playBtn.selected = YES;
    isPlayAll = NO;
    NSTimeInterval second = [schedule[_currentStage][0] floatValue];//self.playSlider.value;
    __weak __typeof(self) wself = self;
    
    [player.currentItem seekToTime: CMTimeMake(second,1) completionHandler:^(BOOL finished){
        __strong typeof(wself) sself = wself;
        [sself->player play];
    }];
    //[self timerStar];
}


- (void)nextStage:(UIButton *)sender {
    [player pause];
    isPlayAll = NO;
    isPreview = NO;
    inStage = NO;
    _currentStage++;
    if(_currentStage >= schedule.count) {
        _currentStage = (int)schedule.count - 1;
        NSLog(@"已经最后页了");
    }
    //currentPageView.image = _pageImages[_currentPageIndex];
    self.recordView.currentIndex = self.currentStage;
    self.titleView.titleLabel.text = [NSString stringWithFormat:@"已完成 %d/%d", _currentStage, (int)schedule.count];
    //currentPageView.image = _pageImages[_currentPageIndex];
    [self playFrom: [schedule[self.currentStage][0] floatValue]];
    
}

- (void)playTotalVideo:(UIButton *)sender {
    isPlayAll = YES;
    isPreview = NO;
    inStage = NO;
    _currentStage = 0;
    self.recordView.currentIndex = 0;
    //    NSTimeInterval second = [schedule[_currentStage][0] floatValue];//self.playSlider.value;
    __weak typeof(self) wself = self;
    [player.currentItem seekToTime: CMTimeMake(0,1) completionHandler:^(BOOL finished){
        [sender setTitle:@"STOP" forState:UIControlStateNormal];
        [sender removeTarget:nil action:@selector(playTotalVideo:) forControlEvents:UIControlEventTouchUpInside];
        [sender addTarget:nil action:@selector(stopPlayTotalVideo:) forControlEvents:UIControlEventTouchUpInside];
        
        __strong typeof(wself) sself = wself;
        [sself->player play];
    }];
    
}

- (void)stopPlayTotalVideo:(UIButton *)sender {
    [player pause];
    isPreview = NO;
    
    __weak typeof(self) wself = self;
    [player.currentItem seekToTime: CMTimeMake([schedule[0][0] floatValue],1) completionHandler:^(BOOL finished){
        __strong typeof(wself) sself = wself;
        
        [sender setTitle:@"Play All" forState:UIControlStateNormal];
        [sender removeTarget:nil action:@selector(stopPlayTotalVideo:) forControlEvents:UIControlEventTouchUpInside];
        [sender addTarget:nil action:@selector(playTotalVideo:) forControlEvents:UIControlEventTouchUpInside];
        sself->player.muted = NO;
        sself->inStage = NO;
    }];
    
}

- (void)turnToFirstStage {
    [player pause];
    
    self.recordView.currentIndex = _currentStage = 0;
    __weak typeof(self) wself = self;
    [player.currentItem seekToTime: CMTimeMake([schedule[0][0] floatValue],1) completionHandler:^(BOOL finished){
        __strong typeof(wself) sself = wself;
        sself->isPreview = NO;
        sself->inStage = NO;
        sself->player.muted = NO;
        self.titleView.titleLabel.text = [NSString stringWithFormat:@"已完成 %d/%d 平均分：%0.2f", [self.recordView compeleteCount], (int)(sself->schedule.count), [self.recordView average]];
        
    }];
}

/*
 - (void)playOriginSound {
 
 NSError *error = nil;
 audioPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL fileURLWithPath:self.originSound[self.currentPageIndex]] error:&error];
 //设置代理
 audioPlayer.delegate = self;
 
 //将播放文件加载到缓冲区
 [audioPlayer prepareToPlay];
 
 
 AVAudioSession *session = [AVAudioSession sharedInstance];
 
 NSError *sessionError;
 
 [session setCategory:AVAudioSessionCategoryPlayAndRecord error:&sessionError];
 
 UInt32 audioRouteOverride = kAudioSessionOverrideAudioRoute_Speaker;
 AudioSessionSetProperty (
 kAudioSessionProperty_OverrideAudioRoute,
 sizeof (audioRouteOverride),
 &audioRouteOverride
 );
 if(session == nil)
 NSLog(@"Error creating session: %@", [sessionError description]);
 else
 [session setActive:YES error:nil];
 
 if (!audioPlayer.isPlaying) {
 [audioPlayer play];
 }
 }
 */

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    AVPlayerItem *playerItem = (AVPlayerItem *)object;
    if ([keyPath isEqualToString:@"status"]) {
        if ([playerItem status] == AVPlayerStatusReadyToPlay) {
            NSLog(@"AVPlayerStatusReadyToPlay");
            //self.stateButton.enabled = YES;
            CMTime duration = playerItem.duration;// 获取视频总长度
            CGFloat totalSecond = playerItem.duration.value / playerItem.duration.timescale;// 转换成秒
            totalTime = [self convertTime:totalSecond];// 转换成播放时间
            [self customVideoSlider:duration];// 自定义UISlider外观
            //NSLog(@"movie total duration:%f",CMTimeGetSeconds(duration));
            [self monitoringPlayback: playerItem];// 监听播放状态
            //[player play];
        } else if ([playerItem status] == AVPlayerStatusFailed) {
            NSLog(@"AVPlayerStatusFailed");
        }
    } else if ([keyPath isEqualToString:@"loadedTimeRanges"]) {
        NSTimeInterval timeInterval = [self availableDuration];// 计算缓冲进度
        NSLog(@"Time Interval:%f",timeInterval);
        //CMTime duration = self.playerItem.duration;
        //CGFloat totalDuration = CMTimeGetSeconds(duration);
        //[self.videoProgress setProgress:timeInterval / totalDuration animated:YES];
    }
}

- (NSTimeInterval)availableDuration {
    NSArray *loadedTimeRanges = [[player currentItem] loadedTimeRanges];
    CMTimeRange timeRange = [loadedTimeRanges.firstObject CMTimeRangeValue];// 获取缓冲区域
    float startSeconds = CMTimeGetSeconds(timeRange.start);
    float durationSeconds = CMTimeGetSeconds(timeRange.duration);
    NSTimeInterval result = startSeconds + durationSeconds;// 计算缓冲总进度
    return result;
}

- (NSString *)convertTime:(CGFloat)second{
    NSDate *d = [NSDate dateWithTimeIntervalSince1970:second];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    if (second/3600 >= 1) {
        [formatter setDateFormat:@"HH:mm:ss"];
    } else {
        [formatter setDateFormat:@"mm:ss"];
    }
    NSString *showtimeNew = [formatter stringFromDate:d];
    return showtimeNew;
}

- (void)monitoringPlayback:(AVPlayerItem *)playerItem {
    __weak __typeof(self) wself = self;
    NSString *tmpTotalTime = [totalTime copy];
    
    //BOOL tmpIsPlayAll = isPlayAll;
    
    [player addPeriodicTimeObserverForInterval:CMTimeMake(1, 1) queue:NULL usingBlock:^(CMTime time) {
        CGFloat currentSecond = playerItem.currentTime.value/playerItem.currentTime.timescale;// 计算当前在第几秒
        //[self updateVideoSlider:currentSecond];
        NSString *timeString = [wself convertTime:currentSecond];
        //self.timeLabel.text = [NSString stringWithFormat:@"%@/%@", timeString, totalTime];
        NSLog(@"%@/%@", timeString, tmpTotalTime);
        __strong typeof(wself) sself = wself;
        
        CGFloat currentStartTime = [sself->schedule[wself.currentStage][0] floatValue];
        CGFloat currentEndTime = [sself->schedule[wself.currentStage][1] floatValue];
        NSLog(@"%f", currentStartTime);
        if ((currentSecond >= currentStartTime) && (currentSecond < currentEndTime) && (!sself->inStage)){
            sself->inStage = YES;
            if ((sself->isPreview) && ([wself.recordView currentScore] > 0.00f)) {
                if(!sself->player.isMuted) {
                    sself->player.muted = YES;
                }
                if(!sself->audioPlayer.isPlaying) {
                    [wself playSoundOfURL:wself.recordView.recordedSoundURLs[wself.currentStage]];
                }
            }
        }
        
        if ((currentSecond > currentEndTime) && (sself->inStage)) {
            sself->inStage = NO;
            
            if (!sself->isPlayAll) {//仅播放当前段的话停止
                [sself->player pause];
            } else {
                if (sself->player.isMuted) {
                    sself->player.muted = NO;
                }
                sself->_currentStage++;
                if(wself.currentStage >= sself->schedule.count) {
                    sself->_currentStage = (int)(sself->schedule.count) - 1;
                    NSLog(@"已经最后页了");
                } else {
                    //currentPageView.image = _pageImages[_currentPageIndex];
                    wself.recordView.currentIndex = wself.currentStage;
                    //self.titleView.titleLabel.text = [NSString stringWithFormat:@"已完成 %d/%d", _currentStage, (int)schedule.count];
                    //currentPageView.image = _pageImages[_currentPageIndex];
                    //[self playFrom: [schedule[self.currentStage][0] floatValue]];
                }
            }
        }
        
    }];
}

- (void)customVideoSlider:(CMTime)duration {
    videoSlider.maximumValue = CMTimeGetSeconds(duration);
    UIGraphicsBeginImageContextWithOptions((CGSize){ 1, 1 }, NO, 0.0f);
    UIImage *transparentImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    [videoSlider setMinimumTrackImage:transparentImage forState:UIControlStateNormal];
    [videoSlider setMaximumTrackImage:transparentImage forState:UIControlStateNormal];
}

- (void)preview:(UIButton *)sender {
    isPreview = YES;
    isPlayAll = YES;
    inStage = NO;
    _currentStage = 0;
    player.muted = NO;
    self.recordView.currentIndex = 0;
    //    NSTimeInterval second = [schedule[_currentStage][0] floatValue];//self.playSlider.value;
    __weak typeof(self) wself = self;
    [player.currentItem seekToTime: CMTimeMake(0,1) completionHandler:^(BOOL finished){
        __strong typeof(wself) sself = wself;
        [sself->player play];
        
        [sender setTitle:@"STOP" forState:UIControlStateNormal];
        [sender removeTarget:nil action:@selector(preview:) forControlEvents:UIControlEventTouchUpInside];
        [sender addTarget:nil action:@selector(stopPreview:) forControlEvents:UIControlEventTouchUpInside];
        
    }];
}

- (void)stopPreview:(UIButton *)sender {
    [player pause];
    isPreview = NO;
    
    __weak typeof(self) wself = self;
    
    [player.currentItem seekToTime: CMTimeMake([schedule[0][0] floatValue],1) completionHandler:^(BOOL finished){
        [sender setTitle:@"PREVIEW" forState:UIControlStateNormal];
        [sender removeTarget:nil action:@selector(stopPreview:) forControlEvents:UIControlEventTouchUpInside];
        [sender addTarget:nil action:@selector(preview:) forControlEvents:UIControlEventTouchUpInside];
        
        __strong typeof(wself) sself = wself;
        sself->player.muted = NO;
    }];
    
}

- (void)playSoundOfURL:(NSURL *)soundURL{
    
    NSError *error = nil;
    audioPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:soundURL error:&error];
    //设置代理
    audioPlayer.delegate = self;
    
    //将播放文件加载到缓冲区
    [audioPlayer prepareToPlay];
    
    
    AVAudioSession *session = [AVAudioSession sharedInstance];
    
    NSError *sessionError;
    
    [session setCategory:AVAudioSessionCategoryPlayAndRecord error:&sessionError];
    
    UInt32 audioRouteOverride = kAudioSessionOverrideAudioRoute_Speaker;
    AudioSessionSetProperty (
                             kAudioSessionProperty_OverrideAudioRoute,
                             sizeof (audioRouteOverride),
                             &audioRouteOverride
                             );
    if(session == nil)
        NSLog(@"Error creating session: %@", [sessionError description]);
    else
        [session setActive:YES error:nil];
    
    if (!audioPlayer.isPlaying) {
        [audioPlayer play];
    }
}

//- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag {
//    if (isPlayAll) {
//        if([self nextPage:nil]) {
//            if (!isPreview) {
//                [self playSoundOfURL:originSoundURLs[self.currentPageIndex]];
//            } else {
//                if (self.recordView.currentScore > 0.00f) {
//                    [self playSoundOfURL:self.recordView.recordedSoundURLs[self.currentPageIndex]];
//                } else {
//                    [self playSoundOfURL:originSoundURLs[self.currentPageIndex]];
//                }
//            }
//        } else {
//            [self turnToFirstPage];
//            UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"播放完毕" message:nil delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
//            [av show];
//        }
//    }
//}

@end

