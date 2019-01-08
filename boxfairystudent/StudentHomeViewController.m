//
//  StudentHomeViewController.m
//  boxfairystudent
//
//  Created by 包炯 on 2018/12/20.
//  Copyright © 2018 包炯. All rights reserved.
//

#import "StudentHomeViewController.h"

#import "ReadingHomeViewController.h"
#import "BookshelfViewController.h"
#import "AlbumViewController.h"
#import "OnlineClassViewController.h"
#import "ExaminationViewController.h"
#import "GameCenterViewController.h"

@interface StudentHomeViewController ()<UINavigationControllerDelegate>

@end

@implementation StudentHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    for(int i = 1; i < 8; i++) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectHeaderImage:)];
        UIImageView *iv = [self.view viewWithTag:i];
        iv.userInteractionEnabled = YES;
        [iv addGestureRecognizer:tap];
    }
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
    
        self.navigationController.delegate = self;

}

- (void)selectHeaderImage:(UITapGestureRecognizer *)sender {
    UITapGestureRecognizer *tap = (UITapGestureRecognizer *)sender;
    UIViewController *vc;
    switch (tap.view.tag) {
        case 1: {
            NSDictionary *booksInfo = @{@"images":@[[UIImage imageNamed:@"k11a.jpg"],
                                                    [UIImage imageNamed:@"K1-1B.jpg"],
                                                    [UIImage imageNamed:@"K1-2A.jpg"],
                                                    [UIImage imageNamed:@"K1-2B.jpg"],
                                                    [UIImage imageNamed:@"K1-3A.jpg"],
                                                    [UIImage imageNamed:@"K1-3B.jpg"]],
                                        @"titles":@[@"K1-1A", @"K1-1B", @"K1-2A", @"K1-2B", @"K1-3A", @"K1-3B"],
                                        @"pages":@[@{@"BookTitle":@"K1-1A", @"text":@[@"Hello. Hello. Wave hello. Wave hello.", @"Hi, Elmo! Hi, Elmo", @"Elmo!", @"Big Bird", @"Mr. Noodle", @"Cookie Monster", @"Hi! I'm Elmo",@"Hi! I'm Big Bird."],
                                                     @"type":@"教材跟读"
                                                     }]
                                        };
            
            vc = [[BookshelfViewController alloc] initWithBooksInfo:booksInfo];
            vc.title = @"芝麻街英语 K1 1st";
            break;
        }
        case 2:
        {
            NSDictionary *publishsInfo = @{@"images": @[[UIImage imageNamed:@"dawei.jpg"], [UIImage imageNamed:@"K1-1B.jpg"]],
                                        @"titles": @[@"大卫不可以系列", @"xxx系列"]};
            vc = [[ReadingHomeViewController alloc] initWithPublishsInfo:publishsInfo];
            vc.title = @"绘本阅读";
            break;
        }
        case 3:
        {
            NSDictionary *albumInfo = @{@"images":@[[UIImage imageNamed:@"dog.jpg"],
                                                    [UIImage imageNamed:@"pepepig.jpg"],
                                                    [UIImage imageNamed:@"flyman.jpg"],
                                                    [UIImage imageNamed:@"mouse.jpg"]],
                                        @"titles":@[@"汪汪队", @"PePe Pig", @"Super Wings", @"Masiy"]};
            
            vc = [[AlbumViewController alloc] initWithAlbumInfo: albumInfo];
            vc.title = @"动画配音";
            break;
        }
        case 4: {
            NSDictionary *gamesInfo = @{@"images":@[[UIImage imageNamed:@"llk1.jpg"],
                                                    [UIImage imageNamed:@"llk2.jpg"],
                                                    [UIImage imageNamed:@"game9.jpg"],
                                                    [UIImage imageNamed:@"llk3.jpg"]],
                                        @"titles":@[@"拼图1", @"拼图2", @"拼图3", @"连连看1"]};
            
            vc = [[GameCenterViewController alloc] initWithGamesInfo:gamesInfo];
            vc.title = @"互动游戏";
            break;
        }
        case 5:
            vc = [[ExaminationViewController alloc] initWithNibName:@"ExaminationViewController" bundle:nil];
            break;
        case 6:
            vc = [[OnlineClassViewController alloc] initWithNibName:@"OnlineClassViewController" bundle:nil];
            break;
        case 7:
            [self.navigationController.presentingViewController dismissViewControllerAnimated:YES completion:nil];
            break;
        default:
            break;
    }
    [self.navigationController pushViewController:vc animated:YES];
}

//- (IBAction)pushBookShelf:(UIButton *)sender {
////    ReadingViewController *vc = [[ReadingViewController alloc] initWithNibName:@"ReadingViewController" bundle:nil];
////    [self.navigationController pushViewController:vc animated:YES];
//    BookshelfViewController *vc = [[BookshelfViewController alloc] initWithBooksInfo:nil];
//    [self.navigationController pushViewController:vc animated:YES];
//}
//
//- (IBAction)pushReadingHome:(UIButton *)sender{
//    ReadingViewController *vc = [[ReadingViewController alloc] initWithPublishsInfo:nil];
//    [self.navigationController pushViewController:vc animated:YES];
//}
//
//- (IBAction)pushCartoonHome:(UIButton *)sender{
//    AlbumViewController *vc = [[AlbumViewController alloc] initWithNibName:@"AlbumViewController" bundle:nil];
//    [self.navigationController pushViewController:vc animated:YES];
//}
//
//- (IBAction)pushGameCenter:(UIButton *)sender{
//    GameCenterViewController *vc = [[GameCenterViewController alloc] initWithNibName:@"GameCenterViewController" bundle:nil];
//    [self.navigationController pushViewController:vc animated:YES];
//}
//
//
//- (IBAction)pushOnlineClass:(UIButton *)sender{
//    OnlineClassViewController *vc = [[OnlineClassViewController alloc] initWithNibName:@"OnlineClassViewController" bundle:nil];
//    [self.navigationController pushViewController:vc animated:YES];
//}
//
//- (IBAction)pushExamination:(UIButton *)sender{
//    ExaminationViewController *vc = [[ExaminationViewController alloc] initWithNibName:@"ExaminationViewController" bundle:nil];
//    [self.navigationController pushViewController:vc animated:YES];
//}

@end
