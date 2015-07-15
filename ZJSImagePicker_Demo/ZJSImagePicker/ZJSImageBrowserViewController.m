//
//  ZJSImageBrowserViewController.m
//  ZJSImagePicker_Demo
//
//  Created by 周建顺 on 15/4/18.
//  Copyright (c) 2015年 周建顺. All rights reserved.
//

#import "ZJSImageBrowserViewController.h"
#import "ZJSImageBrowserCell.h"
#import "ZJSImageBrowserTopView.h"
#import "ZJSImagePickerBottomView.h"
#import "ZJSImagePickerController.h"


#define kPadding 5

@interface ZJSImageBrowserViewController ()




@end

@implementation ZJSImageBrowserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    

    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"ZJSImageBrowserCell" bundle:nil] forCellWithReuseIdentifier:CELL_INDENIFIER];
    CGRect rect = self.view.frame;
   // rect.origin.x -= kPadding;
    rect.size.width += 2*kPadding;
    self.collectionView.frame = rect;
    [self.view addSubview:self.collectionView];
    //self.view.backgroundColor = [UIColor redColor];
    //self.collectionView.backgroundColor = [UIColor yellowColor];
    if (self.currentIndex==0) {
        _currentIndex = -1;
        self.currentIndex = 0;
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - setter
-(void)setImages:(NSMutableArray *)images{
    _images = images;
    
//    ZJSImageView *imageView = [ZJSImageView new];
//    imageView.frame = [UIScreen mainScreen].bounds;
//    [self.view addSubview:imageView];
//    
//    imageView.asset = images[0];

    [self.collectionView reloadData];
}

#pragma mark - getter


-(UICollectionView *)collectionView{
    if (!_collectionView) {
        
      UICollectionViewFlowLayout *layout =   [UICollectionViewFlowLayout new];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
//        CGSize size = self.view.bounds.size;
//        size.width -= 2*kPadding;
//        layout.itemSize =size;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) collectionViewLayout:layout];
        _collectionView.pagingEnabled = YES;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
       
    }
    
    return _collectionView;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.images.count;
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    ZJSImageBrowserCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CELL_INDENIFIER forIndexPath:indexPath];
    
    cell.imageView.asset = self.images[indexPath.row];
    cell.imageView.imageViewDelegate = self;
    return cell;
    
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    //CGSize size = self.collectionView.bounds.size;
    //size.width -= 2*kPadding;
    return [UIScreen mainScreen].bounds.size;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 0, 0, 2*kPadding);
}


-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 2*kPadding;
}

-(void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
    //NSLog(@"didEndDisplayingCell:@%i",indexPath.row);
    
    NSIndexPath *ip = [[self.collectionView indexPathsForVisibleItems] firstObject];
    

    self.currentIndex = ip.row;
}


@end



/*******样式一：选择*******************/
#pragma mark - 样式一：选择
@interface ZJSImageBrowserStyle1()<ZJSImageBrowserTopViewDelegate,ZJSImagePickerBottomViewDelegate>;

@property (nonatomic,strong) ZJSImageBrowserTopView *topView;
@property (nonatomic,strong) NSMutableArray *selectionImages;

@property (nonatomic,strong) ZJSImagePickerBottomView *bottmView;
//  进入时状态栏的状态
//@property (nonatomic) BOOL statusBarHiddenInited;

@end

@implementation ZJSImageBrowserStyle1

-(void)viewDidLoad{
  [super viewDidLoad];
  [self addTopView];
  [self addBottomView];
    

}



-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:YES];
 //   self.statusBarHiddenInited = [UIApplication sharedApplication].isStatusBarHidden;
    // 隐藏状态栏
   // [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];
}

-(void)viewWillDisappear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:NO];
  //  [UIApplication sharedApplication].statusBarHidden = self.statusBarHiddenInited;
    
    if ([self.imageBrowserDelegate respondsToSelector:@selector(imageBrowserSelectComplete:)]) {
        [self.imageBrowserDelegate imageBrowserSelectComplete:self.selectionImages];
    }
}

#pragma mark 添加控件
-(void)addTopView{
    [self.view addSubview:self.topView];
    
    NSDictionary *views = @{@"topView":self.topView};
    NSArray *ch = [NSLayoutConstraint constraintsWithVisualFormat:@"|-0-[topView]-0-|" options:0 metrics:nil views:views];
    NSArray *cv = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[topView(64)]" options:0 metrics:nil views:views];
    
    [self.view addConstraints:ch];
    [self.view addConstraints:cv];
}

-(void)addBottomView{

    [self.view addSubview:self.bottmView];
    
    NSDictionary *views = @{@"bottmView":self.bottmView};
    NSArray *ch = [NSLayoutConstraint constraintsWithVisualFormat:@"|-0-[bottmView]-0-|" options:0 metrics:nil views:views];
    NSArray *cv = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[bottmView(49)]-0-|" options:0 metrics:nil views:views];
    
    [self.view addConstraints:ch];
    [self.view addConstraints:cv];
}

#pragma mark 设置显示的选中图片数量
-(void)setSelectCount{
    self.bottmView.selectedCount = self.selectionImages.count;
}

#pragma mark StatusBar状态
-(BOOL)prefersStatusBarHidden{
    return YES;
}

#pragma mark - setter

-(void)setImages:(NSMutableArray *)images{
    [super setImages:images];
    self.selectionImages = [images mutableCopy];
}

-(void)setCurrentIndex:(NSUInteger)currentIndex{

    [super setCurrentIndex:currentIndex];
    
    self.topView.selected =  [self.selectionImages containsObject:[self.images objectAtIndex:currentIndex]];
    [self setSelectCount];
}

#pragma mark - getter
-(ZJSImageBrowserTopView *)topView{
    if (!_topView) {
        _topView = [ZJSImageBrowserTopView imageBrowserTopView];
        _topView.translatesAutoresizingMaskIntoConstraints = NO;
        _topView.topViewDelegate = self;
    }
    return _topView;
}
-(ZJSImagePickerBottomView *)bottmView{
    if (!_bottmView) {
        _bottmView = [ZJSImagePickerBottomView bottomView];
        _bottmView.translatesAutoresizingMaskIntoConstraints = NO;
        _bottmView.bottomViewDelegate = self;
        _bottmView.preViewButton.hidden = YES;
    }
    return _bottmView;
}

#pragma mark - ZJSImageBrowserTopViewDelegate
-(void)topViewLeftTappped:(ZJSImageBrowserTopView *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)topViewRightTappped:(ZJSImageBrowserTopView *)sender{
    
    id image = [self.images objectAtIndex:self.currentIndex];

    BOOL isSelected = [self.selectionImages containsObject:image];
    
    if (isSelected) {
        
        [self.selectionImages removeObject:image];
        self.topView.selected = !isSelected;
    }else{
        [self.selectionImages addObject:image];
        self.topView.selected = !isSelected;
    }
    
    [self setSelectCount];
}

#pragma mark  选择完成 bottomViewdelegate
-(void)bottomViewSubmitTapped:(ZJSImagePickerBottomView *)sender{
    ZJSImagePickerController *controller =(ZJSImagePickerController*) self.navigationController;
    [controller.pickerDelegate imagePickerComleted:self.selectionImages];
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark imageDelegate
-(void)imageViewSingleTap:(ZJSImageView *)photoView{

    if (self.topView.hidden) {
        self.topView.hidden = NO;
        self.bottmView.hidden = NO;
    }else{
        self.topView.hidden = YES;
        self.bottmView.hidden = YES;
    
    }
    
}


#pragma mark collection delegate


@end

/*******样式二：删除*******************/
#pragma mark - 样式二：删除

@interface ZJSImageBrowserStyle2 ()

@property (nonatomic) BOOL isStatusBarHidden;

@end

@implementation ZJSImageBrowserStyle2
-(void)viewDidLoad{
    [super viewDidLoad];

    [self addNavigationBarItems];
    //[self addTopView];
    self.isStatusBarHidden = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:self.currentIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
}

-(void)viewWillAppear:(BOOL)animated{

}

-(void)viewWillDisappear:(BOOL)animated{
  
}



#pragma mark -添加返回和删除按钮
-(void)addNavigationBarItems{
    
    UIBarButtonItem *deleteItem = [[UIBarButtonItem alloc] initWithTitle:@"删除" style:UIBarButtonItemStylePlain target:self action:@selector(deleteItemTapped:)];
    self.navigationItem.rightBarButtonItem = deleteItem;
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(backItemTapped:)];
    self.navigationItem.leftBarButtonItem = backItem;

}

#pragma mark 删除
-(void)deleteItemTapped:(UIBarButtonItem*)sender{
    
    NSIndexPath *ip = [[self.collectionView indexPathsForVisibleItems] firstObject];
    self.currentIndex = ip.row;
    [self.images removeObjectAtIndex:self.currentIndex];
    
    if ([self.imageBrowserDelegate respondsToSelector:@selector(imageBrowserSelectionChangedAtIndex:)]) {
        [self.imageBrowserDelegate imageBrowserSelectionChangedAtIndex:self.currentIndex];
    }

    if (self.images.count==0) {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [self.collectionView reloadData];
    }



}

-(void)backItemTapped:(UIBarButtonItem*)sender{
    [self.navigationController popViewControllerAnimated:YES];
}



#pragma mark - setter
-(void)setIsStatusBarHidden:(BOOL)isStatusBarHidden{
    _isStatusBarHidden = isStatusBarHidden;
    [self setNeedsStatusBarAppearanceUpdate];
}



#pragma mark - getter

#pragma mark imageDelegate 点击图片
-(void)imageViewSingleTap:(ZJSImageView *)photoView{
    
    [self.navigationController setNavigationBarHidden:!self.navigationController.navigationBarHidden animated:YES];
    self.isStatusBarHidden= self.navigationController.navigationBarHidden;
    
}


#pragma mark － 设置statusbar样式
-(BOOL)prefersStatusBarHidden{
    return self.isStatusBarHidden;
}



-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}


@end

