//
//  GameCenterViewController.m
//  boxfairystudent
//
//  Created by 包炯 on 2018/12/23.
//  Copyright © 2018 包炯. All rights reserved.
//

#import "GameCenterViewController.h"
#import "PinTuGameViewController.h"
#import "LianLianKanViewController.h"

@interface GameCenterViewController () {
    NSArray *imagesOfGames;
    NSArray *titlesOfGames;
}
@end

@implementation GameCenterViewController

- (instancetype)initWithGamesInfo:(NSDictionary *)gamesInfo {
    self = [super initWithNibName:@"GameCenterViewController" bundle:nil];
    if (self) {
        //imagesOfPublishs = @[@"http://7xiijr.com1.z0.glb.clouddn.com/WechatIMG2.jpeg"];
        imagesOfGames = gamesInfo[@"images"];
        titlesOfGames = gamesInfo[@"titles"];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.titleLabel.text = self.title;
    
    for(int i = 1; i <= imagesOfGames.count; i++) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectHeaderImage:)];
        UIImageView *iv = [self.view viewWithTag:i];
        iv.userInteractionEnabled = YES;
        iv.image = imagesOfGames[i-1];
        [iv addGestureRecognizer:tap];
    }
    
    for(int i = 7; i-7 < titlesOfGames.count; i++) {
        UILabel *lb = [self.view viewWithTag:i];
        lb.text = titlesOfGames[i-7];
    }
    /*
    int seed = arc4random_uniform(2);
    if (seed) {
        UIImage *image1 = [UIImage imageNamed:@"game1"];
        UIImage *image2 = [UIImage imageNamed:@"game2"];
        UIImage *image3 = [UIImage imageNamed:@"game3"];
        UIImage *image4 = [UIImage imageNamed:@"game4"];
        PinTuGameViewController *vc = [[PinTuGameViewController alloc] initWithImages:@[image1, image2, image3, image4]];
        [self.navigationController pushViewController:vc animated:YES];
    } else {
        UIImage *image1 = [UIImage imageNamed:@"game5.jpg"];
        UIImage *image2 = [UIImage imageNamed:@"game6.jpg"];
        UIImage *image3 = [UIImage imageNamed:@"game7.jpg"];
        UIImage *image4 = [UIImage imageNamed:@"game8.jpg"];
        LianLianKanViewController *vc = [[LianLianKanViewController alloc] initWithImages:@[image1, image2, image3, image4]];
        [self.navigationController pushViewController:vc animated:YES];
    }*/
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)selectHeaderImage:(UITapGestureRecognizer *)sender {
    UITapGestureRecognizer *tap = (UITapGestureRecognizer *)sender;
    UIViewController *vc;
    switch (tap.view.tag) {
        case 1: {
            UIImage *image1 = [UIImage imageNamed:@"game1"];
            UIImage *image2 = [UIImage imageNamed:@"game2"];
            UIImage *image3 = [UIImage imageNamed:@"game3"];
            UIImage *image4 = [UIImage imageNamed:@"game4"];
            PinTuGameViewController *vc = [[PinTuGameViewController alloc] initWithImages:@[image1, image2, image3, image4]];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 2: {
            UIImage *image1 = [UIImage imageNamed:@"game5.jpg"];
            UIImage *image2 = [UIImage imageNamed:@"game6.jpg"];
            UIImage *image3 = [UIImage imageNamed:@"game7.jpg"];
            UIImage *image4 = [UIImage imageNamed:@"game8.jpg"];
            PinTuGameViewController *vc = [[PinTuGameViewController alloc] initWithImages:@[image1, image2, image3, image4]];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 3: {
            UIImage *image1 = [UIImage imageNamed:@"game9.jpg"];
            UIImage *image2 = [UIImage imageNamed:@"game10.jpg"];
            UIImage *image3 = [UIImage imageNamed:@"game11.jpg"];
            UIImage *image4 = [UIImage imageNamed:@"game12.jpg"];
            PinTuGameViewController *vc = [[PinTuGameViewController alloc] initWithImages:@[image1, image2, image3, image4]];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 4: {
            UIImage *image1 = [UIImage imageNamed:@"llk1.jpg"];
            UIImage *image2 = [UIImage imageNamed:@"llk2.jpg"];
            UIImage *image3 = [UIImage imageNamed:@"llk3.jpg"];
            UIImage *image4 = [UIImage imageNamed:@"llk4.jpg"];
            LianLianKanViewController *vc = [[LianLianKanViewController alloc] initWithImages:@[image1, image2, image3, image4]];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        default:
            break;
    }
    [self.navigationController pushViewController:vc animated:YES];
}

@end
