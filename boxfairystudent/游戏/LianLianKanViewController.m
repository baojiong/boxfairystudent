//
//  LianLianKanViewController.m
//  boxfairystudent
//
//  Created by 包炯 on 2018/12/27.
//  Copyright © 2018 包炯. All rights reserved.
//

#import "LianLianKanViewController.h"

@interface LianLianKanViewController () {
    int lastTap;    //前一次翻牌的位置
    UIImage *lastImage;
    UIImageView *lastImageView;
    
    NSArray *cardArr;
    NSMutableArray *uncoverdCards;
    
    UIImage *backImage;
}

@end

@implementation LianLianKanViewController

- (instancetype)initWithImages:(NSArray *)imageArr {
    self = [super initWithNibName:@"LianLianKanViewController" bundle:nil];
    if (self) {
        lastTap = 0;
        lastImageView = nil;
        lastImage = nil;
        
        cardArr = [imageArr arrayByAddingObjectsFromArray: imageArr];
        
     
            cardArr = [cardArr sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
                int seed = arc4random_uniform(2);
                if (seed) {
                    return NSOrderedAscending;
                } else {
                    return NSOrderedDescending;
                }
            }];
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    backImage = [UIImage imageNamed:@"game1"];
    for(int i = 1; i < 9; i++) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAnImage:)];
        UIImageView *iv = [self.view viewWithTag:i];
        iv.userInteractionEnabled = YES;
        [iv addGestureRecognizer:tap];
        iv.image = backImage;
    }
    
    uncoverdCards = [[NSMutableArray alloc] initWithArray:cardArr];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)tapAnImage:(UITapGestureRecognizer *)sender {
    UITapGestureRecognizer *tap = (UITapGestureRecognizer *)sender;
    if(lastTap == 0) {
        if(((UIImageView *)tap.view).image == backImage) {
            lastTap = (int)tap.view.tag;
            lastImageView = (UIImageView *)tap.view;
            [self flipAnimation:lastImageView toImage:cardArr[(int)tap.view.tag - 1]]; //显示牌面
            [uncoverdCards removeObject:lastImageView.image];
        }
    } else {
        if(((UIImageView *)tap.view).image == backImage) {
            UIImageView *currentImageView = (UIImageView *)tap.view;
            [UIView transitionWithView:currentImageView duration:1  options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
                currentImageView.image = cardArr[(int)tap.view.tag - 1];
            }completion:^(BOOL finished) {
                //[self viewAnimation];
                if(currentImageView.image == lastImageView.image) { //判断相等
                    NSLog(@"bingo");
                    [uncoverdCards removeObject:currentImageView.image];
                    if(uncoverdCards.count == 0) {  //全部找到
                        NSLog(@"win");
                    }
                } else {
                    NSLog(@"Oh, No");
                    [uncoverdCards addObject:lastImageView.image];
                    [self flipBack:currentImageView];
                    [self flipBack:lastImageView];
                    //                    currentImageView.image =  backImage;
                    //                    lastImageView.image = backImage;
                }
            }];
        } else {
                                [self flipBack:lastImageView];
            //lastImageView.image = backImage;
        }
        lastTap = 0;
    }
}

- (void)flipAnimation:(UIImageView *)cardView toImage:(UIImage *)toImage {
    [UIView transitionWithView:cardView duration:1  options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
        cardView.image = toImage;
    }completion:^(BOOL finished) {
        //[self viewAnimation];
    }];
}

- (void)flipBack:(UIImageView *)cardView {
    [UIView transitionWithView:cardView duration:1  options:UIViewAnimationOptionTransitionFlipFromRight animations:^{
        cardView.image = backImage;
    }completion:^(BOOL finished) {
        //[self viewAnimation];
    }];
}

@end
