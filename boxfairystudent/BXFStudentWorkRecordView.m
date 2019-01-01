//
//  BXFStudentWorkRecordView.m
//  boxfairystudent
//
//  Created by 包炯 on 2018/12/24.
//  Copyright © 2018 包炯. All rights reserved.
//

#import "BXFStudentWorkRecordView.h"
#import "ISEParams.h"
#import <AudioToolbox/AudioToolbox.h>

static const int kSentenceLabelMargin = 30;
static const int kSentenceLabelHeight = 30;

static const int kRecordButtonBottomMargin = 40;
static const int kRecordButtonDiameter = 50;

static const int kPlayButtonLeftMargin = 20;

#define margin 15
#define kSandboxPathStr [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]
#define kCafFileName @"myRecord.caf"

/**
 *存放所有的音乐播放器
 */
static NSMutableDictionary *musices;

@implementation BXFStudentWorkRecordView

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
        [self initUI];
        
        [self initIflySpeechEvaluator];
    }
    return self;
}

- (void)initData {
    _sentenceText = @"";//@[@"a cat says meow", @"Hi, Elmo"];
    cafPathStr = [kSandboxPathStr stringByAppendingPathComponent:kCafFileName];
}

- (void)initUI {
    self.autoresizesSubviews = YES;
    
    sentenceLabel = [[UILabel alloc] initWithFrame:CGRectMake(kSentenceLabelMargin, kSentenceLabelMargin, self.bounds.size.width - kSentenceLabelMargin * 2, kSentenceLabelHeight)];
    sentenceLabel.text = _sentenceText;
    sentenceLabel.textAlignment = NSTextAlignmentCenter;
    sentenceLabel.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin;
    [self addSubview:sentenceLabel];
    
    scoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(kSentenceLabelMargin, kSentenceLabelMargin + 200, self.bounds.size.width - kSentenceLabelMargin * 2, kSentenceLabelHeight)];
    scoreLabel.textAlignment = NSTextAlignmentCenter;
    scoreLabel.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin;
    [self addSubview:scoreLabel];
    
    UILongPressGestureRecognizer *longPressRec = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPress:)];
    UITapGestureRecognizer *tapRec = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(stopRecording:)];
    UIImageView *recImageButton = [[UIImageView alloc] initWithFrame:CGRectMake(self.bounds.size.width / 2 - kRecordButtonDiameter / 2, self.bounds.size.height - kRecordButtonBottomMargin - kRecordButtonDiameter, kRecordButtonDiameter, kRecordButtonDiameter)];
    recImageButton.image = [UIImage imageNamed:@"录音"];
//    [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"录音"]];
  //  recImageButton.frame = CGRectMake(self.center.x - kRecordButtonDiameter / 2, self.bounds.size.height - kRecordButtonBottomMargin, kRecordButtonDiameter, kRecordButtonDiameter);
    recImageButton.userInteractionEnabled = YES;
    [recImageButton addGestureRecognizer:longPressRec];
    [recImageButton addGestureRecognizer:tapRec];
    [self addSubview:recImageButton];
    
    UITapGestureRecognizer *tapPlay = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(play:)];
    UIImageView *playImageButton = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"播放"]];
    float playButtonDiameter = kRecordButtonDiameter * 0.8;
    playImageButton.frame = CGRectMake(kPlayButtonLeftMargin, self.bounds.size.height - kRecordButtonBottomMargin - playButtonDiameter, playButtonDiameter, playButtonDiameter);
    playImageButton.userInteractionEnabled = YES;
    [playImageButton addGestureRecognizer:tapPlay];
    [self addSubview:playImageButton];
    
//    UIButton *recordButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    recordButton.frame = CGRectMake(self.bounds.size.width / 2 - kRecordButtonDiameter / 2, 30, kRecordButtonDiameter, kRecordButtonDiameter);
//    //recordButton.frame = CGRectMake(self.center.x - kRecordButtonDiameter / 2, self.bounds.size.height - kRecordButtonMargin - kRecordButtonDiameter / 2, kRecordButtonDiameter, kRecordButtonDiameter);
//    //recordButton.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin;
//    [recordButton setTitle:@"Record" forState:UIControlStateNormal];
//    [recordButton addTarget:nil action:@selector(startRecording:) forControlEvents:UIControlEventTouchDown];
//    [recordButton addTarget:nil action:@selector(stopRecording:) forControlEvents:UIControlEventTouchUpInside];
//    [self addSubview:recordButton];
//
//    UIButton *playButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    playButton.frame = CGRectMake(self.bounds.size.width / 2 - kRecordButtonDiameter / 2, 100, kRecordButtonDiameter, kRecordButtonDiameter);
//    //recordButton.frame = CGRectMake(self.center.x - kRecordButtonDiameter / 2, self.bounds.size.height - kRecordButtonMargin - kRecordButtonDiameter / 2, kRecordButtonDiameter, kRecordButtonDiameter);
//    //recordButton.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin;
//    [playButton setTitle:@"Play" forState:UIControlStateNormal];
//    [playButton addTarget:nil action:@selector(play:) forControlEvents:UIControlEventTouchUpInside];
//    [self addSubview:playButton];
}

- (void)selectHeaderImage:(UITapGestureRecognizer *)sender {
    UITapGestureRecognizer *tap = (UITapGestureRecognizer *)sender;
    UIViewController *vc;
    switch (tap.view.tag) {
        case 1: {
        }
    }
}

- (void)longPress:(UIGestureRecognizer *)gestrue {
    //直接return掉，不在开始的状态里面添加任何操作，则长按手势就会被少调用一次了
    if (gestrue.state == UIGestureRecognizerStateBegan) {
        [self startRecording:nil];
    } else if (gestrue.state == UIGestureRecognizerStateEnded) {
        [self stopRecording:nil];
    }
}

- (void)startRecording:(UIButton *)sender {
    NSLog(@"press record button");
    cafPathStr = [kSandboxPathStr stringByAppendingPathComponent:kCafFileName];
    [self createAudioRecorder];
    [self startRecordNotice];
}

- (void)stopRecording:(UIButton *)sender {
    NSLog(@"release record button");
    [self stopRecordNotice];
}

- (void)play:(UIButton *)sender {
    NSLog(@"play button pressed");
    [self createAudioPlayer];
    [self startPlayNotice];
}

- (void)changeRecordTime {
    countNum += 1;
    int min = countNum/60;
    int sec = countNum - min*60;
    //   NSInteger sec = self.countNum;
    
    //self.timeLabel.text = [NSString stringWithFormat:@"%02ld:%02ld",(long)min,(long)sec];
    
    if (sec == 59) {
        [self stopRecordNotice];
    }
}

- (void)startRecordNotice{
    //self.timeLabel2.text = @"";
    
    [self stopMusicWithUrl:[NSURL URLWithString:cafPathStr]];
    
    if ([audioRecorder isRecording]) {
        [audioRecorder stop];
    }
    
    NSLog(@"----------开始录音----------");
    [self deleteOldRecordFile];
    //    如果不删掉，会在原文件基础上录制；虽然不会播放原来的声音，但是音频长度会是录制的最大长度。
    
    AVAudioSession *audioSession=[AVAudioSession sharedInstance];
    [audioSession setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
    
    if (![audioRecorder isRecording]){
        //    {0--停止、暂停，1-录制中
        [audioRecorder record];
        //    首次使用应用时如果调用record方法会询问用户是否允许使用麦克风
        countNum = 0;
        NSTimeInterval timeInterval = 1;
        //    0.1s
        timer1 = [NSTimer scheduledTimerWithTimeInterval:timeInterval  target:self selector:@selector(changeRecordTime)  userInfo:nil  repeats:YES];
        [timer1 fire];
    }
    //noticeLabel.text = @"脱离按钮，松开手指放弃录音";
}

- (void)stopRecordNotice
{
    NSLog(@"----------结束录音----------");
    [audioRecorder stop];
    [timer1 invalidate];
    
    //    计算文件大小
    long long fileSize = [self fileSizeAtPath:cafPathStr]/1024.0;
    NSString *fileSizeStr = [NSString stringWithFormat:@"%lld",fileSize];
    NSLog(@"%ld \" %@kb  ",(long)countNum,fileSizeStr);
    //self.timeLabel2.text = [NSString stringWithFormat:@"%ld \" %@kb  ",(long)self.countNum,fileSizeStr];
    //self.timeLabel.text = @"01:00";
    
    //[self.delegate getRecordData:self.mp3PathStr type:@"2" fileName:kMp3FileName];
    
    //[self removeFromSuperview];
}


- (void)cancelRecordNotice
{
    //    NSLog(@"----------取消录音----------");
    [audioRecorder stop];
    [timer1 invalidate];
    
    //    计算文件大小
    long long fileSize = [self fileSizeAtPath:cafPathStr]/1024.0;
    NSString *fileSizeStr = [NSString stringWithFormat:@"%lld",fileSize];
    
    //self.timeLabel2.text = [NSString stringWithFormat:@"%ld \" %@kb  ", (long)self.countNum,fileSizeStr];
    //self.timeLabel.text = @"00:00";
    
    //noticeLabel.text = @"按住不放录制语音";
}

//删除旧录音缓存
-(void)deleteOldRecordFile{
    NSFileManager* fileManager = [NSFileManager defaultManager];
    
    BOOL fileExist = [[NSFileManager defaultManager] fileExistsAtPath:cafPathStr];
    if (!fileExist) {
        NSLog(@"不存在");
        return ;
    }else {
        NSLog(@"存在");
        BOOL blDele= [fileManager removeItemAtPath:cafPathStr error:nil];
        if (blDele) {
            NSLog(@"删除成功");
        }else {
            NSLog(@"删除失败");
        }
    }
}

#pragma mark -  Getter
/**
 *  获得录音机对象
 *
 *  @return 录音机对象
 */
- (AVAudioRecorder *)createAudioRecorder{

    if (!audioRecorder) {
        //创建录音文件保存路径
        NSURL *url=[NSURL URLWithString:cafPathStr];
        //创建录音格式设置
        NSDictionary *setting=[self getAudioSetting];
        //创建录音机
        NSError *error=nil;
        
        audioRecorder = [[AVAudioRecorder alloc]initWithURL:url settings:setting error:&error];
        audioRecorder.delegate = self;
        audioRecorder.meteringEnabled = YES;//如果要监控声波则必须设置为YES
        if (error) {
            NSLog(@"创建录音机对象时发生错误，错误信息：%@",error.localizedDescription);
            return nil;
        }
    }
    return audioRecorder;
}

/**
 *  取得录音文件设置
 *
 *  @return 录音设置
 */
-(NSDictionary *)getAudioSetting{
    //LinearPCM 是iOS的一种无损编码格式,但是体积较为庞大
    //录音设置
    NSMutableDictionary *recordSettings = [[NSMutableDictionary alloc] init];
    //录音格式 无法使用
    [recordSettings setValue :[NSNumber numberWithInt:kAudioFormatLinearPCM] forKey: AVFormatIDKey];
    //采样率
    [recordSettings setValue :[NSNumber numberWithFloat:11025.0] forKey: AVSampleRateKey];//44100.0
    //通道数
    [recordSettings setValue :[NSNumber numberWithInt:2] forKey: AVNumberOfChannelsKey];
    //线性采样位数
    //[recordSettings setValue :[NSNumber numberWithInt:16] forKey: AVLinearPCMBitDepthKey];
    //音频质量,采样质量
    [recordSettings setValue:[NSNumber numberWithInt:AVAudioQualityMin] forKey:AVEncoderAudioQualityKey];
    
    return recordSettings;
}

/**
 *停止播放音乐文件
 */
- (void)stopMusicWithUrl:(NSURL *)fileUrl{
    if (!fileUrl) return;//如果没有传入文件名，那么就直接返回
    
    //1.取出对应的播放器
    AVAudioPlayer *player = musices[fileUrl];
    
    //2.停止
    if ([player isPlaying]) {
        [player stop];
        //        NSLog(@"播放结束:%@--------",fileUrl);
    }
    
    if ([musices.allKeys containsObject:fileUrl]) {
        [musices removeObjectForKey:fileUrl];
    }
}

//单个文件的大小
- (long long) fileSizeAtPath:(NSString*)filePath{
    
    NSFileManager* manager = [NSFileManager defaultManager];
    
    if ([manager fileExistsAtPath:filePath]){
        
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
        
    }else{
        NSLog(@"计算文件大小：文件不存在");
    }
    
    return 0;
}

- (AVAudioPlayer *)createAudioPlayer {
        
        NSError *error = nil;
        
        audioPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL fileURLWithPath:cafPathStr] error:&error];
        //设置代理
        audioPlayer.delegate = self;
        
        //将播放文件加载到缓冲区
        [audioPlayer prepareToPlay];
    
    return audioPlayer;
}

- (void)startPlayNotice {
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

#pragma mark -  AVAudioRecorder  Delegate
- (void)audioRecorderDidFinishRecording:(AVAudioRecorder *)recorder successfully:(BOOL)flag {
    NSLog(@"录音完成");
    [self startEvaluate];
}//录音完成

#pragma mark - AVAudioPlayer  Delegate
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag {
    NSLog(@"播放完成");
    
}//播放器完成


- (void)initIflySpeechEvaluator {
    speechEvaluator = [IFlySpeechEvaluator sharedInstance];
    speechEvaluator.delegate = self;
    
    self.iseParams=[ISEParams fromUserDefaults];
    
    [speechEvaluator setParameter:self.iseParams.bos forKey:[IFlySpeechConstant VAD_BOS]];
    [speechEvaluator setParameter:self.iseParams.eos forKey:[IFlySpeechConstant VAD_EOS]];
    [speechEvaluator setParameter:self.iseParams.category forKey:[IFlySpeechConstant ISE_CATEGORY]];
    [speechEvaluator setParameter:self.iseParams.language forKey:[IFlySpeechConstant LANGUAGE]];
    [speechEvaluator setParameter:self.iseParams.rstLevel forKey:[IFlySpeechConstant ISE_RESULT_LEVEL]];
    [speechEvaluator setParameter:self.iseParams.timeout forKey:[IFlySpeechConstant SPEECH_TIMEOUT]];
    [speechEvaluator setParameter:self.iseParams.audioSource forKey:[IFlySpeechConstant AUDIO_SOURCE]];
    
//    [speechEvaluator setParameter:@"16000" forKey:[IFlySpeechConstant SAMPLE_RATE]];
//    [speechEvaluator setParameter:@"utf-8" forKey:[IFlySpeechConstant TEXT_ENCODING]];
//    [speechEvaluator setParameter:@"xml" forKey:[IFlySpeechConstant ISE_RESULT_TYPE]];
}

- (void)startEvaluate {
    
    //设置音频源为音频流（-1）
    [speechEvaluator setParameter:@"-1" forKey:@"audio_source"];
    NSStringEncoding encoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    
    NSMutableData *buffer = [NSMutableData dataWithData:[self.sentenceText dataUsingEncoding:encoding]];
    NSLog(@" \nen buffer length: %lu",(unsigned long)[buffer length]);
    
    //启动评测服务
    [speechEvaluator startListening: buffer params:nil];
    
    //写入音频数据
    NSData *data = [NSData dataWithContentsOfFile:cafPathStr];    //从文件中读取音频
    [speechEvaluator writeAudio:data];//写入音频，让SDK评测。建议将音频数据分段写入。
    
    //音频写入结束或出错时，必须调用结束评测接口
    [speechEvaluator stopListening];//音频数据写入完成，进入等待状态
}

#pragma mark - IFlySpeechEvaluatorDelegate

/*!
 *  volume callback,range from 0 to 30.
 */
//- (void)onVolumeChanged:(int)volume buffer:(NSData *)buffer {
//    //    NSLog(@"volume:%d",volume);
//    [self.popupView setText:[NSString stringWithFormat:@"%@：%d", NSLocalizedString(@"T_RecVol", nil),volume]];
//    [self.view addSubview:self.popupView];
//}

/*!
 *  Beginning Of Speech
 */
//- (void)onBeginOfSpeech {
//
//    if ([self.iseParams.audioSource isEqualToString:IFLY_AUDIO_SOURCE_STREAM]){
//        _isBeginOfSpeech =YES;
//    }
//
//}

/*!
 *  End Of Speech
 */
//- (void)onEndOfSpeech {
//
//    if ([self.iseParams.audioSource isEqualToString:IFLY_AUDIO_SOURCE_STREAM]){
//        [_pcmRecorder stop];
//    }
//
//}

/*!
 *  callback of canceling evaluation
 */
//- (void)onCancel {
//
//}

/*!
 *  evaluation session completion, which will be invoked no matter whether it exits error.
 *  error.errorCode =
 *  0     success
 *  other fail
 */
//- (void)onCompleted:(IFlySpeechError *)errorCode {
//    if(errorCode && errorCode.errorCode!=0){
//        [self.popupView setText:[NSString stringWithFormat:@"Error：%d %@",[errorCode errorCode],[errorCode errorDesc]]];
//        [self.view addSubview:self.popupView];
//
//    }
//
//    [self performSelectorOnMainThread:@selector(resetBtnSatus:) withObject:errorCode waitUntilDone:NO];
//
//}

/*!
 *  result callback of speech evaluation
 *  results：evaluation results
 *  isLast：whether or not this is the last result
 */
- (void)onResults:(NSData *)results isLast:(BOOL)isLast{
    if (results) {
        NSString *showText = @"";
        
        const char* chResult=[results bytes];
        BOOL isUTF8=[[speechEvaluator parameterForKey:[IFlySpeechConstant RESULT_ENCODING]]isEqualToString:@"utf-8"];
        NSString* strResults=nil;
        if(isUTF8){
            strResults=[[NSString alloc] initWithBytes:chResult length:[results length] encoding:NSUTF8StringEncoding];
        }else{
            NSLog(@"result encoding: gb2312");
            NSStringEncoding encoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
            strResults=[[NSString alloc] initWithBytes:chResult length:[results length] encoding:encoding];
        }
        if(strResults){
            showText = [showText stringByAppendingString:strResults];
        }
        
//        self.resultText=showText;
//        self.resultView.text = showText;
//        self.isSessionResultAppear=YES;
//        self.isSessionEnd=YES;
        if(isLast){
//            [self.popupView setText: NSLocalizedString(@"T_ISE_End", nil)];
//            [self.view addSubview:self.popupView];
            NSLog(showText);
            
            ISEResultXmlParser* parser=[[ISEResultXmlParser alloc] init];
            parser.delegate = self;
            [parser parserXml:strResults];
        }
        
    }
//    else{
//        if(isLast){
//            [self.popupView setText: NSLocalizedString(@"M_ISE_Msg", nil)];
//            [self.view addSubview:self.popupView];
//        }
//        self.isSessionEnd=YES;
//    }
//    self.startBtn.enabled=YES;
}

#pragma mark - ISEResultXmlParserDelegate

-(void)onISEResultXmlParser:(NSXMLParser *)parser Error:(NSError*)error{
    
}

/*
 
 等级    五分制分值    百分制分值
 优    4.3分~5分    86分~100分
 良    3.5分~4.2分    70分~85分
 中    2.5分~3.4分    50分~69分
 差    1.5分~2.4分    30分~49分
 很差    0分~1.4分    0分~29分
 */
-(void)onISEResultXmlParserResult:(ISEResult*)result{
    //self.resultView.text=[result toString];
    if(result.is_rejected) {
        scoreLabel.text = @"0.0";
        NSLog(@"0.0");
    } else if ([result.except_info isEqualToString:@"28673"] || //28673（音量小/无语音）
               [result.except_info isEqualToString:@"28680"] || //28680（信噪比低）
               [result.except_info isEqualToString:@"28690"]){  //28690（有截幅）
        NSLog(@"0.0");
        scoreLabel.text = @"0.0";
    } else {
        NSLog(@"%0.2f", result.total_score * 10 * 2);
        scoreLabel.text = [NSString stringWithFormat:@"%0.2f", result.total_score * 10 * 2];
    }
}

- (void)setSentenceText:(NSString *)sentenceText {
    _sentenceText = sentenceText;
    sentenceLabel.text = sentenceText;
}

//- (void)setCurrentIndex:(int)currentIndex {
//    _currentIndex = currentIndex;
//}

- (NSString *)uuidString
{
    CFUUIDRef uuid_ref = CFUUIDCreate(NULL);
    CFStringRef uuid_string_ref= CFUUIDCreateString(NULL, uuid_ref);
    NSString *uuid = [NSString stringWithString:(__bridge NSString *)uuid_string_ref];
    CFRelease(uuid_ref);
    CFRelease(uuid_string_ref);
    return [uuid lowercaseString];
}

@end

/*
 同一个句子，用美式发音读和用英式发音读，哪个得分会高些
 
 引擎支持多发音匹配，会自动匹配发音。如果匹配出是美式发音，就按美式发音进行评分；如果匹配出是英式发音，就按英式发音进行评分。
 用户也可以通过试卷标注指定发音，标注方法请参见 试卷制作 中英文单词自定义发音。
 XML中的beg_pos和end_pos可以怎么使用
 
 beg_pos 和 end_pos 标记了对应节点下内容在语音中的边界，单位是帧，每帧10ms，例如一个单词“word“，其 beg_pos = n1，end_pos = n2，那么在语音中，“word”的位置在 n1*10ms 到 n2*10ms。
 
 XML中的dp_message可以怎么使用
 
 dp_message标记内容的切分信息，当值为0时，表示正常；值为16，表示漏读，值为32表示增读。
 在解析效果的时候，如果遇到dp_message不为 0 的情况，要进行相应的处理。一般情况下，word节点下dp_message值为16的时候，相关的效果信息都会缺失；值为32的时候，会选择得分最高的word节点作为最终结果。
 为什么个别单词打分不准，如：打分不高或者不符合预期
 
 我们的单词音标兼顾了各种发音的可能，如果您的发音恰好是其中一种，但您的预期是不应该打高分时，就会产生误差，建议您自己定义该单词发音，具体使用方法请参见 试卷制作 中英文单词自定义发音。
 我们的评分标准参考了每个音素的得分情况，对于发音相近的音素或单词，引擎会产生混淆。例如单词“about”和“above”，这样有可能造成打分不准。
 对于极个别人的发音，由于声学模型限制，可能识别不准，所以导致评测也有可能不准。
 如果，以上解答仍有疑问，可联系我们，提供相关音频数据和试卷内容，我们具体分析后再做答复。
 
 乱说、乱读得高分的问题怎么解决
 
 评测结果中会给出 is_rejected 字段，当字段值为 true 时，说明此时是用户乱说导致的拒识，开发者可根据这个字段判断此次用户是否为乱说。
 在拒识的同时依然会给出得分，因为目前识别乱说的准确率没有100%，所以存在误拒的情况。如果引擎给0分的话，也不合适。
 引擎可以检测出来用户是乱说的，但无法保证一定是低分。所以说，如果引擎报出乱说，那么就可以认为评分已经不可信。这种情况下，开发者可以给用户显示 0 分，也可以在显示引擎分数的同时，给出乱说的检测结果。这个由开发者自己来决定哪一种方式更合适。
 还有个属性字段 except_info，如果其属性值为28673（音量小/无语音），28680（信噪比低），28690（有截幅），则说明使用环境存在问题，打分也是不可信的。
 结果评分分值与日常经验中的优、良、中、差的对应关系
 
 其实这两者之间并没有严格的对应关系，以下对应关系仅供参考：
 
 等级    五分制分值    百分制分值
 优    4.3分~5分    86分~100分
 良    3.5分~4.2分    70分~85分
 中    2.5分~3.4分    50分~69分
 差    1.5分~2.4分    30分~49分
 很差    0分~1.4分    0分~29分

 */
