//
//  BXFStudentNavigationController.m
//  boxfairystudent
//
//  Created by 包炯 on 2019/1/9.
//  Copyright © 2019 包炯. All rights reserved.
//

#import "BXFStudentNavigationController.h"

@interface BXFStudentNavigationController ()

@end

@implementation BXFStudentNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskLandscapeLeft | UIInterfaceOrientationMaskLandscapeRight;
}

//一开始的方向  很重要
-(UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
    return UIInterfaceOrientationLandscapeLeft;
}


@end
