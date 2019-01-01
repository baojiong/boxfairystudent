//
//  HomeViewController.m
//  boxfairystudent
//
//  Created by 包炯 on 2018/12/20.
//  Copyright © 2018 包炯. All rights reserved.
//

#import "HomeViewController.h"
#import "StudentHomeViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if([[UIDevice currentDevice]respondsToSelector:@selector(setOrientation:)]) {
        
        SEL selector = NSSelectorFromString(@"setOrientation:");
        
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
        
        [invocation setSelector:selector];
        
        [invocation setTarget:[UIDevice currentDevice]];
        
        int val = UIInterfaceOrientationPortrait;//横屏
        
        [invocation setArgument:&val atIndex:2];
        
        [invocation invoke];
        
    }
}

- (IBAction)pushStudentHome:(UIButton *)sender {
    NSLog(@"打开学生版");
    //竖屏转横屏：https://www.cnblogs.com/niit-soft-518/p/5611298.html
    
    StudentHomeViewController *vc = [[StudentHomeViewController alloc] initWithNibName:@"StudentHomeViewController" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
