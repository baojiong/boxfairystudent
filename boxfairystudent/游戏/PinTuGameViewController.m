//
//  PinTuGameViewController.m
//  boxfairystudent
//
//  Created by 包炯 on 2018/12/26.
//  Copyright © 2018 包炯. All rights reserved.
//

#import "PinTuGameViewController.h"

@interface PinTuGameViewController ()<CAAnimationDelegate> {
    int lastTap;
    UIImageView *lastImageView;
    UIImageView *currentImageView;
    
    NSArray *answerArr;
    NSArray *workArr;
}

@end

@implementation PinTuGameViewController

- (instancetype)initWithImages:(NSArray *)imageArr {
    self = [super initWithNibName:@"PinTuGameViewController" bundle:nil];
    if (self) {
        lastTap = 0;
        lastImageView = nil;
        
        answerArr = imageArr;
        do {
            workArr = [answerArr sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
                int seed = arc4random_uniform(2);
                if (seed) {
                    return NSOrderedAscending;
                } else {
                    return NSOrderedDescending;
                }
            }];
        } while ([workArr isEqualToArray:answerArr]);
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    for(int i = 1; i < 5; i++) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAnImage:)];
        UIImageView *iv = [self.view viewWithTag:i];
        iv.userInteractionEnabled = YES;
        [iv addGestureRecognizer:tap];
        iv.image = workArr[i-1];
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

- (void)tapAnImage:(UITapGestureRecognizer *)sender {
    UITapGestureRecognizer *tap = (UITapGestureRecognizer *)sender;
    if(lastTap == 0) {
        lastTap = (int)tap.view.tag;
        lastImageView = (UIImageView *)tap.view;
        
        [lastImageView.layer addAnimation:[self AlphaLight:0.5] forKey:@"aAlpha"];
    } else {
        currentImageView = (UIImageView *)tap.view;
        if((currentImageView.center.x == lastImageView.center.x) ||
           (currentImageView.center.y == lastImageView.center.y)) {
//            lastImageView.image = ((UIImageView *)tap.view).image;
//            ((UIImageView *)tap.view).image = lastImage;
            
            [lastImageView.layer removeAnimationForKey:@"aAlpha"];
            CGPoint tmpPoint = lastImageView.center;
            [lastImageView.layer addAnimation:[self moveTo:currentImageView.center] forKey:@"translate"];
            CABasicAnimation *anim = [self moveTo:tmpPoint];
            anim.delegate = self;
            [currentImageView.layer addAnimation:anim forKey:@"translate"];

        }
    }
}

-(CABasicAnimation *) AlphaLight:(float)time {
    CABasicAnimation *animation =[CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation.fromValue = [NSNumber numberWithFloat:1.0f];
    animation.toValue = [NSNumber numberWithFloat:0.9f];//这是透明度。
    animation.autoreverses = YES;
    animation.duration = time;
    animation.repeatCount = MAXFLOAT;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    
    return animation;
}

- (CABasicAnimation *)moveTo:(CGPoint)point {
    // 创建动画对象
    CABasicAnimation *anim = [CABasicAnimation animation];
    
    // 修改CALayer的position属性的值可以实现平移效果
    anim.keyPath = @"position";
    anim.toValue = [NSValue valueWithCGPoint:point];
    
    anim.duration = 0.5;
    
    // 下面两句代码的作用：保持动画执行完毕后的状态(如果不这样设置，动画执行完毕后会回到原状态)
    anim.removedOnCompletion = NO;
    anim.fillMode = kCAFillModeForwards;
    
    return anim;
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    CGRect tmpRect = lastImageView.frame;
    lastImageView.frame = currentImageView.frame;
    currentImageView.frame = tmpRect;
    
    lastImageView = nil;
    lastTap = 0;
    
    
            NSMutableArray *resultArr = [NSMutableArray arrayWithCapacity:workArr.count];
            for(int i = 1; i < 5; i++) {
                UIImageView *iv = [self.view viewWithTag:i];
                [resultArr addObject:iv.image];
            }
            if([resultArr isEqualToArray: answerArr]) {
                NSLog(@"Bingo");
            }
}
@end
