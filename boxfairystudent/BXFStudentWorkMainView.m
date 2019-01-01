//
//  BXFStudentWorkMainView.m
//  boxfairystudent
//
//  Created by 包炯 on 2018/12/24.
//  Copyright © 2018 包炯. All rights reserved.
//

#import "BXFStudentWorkMainView.h"

static const int kImageMargin = 15;
//static const int kImageWidth = 1334/3.2;
//static const int kImageHeight = 750/3.2;
static const int kPageButtonSideMargin = 10;
static const int kPageButtonBottomMargin = 20;
static const int kPageButtonHeight = 30;
static const int kPageButtonWidth = 100;

@implementation BXFStudentWorkMainView

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
        
        currentPageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.bounds.size.width - imageWidth - kImageMargin, kImageMargin, imageWidth, imageHeight)];
        currentPageView.image = _pageImages[_currentPageIndex];
        currentPageView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin;
        [self addSubview:currentPageView];
        
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
        playButton.frame = CGRectMake(self.bounds.size.width /2  - kPageButtonWidth, self.bounds.size.height - kPageButtonHeight - kPageButtonBottomMargin, kPageButtonWidth, kPageButtonHeight);
        playButton.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin;
        [playButton addTarget:nil action:@selector(playOriginSound) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:playButton];
        
        UIButton *playAllButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [playAllButton setTitle:@"play all" forState:UIControlStateNormal];
        playAllButton.frame = CGRectMake(self.bounds.size.width /2, self.bounds.size.height - kPageButtonHeight - kPageButtonBottomMargin, kPageButtonWidth, kPageButtonHeight);
        playAllButton.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin;
        [playAllButton addTarget:nil action:@selector(playAllOriginSound) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:playAllButton];
        
    }
    return self;
}

- (void)initData {
//    _pageImages = @[[UIImage imageNamed:@"K1-19A-248"], [UIImage imageNamed:@"K1-1A-2"]];
//    _contentText= @[@"a cat says meow", @"hi, elmo"];
    _currentPageIndex = 0;
}

- (void)previousPage:(UIButton *)sender {
    _currentPageIndex--;
    if(_currentPageIndex < 0) {
        _currentPageIndex = 0;
        NSLog(@"已经第一页了");
    } else {
        currentPageView.image = _pageImages[_currentPageIndex];
        self.recordView.sentenceText = _contentText[_currentPageIndex];
        self.titleView.titleLabel.text = [NSString stringWithFormat:@"已完成 %d/%d", _currentPageIndex, _pageImages.count];
    }
}

- (BOOL)nextPage:(UIButton *)sender {
    _currentPageIndex++;
    if(_currentPageIndex >= _pageImages.count) {
        _currentPageIndex = (int)_pageImages.count - 1;
        NSLog(@"已经最后页了");
        return false;
    } else {
        currentPageView.image = _pageImages[_currentPageIndex];
        self.recordView.sentenceText = _contentText[_currentPageIndex];
        self.titleView.titleLabel.text = [NSString stringWithFormat:@"已完成 %d/%d", _currentPageIndex, _pageImages.count];
        return true;
    }
}

- (void)playOriginSound {
        
        NSError *error = nil;
        audioPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:self.originSound[self.currentPageIndex] error:&error];
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

- (void)playAllOriginSound {
    [self turnToFirstPage];
    [self playOriginSound];
    
}

- (void)turnToFirstPage {
    _currentPageIndex = 0;
    currentPageView.image = self.pageImages[_currentPageIndex];
    self.recordView.sentenceText = self.contentText[_currentPageIndex];
}

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag {
       if([self nextPage:nil]) {
           [self playOriginSound];
       } else {
           [self turnToFirstPage];
           UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"播放完毕" message:nil delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
           [av show];
       }
}

@end
