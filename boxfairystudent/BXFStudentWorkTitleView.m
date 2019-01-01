//
//  BXFStudentWorkTitleView.m
//  boxfairystudent
//
//  Created by 包炯 on 2018/12/24.
//  Copyright © 2018 包炯. All rights reserved.
//

#import "BXFStudentWorkTitleView.h"

static const int kTypeLabelWidth = 80;
static const int kTypeLabelHeight = 30;
static const int kTypeLabelTopMargin = 10;

@implementation BXFStudentWorkTitleView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

/*
自动调整子控件与父控件中间的位置，宽高
UIViewAutoresizingNone就是不自动调整。
UIViewAutoresizingFlexibleLeftMargin 自动调整与superView左边的距离，保证与superView右边的距离不变。
UIViewAutoresizingFlexibleRightMargin 自动调整与superView的右边距离，保证与superView左边的距离不变。
UIViewAutoresizingFlexibleTopMargin 自动调整与superView顶部的距离，保证与superView底部的距离不变。
UIViewAutoresizingFlexibleBottomMargin 自动调整与superView底部的距离，也就是说，与superView顶部的距离不变。
UIViewAutoresizingFlexibleWidth 自动调整自己的宽度，保证与superView左边和右边的距离不变。
UIViewAutoresizingFlexibleHeight 自动调整自己的高度，保证与superView顶部和底部的距离不变。
例：UIViewAutoresizingFlexibleLeftMargin
|UIViewAutoresizingFlexibleRightMargin
自动调整与superView左边的距离，保证与左边的距离和右边的距离和原来距左边和右边的距离的比例不变。
比如原来距离为20，30，调整后的距离应为68，102，即68/20=102/30。

作者：烧开的汽水
链接：https://www.jianshu.com/p/4baf286f4bc1
來源：简书
简书著作权归作者所有，任何形式的转载都请联系作者获得授权并注明出处。
*/

- (instancetype)initWithFrame:(CGRect)frame {
    if(self = [super initWithFrame:frame]) {
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];
        _titleLabel.center = self.center;
        [self addSubview:_titleLabel];

        _typeLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width - kTypeLabelWidth, kTypeLabelTopMargin, kTypeLabelWidth, kTypeLabelHeight)];
        _typeLabel.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
        [self addSubview:_typeLabel];

        _typeIcon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];
        _typeIcon.center = self.center;
        [self addSubview:_typeIcon];
    }
    return self;
}


@end
