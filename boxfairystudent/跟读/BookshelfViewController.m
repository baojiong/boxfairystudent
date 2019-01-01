//
//  BookshelfViewController.m
//  boxfairystudent
//
//  Created by 包炯 on 2018/12/21.
//  Copyright © 2018 包炯. All rights reserved.
//

#import "BookshelfViewController.h"
#import "DoReadingViewController.h"

@interface BookshelfViewController ()<UICollectionViewDataSource,
                                        UICollectionViewDelegate,
                                        UICollectionViewDelegateFlowLayout> {
                                            
    UICollectionView *booksView;
    NSArray *imagesOfBooks;
    NSArray *titlesOfBooks;
    NSArray *pagesOfBooks;
}

@end

@implementation BookshelfViewController

- (instancetype)initWithBooksInfo:(NSDictionary *)booksInfo {
    self = [super initWithNibName:@"BookshelfViewController" bundle:nil];
    if (self) {
        imagesOfBooks = booksInfo[@"images"];
        
        titlesOfBooks = booksInfo[@"titles"];
        pagesOfBooks = booksInfo[@"pages"];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    UINib *nib = [UINib nibWithNibName:@"BookCell" bundle:[NSBundle mainBundle]];
//    [booksView registerNib:nib forCellWithReuseIdentifier:@"BookCell"];
    
//    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
//    booksView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, self.view.frame.size.height) collectionViewLayout:flowLayout];
//    booksView.delegate = self;
//    booksView.dataSource = self;
//    booksView.allowsMultipleSelection = YES;      //实现多选，默认是NO
//    [self.view addSubview:booksView];
    
    [self addTheCollectionView];
    self.titleLabel.text = self.title;
    
    for(int i = 1; i <= imagesOfBooks.count; i++) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(openABook:)];
        UIImageView *iv = [self.view viewWithTag:i];
        iv.userInteractionEnabled = YES;
        iv.image = imagesOfBooks[i-1];
        [iv addGestureRecognizer:tap];
    }
    
    for(int i = 7;  i-7 < titlesOfBooks.count; i++) {
        UILabel *lb = [self.view viewWithTag:i];
        lb.text = titlesOfBooks[i-7];
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

//创建视图
-(void)addTheCollectionView{
    
    //新建UICollectionViewFlowLayout
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout = [self setUICollectionViewFlowLayout:flowLayout
                                               Width:(self.view.frame.size.width-35)/3
                                                High:(self.view.frame.size.width-35)/2 + 30
                                         minHspacing:100.f
                                         minVspacing:1.f
                                            UiedgeUp:1.f
                                          Uiedgeleft:10.f
                                        Uiedgebottom:1.f
                                         Uiedgeright:10.f
                                         Scdirection:YES];
    
    //创建一个UICollectionView
    booksView = [[UICollectionView alloc]initWithFrame:CGRectMake(24, 40, self.view.frame.size.width - 24 * 2, self.view.frame.size.height- 40 - 20) collectionViewLayout:flowLayout];
    //设置代理为当前控制器
    booksView.delegate = self;
    booksView.dataSource = self;
    booksView.backgroundColor =[UIColor colorWithRed:200 green:200 blue:200 alpha:1];
    
#pragma mark -- 注册单元格
    [booksView registerNib:[UINib nibWithNibName:@"BookCell" bundle:nil] forCellWithReuseIdentifier:@"BookCell"];
//    [booksView registerNib:[UINib nibWithNibName:@"CollectionViewCell" bundle:nil] forCellWithReuseIdentifier:indentify];
//    [booksView registerNib:[UINib nibWithNibName:@"HotCell" bundle:nil] forCellWithReuseIdentifier:hotindentify];
    
    
    
#pragma mark -- 注册头部视图
//    [_myCollectionV registerClass:[MyHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"MyHeaderView"];
//    [_myCollectionV registerClass:[MenuView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"MenuView"];
    
    
    
    //添加视图
//    [self.view addSubview:booksView];
    
}

-(UICollectionViewFlowLayout *)setUICollectionViewFlowLayout:(UICollectionViewFlowLayout *)flow Width:(float) width High:(float) high
                                                 minHspacing:(float) minhs minVspacing:(float) minvs UiedgeUp:(float) up Uiedgeleft:(float) left Uiedgebottom:(float)bottom Uiedgeright:(float)right Scdirection:(BOOL) direction{
    flow = [UICollectionViewFlowLayout new];
    //格子的大小 (长，高)
    flow.itemSize = CGSizeMake(width, high);
    //横向最小距离
    flow.minimumInteritemSpacing = minhs;
    //代表的是纵向的空间间隔
    flow.minimumLineSpacing=minvs;
    //设置，上／左／下／右 边距 空间间隔数是多少
    flow.sectionInset = UIEdgeInsetsMake(up, left, bottom, right);
    
    //确定是水平滚动，还是垂直滚动
    if (direction) {
        [flow setScrollDirection:UICollectionViewScrollDirectionVertical];
    }else{
        [flow setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    }
    return flow;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return titlesOfBooks.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BookCell" forIndexPath:indexPath];
   // UICollectionViewCell * cell = [collectionView dequeueReusableCellWithIdentifier:@"BookCell"];
    
    UIImageView *imageView = (UIImageView *)[cell viewWithTag:1];   //在创建Xib的时候给了控件相应的tag值
    UILabel *label = (UILabel *)[cell viewWithTag:2];
    
    NSData *imgData = [NSData dataWithContentsOfURL:[NSURL URLWithString:imagesOfBooks[indexPath.row]]];
    [imageView setImage:[UIImage imageWithData:imgData]];
    [label setText:titlesOfBooks[indexPath.row]];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(openABook:)];
    
    [imageView addGestureRecognizer:tap];

//    cell.backgroundColor = [UIColor redColor];
    
    return cell;
}

//UICollectionViewCell的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake(90, 116);
}

-(void)openABook:(UITapGestureRecognizer *)sender {
    DoReadingViewController *vc = [[DoReadingViewController alloc] initWithNibName:@"DoReadingViewController" bundle:nil];
    
    int index = (int)(sender.view.tag);
    if (index <= pagesOfBooks.count) {
        vc.pageInfo = pagesOfBooks[index-1];
        [self.navigationController pushViewController:vc animated:YES];
    } else {
        UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"尚未开启" message:nil delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
        [av show];
    }
}

@end
