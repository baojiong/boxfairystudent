//
//  CartoonViewController.m
//  boxfairystudent
//
//  Created by 包炯 on 2018/12/23.
//  Copyright © 2018 包炯. All rights reserved.
//

#import "CartoonViewController.h"
#import "DoPeiyinViewController.h"

@interface CartoonViewController () {
    NSArray *imagesOfCartoons;
    NSArray *titlesOfCartoons;
}

@end

@implementation CartoonViewController

- (instancetype)initWithCartoonsInfo:(NSDictionary *)cartoonsInfo {
    self = [super initWithNibName:@"CartoonViewController" bundle:nil];
    if (self) {
        imagesOfCartoons = cartoonsInfo[@"images"];
        
        titlesOfCartoons = cartoonsInfo[@"titles"];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.titleLabel.text = self.title;
    
    for(int i = 1; i <= imagesOfCartoons.count; i++) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(openAVideo:)];
        UIImageView *iv = [self.view viewWithTag:i];
        iv.userInteractionEnabled = YES;
        iv.image = imagesOfCartoons[i-1];
        [iv addGestureRecognizer:tap];
    }
    
    for(int i = 7;  i-7 < titlesOfCartoons.count; i++) {
        UILabel *lb = [self.view viewWithTag:i];
        lb.text = titlesOfCartoons[i-7];
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

-(void)openAVideo:(UITapGestureRecognizer *)sender {
    DoPeiyinViewController *vc = [[DoPeiyinViewController alloc] initWithNibName:@"DoPeiyinViewController" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
