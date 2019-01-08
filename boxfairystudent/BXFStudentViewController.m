//
//  BXFStudentViewController.m
//  boxfairystudent
//
//  Created by 包炯 on 2018/12/23.
//  Copyright © 2018 包炯. All rights reserved.
//

#import "BXFStudentViewController.h"


@interface BXFStudentViewController () <UINavigationControllerDelegate>{
    
}

@end

@implementation BXFStudentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    backButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    backButton.frame = CGRectMake(20, 20, 25, 25);
    UIImage *img = [UIImage imageNamed:@"goback"];
    [backButton setBackgroundImage:img forState:UIControlStateNormal];
    [self.view addSubview:backButton];
    [backButton addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //设置代理即可
    self.navigationController.delegate = self;
    
    [self.view bringSubviewToFront:backButton];
    
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)goBack {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
