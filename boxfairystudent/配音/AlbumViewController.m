//
//  AlbumViewController.m
//  boxfairystudent
//
//  Created by 包炯 on 2018/12/23.
//  Copyright © 2018 包炯. All rights reserved.
//

#import "AlbumViewController.h"
#import "CartoonViewController.h"

@interface AlbumViewController () {
    NSArray *imagesOfAlbums;
    NSArray *titlesOfAlbums;
}

@end

@implementation AlbumViewController

- (instancetype)initWithAlbumInfo:(NSDictionary *)albumInfo {
    self = [super initWithNibName:@"AlbumViewController" bundle:nil];
    if (self) {
        //imagesOfPublishs = @[@"http://7xiijr.com1.z0.glb.clouddn.com/WechatIMG2.jpeg"];
        imagesOfAlbums = albumInfo[@"images"];
        titlesOfAlbums = albumInfo[@"titles"];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.titleLabel.text = self.title;
    
    for(int i = 0; i < imagesOfAlbums.count; i++) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectHeaderImage:)];
        UIImageView *iv = [self.view viewWithTag:i + 1];
        iv.userInteractionEnabled = YES;
        iv.image = imagesOfAlbums[i];
        [iv addGestureRecognizer:tap];
    }
    
    for(int i = 7; i-7 < titlesOfAlbums.count; i++) {
        UILabel *lb = [self.view viewWithTag:i];
        lb.text = titlesOfAlbums[i-7];
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
    CartoonViewController *vc;
    switch (tap.view.tag) {
        case 1:
        {
            NSDictionary *cartoonsInfo = @{@"images":@[[UIImage imageNamed:@"dog.jpg"]],
                                        @"titles":@[@"汪汪队1"]};
            vc = [[CartoonViewController alloc] initWithCartoonsInfo:cartoonsInfo];
            vc.title = titlesOfAlbums[0];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        default:
            break;
    }
}
@end
