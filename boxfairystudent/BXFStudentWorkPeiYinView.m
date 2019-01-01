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

- (instancetype)initWithFrame:(CGRect)frame {
    if(self = [super initWithFrame:frame]) {
        [self initData];
        self.autoresizesSubviews = YES;
        
        float imageWidth = self.bounds.size.width - kImageMargin * 2;
        float imageHeight = 750 * ( imageWidth / 1334);
        
        
        UIButton *previousButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [previousButton setTitle:@"< Previous" forState:UIControlStateNormal];
        previousButton.frame = CGRectMake(kPageButtonSideMargin, self.bounds.size.height - kPageButtonHeight - kPageButtonBottomMargin, kPageButtonWidth, kPageButtonHeight);
        previousButton.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleRightMargin;
        [previousButton addTarget:nil action:@selector(previousPage:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:previousButton];
        
        UIButton *nextButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [nextButton setTitle:@"Next >" forState:UIControlStateNormal];
        nextButton.frame = CGRectMake(self.bounds.size.width - kPageButtonWidth - kPageButtonSideMargin, self.bounds.size.height - kPageButtonHeight - kPageButtonBottomMargin, kPageButtonWidth, kPageButtonHeight);
        nextButton.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin;
        [nextButton addTarget:nil action:@selector(nextPage:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:nextButton];
        
        UIButton *playButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [playButton setTitle:@"play" forState:UIControlStateNormal];
        playButton.frame = CGRectMake(self.bounds.size.width /2  - kPageButtonWidth/2, self.bounds.size.height - kPageButtonHeight - kPageButtonBottomMargin, kPageButtonWidth, kPageButtonHeight);
        playButton.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin;
        [playButton addTarget:nil action:@selector(playOriginSound:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:playButton];
        
    }
    return self;
}

- (void)initData {
    //    _pageImages = @[[UIImage imageNamed:@"K1-19A-248"], [UIImage imageNamed:@"K1-1A-2"]];
    //    _contentText= @[@"a cat says meow", @"hi, elmo"];
    _currentSoundIndex = 0;
}

/*
- (void)previousPage:(UIButton *)sender {
    _currentSoundIndex--;
    if(_currentSoundIndex < 0) {
        _currentSoundIndex = 0;
        NSLog(@"已经第一页了");
    } else {
        currentPageView.image = _pageImages[_currentPageIndex];
        self.recordView.sentenceText = _contentText[_currentPageIndex];
        self.titleView.titleLabel.text = [NSString stringWithFormat:@"已完成 %d/%d", _currentPageIndex, _pageImages.count];
    }
}

- (void)nextPage:(UIButton *)sender {
    _currentSoundIndex++;
    if(_currentSoundIndex >= _pageImages.count) {
        _currentSoundIndex = (int)_pageImages.count - 1;
        NSLog(@"已经最后页了");
    } else {
        currentPageView.image = _pageImages[_currentPageIndex];
        self.recordView.sentenceText = _contentText[_currentPageIndex];
        self.titleView.titleLabel.text = [NSString stringWithFormat:@"已完成 %d/%d", _currentPageIndex, _pageImages.count];
    }
}

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


@end
