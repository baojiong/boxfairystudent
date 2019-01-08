//
//  BXFStudentWorkViewController.m
//  boxfairystudent
//
//  Created by 包炯 on 2018/12/24.
//  Copyright © 2018 包炯. All rights reserved.
//

#import "BXFStudentWorkViewController.h"


static const int kTitleBarWidth =450;
static const int kTitleBarHeight = 48;

@interface BXFStudentWorkViewController () 

@end

@implementation BXFStudentWorkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor grayColor];
    //self.view.autoresizesSubviews = YES;
    
    titleView = [[BXFStudentWorkTitleView alloc] initWithFrame:CGRectMake(0, 0, kTitleBarWidth, kTitleBarHeight)];
    titleView.backgroundColor = [UIColor whiteColor];
    titleView.typeLabel.text = self.pageInfo[@"type"];
    backButton.frame = CGRectMake(15, 15, 20, 20);
    [titleView addSubview:backButton];
    [self.view addSubview:titleView];
    
    NSMutableArray *pageImages = [[NSMutableArray alloc] initWithCapacity:[self.pageInfo[@"count"] intValue]];
    NSMutableArray *pageSounds = [[NSMutableArray alloc] initWithCapacity:[self.pageInfo[@"count"] intValue]];
    
    for (int i = 0; i < [self.pageInfo[@"text"] count]; i++) {
        NSString *imageName = [NSString stringWithFormat:@"%@-%d.jpg", self.pageInfo[@"BookTitle"], i+1];
        [pageImages addObject:[UIImage imageNamed:imageName]];
        
        NSString *soundName = [NSString stringWithFormat:@"%@-%d.mp3", self.pageInfo[@"BookTitle"], i+1];
        
        NSURL *url=[[NSBundle mainBundle]URLForResource:soundName withExtension:nil];
        [pageSounds addObject:url];
    }
    
    recView = [[BXFStudentWorkRecordView alloc] initWithFrame:CGRectMake(kTitleBarWidth + 2, 0, self.view.bounds.size.width - kTitleBarWidth - 2, self.view.frame.size.height) andContentText:self.pageInfo[@"text"]] ;
    recView.backgroundColor= [UIColor whiteColor];
    [self.view addSubview:recView];
    
    mainView = [[BXFStudentWorkMainView alloc] initWithFrame:CGRectMake(0, kTitleBarHeight + 2, kTitleBarWidth, self.view.frame.size.height - kTitleBarHeight - 2) andImages:[NSArray arrayWithArray:pageImages] andOriginSoundURLs:[NSArray arrayWithArray:pageSounds]];
//    mainView.pageImages  = [NSArray arrayWithArray:pageImages];
//    mainView.contentText =  self.pageInfo[@"text"];
  //  mainView.originSound = [NSArray arrayWithArray:pageSounds];
 //   mainView.pageImages = @[[UIImage imageNamed:@"K1-19A-248"], [UIImage imageNamed:@"K1-1A-2"]];
//    mainView.contentText= @[@"a cat says meow", @"hi, elmo"];
    
    mainView.backgroundColor = [UIColor whiteColor];
    mainView.recordView = recView;
    mainView.titleView = titleView;
    [self.view addSubview:mainView];
    [mainView turnToFirstPage];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
