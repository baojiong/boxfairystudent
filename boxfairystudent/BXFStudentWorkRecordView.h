//
//  BXFStudentWorkRecordView.h
//  boxfairystudent
//
//  Created by 包炯 on 2018/12/24.
//  Copyright © 2018 包炯. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "IFlyMSC/IFlyMSC.h"
#import "ISEResult.h"
#import "ISEResultXmlParser.h"


NS_ASSUME_NONNULL_BEGIN

@class ISEParams;

@interface BXFStudentWorkRecordView : UIView <AVAudioRecorderDelegate, AVAudioPlayerDelegate, IFlySpeechEvaluatorDelegate ,ISEResultXmlParserDelegate> {
    AVAudioRecorder *audioRecorder;
    AVAudioPlayer *audioPlayer;
    int countNum;
    NSTimer *timer1;
    NSString *mp3PathStr;
    NSString *cafPathStr;
    
    IFlySpeechEvaluator *speechEvaluator;
    
    UILabel *sentenceLabel;
    UILabel *scoreLabel;
    
    NSMutableArray *recordings;
    
    NSArray *sentenceText;
    
    NSMutableArray *scores;
}

@property (nonatomic, strong) ISEParams *iseParams;
@property(nonatomic, assign) int currentIndex;
@property(nonatomic, copy) NSMutableArray *recordedSoundURLs;


- (instancetype)initWithFrame:(CGRect)frame andContentText:(NSArray *)sentences;

- (int)compeleteCount;
- (BOOL)isCompelete;
- (CGFloat)average;
- (CGFloat)currentScore;

@end

NS_ASSUME_NONNULL_END
