//
//  BXFStudentPeiYinViewController.m
//  boxfairystudent
//
//  Created by 包炯 on 2018/12/29.
//  Copyright © 2018 包炯. All rights reserved.
//

#import "BXFStudentPeiYinViewController.h"

static const int kTitleBarWidth =450;
static const int kTitleBarHeight = 48;

@interface BXFStudentPeiYinViewController ()

@end

@implementation BXFStudentPeiYinViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor grayColor];
    //self.view.autoresizesSubviews = YES;
    
    titleView = [[BXFStudentWorkTitleView alloc] initWithFrame:CGRectMake(0, 0, kTitleBarWidth, kTitleBarHeight)];
    titleView.backgroundColor = [UIColor greenColor];
    backButton.frame = CGRectMake(15, 15, 20, 20);
    [titleView addSubview:backButton];
    [self.view addSubview:titleView];
    
    recView = [[BXFStudentWorkRecordView alloc] initWithFrame:CGRectMake(kTitleBarWidth + 2, 0, self.view.bounds.size.width - kTitleBarWidth - 2, self.view.frame.size.height)];
    recView.backgroundColor= [UIColor greenColor];
    [self.view addSubview:recView];
    
    mainView = [[BXFStudentWorkMainView alloc] initWithFrame:CGRectMake(0, kTitleBarHeight + 2, kTitleBarWidth, self.view.frame.size.height - kTitleBarHeight - 2)];
    mainView.pageImages = @[[UIImage imageNamed:@"K1-19A-248"], [UIImage imageNamed:@"K1-1A-2"]];
    mainView.contentText= @[@"a cat says meow", @"hi, elmo"];
    mainView.backgroundColor = [UIColor greenColor];
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
