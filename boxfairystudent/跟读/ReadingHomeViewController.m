//
//  ReadingHomeViewController.m
//  boxfairystudent
//
//  Created by 包炯 on 2018/12/27.
//  Copyright © 2018 包炯. All rights reserved.
//

#import "ReadingHomeViewController.h"
#import "BookshelfViewController.h"

@interface ReadingHomeViewController () {
    
    UICollectionView *booksView;
    NSArray *imagesOfPublishs;
    NSArray *titlesOfPublishs;
}

@end

@implementation ReadingHomeViewController

- (instancetype)initWithPublishsInfo:(NSDictionary *)publishInfo {
    self = [super initWithNibName:@"ReadingHomeViewController" bundle:nil];
    if (self) {
        //imagesOfPublishs = @[@"http://7xiijr.com1.z0.glb.clouddn.com/WechatIMG2.jpeg"];
        imagesOfPublishs = publishInfo[@"images"];
        titlesOfPublishs = publishInfo[@"titles"];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.titleLabel.text = self.title;
    
    for(int i = 1; i < imagesOfPublishs.count; i++) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectHeaderImage:)];
        UIImageView *iv = [self.view viewWithTag:i];
        iv.userInteractionEnabled = YES;
        iv.image = imagesOfPublishs[i-1];
        [iv addGestureRecognizer:tap];
    }
    
    for(int i = 7; i-7 < titlesOfPublishs.count; i++) {
        UILabel *lb = [self.view viewWithTag:i];
        lb.text = titlesOfPublishs[i-7];
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

- (void)selectHeaderImage:(UITapGestureRecognizer *)sender {
    UITapGestureRecognizer *tap = (UITapGestureRecognizer *)sender;
    UIViewController *vc;
    switch (tap.view.tag) {
        case 1:
        {
            NSDictionary *booksInfo = @{@"images":@[[UIImage imageNamed:@"dawei1.jpg"],
                                                    [UIImage imageNamed:@"dawei2.jpg"],
                                                    [UIImage imageNamed:@"dawei3.jpg"]],
                                        @"titles":@[@"大卫不可以", @"大卫惹麻烦", @"大卫去上学"],
                                        @"pages":@[@{@"BookTitle":@"dawei1", @"text":@[@"It was an accident !", @"Do I have to !", @"I forgot !", @"My dog ate my homework !", @"I couldn't help it !", @"I was hungry !",@"But she likes it !"],
                                                     @"type":@"绘本阅读"
                                                     }]
                                        };

            vc = [[BookshelfViewController alloc] initWithBooksInfo:booksInfo];
            vc.title = titlesOfPublishs[0];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        default:
            break;
    }
}

@end
