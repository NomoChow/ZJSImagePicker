//
//  ZJSImagePickerViewController.m
//  ZJSImagePicker_Demo
//
//  Created by 周建顺 on 15/4/16.
//  Copyright (c) 2015年 周建顺. All rights reserved.
//

#import "ZJSImagePickerViewController.h"
#import "ZJSImageCollectionViewCell.h"
#import "ZJSImagePickerBottomView.h"
#import "ZJSImagePickerController.h"
#import "ZJSImageBrowserViewController.h"


#define CELL_IDENTIFIER_IMAGE @"CELL_IDENTIFIER_IMAGE"
#define MARGIN 4

#define MAX_SELECTION_COUNT 9



@interface ZJSImagePickerViewController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,ZJSImageBrowserStyle1Delegate>

@property (nonatomic,strong) NSMutableArray *dataSource;
@property (nonatomic,strong) UICollectionView *collectionView;

/** 选中的图片列表*/
@property (nonatomic,strong) NSMutableArray *selectionArray;

@property (nonatomic,strong) ZJSImagePickerBottomView *bottomView;
@property (nonatomic) NSUInteger maxCount;


@end

@implementation ZJSImagePickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    

    self.view.backgroundColor = [UIColor whiteColor];
    
    [self addViews];
    [self addCancelButton];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"ZJSImageCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:CELL_IDENTIFIER_IMAGE];
   
    [self bottomViewAction];
    
    ZJSImagePickerController *controller =(ZJSImagePickerController*)self.navigationController;
   
    if (controller.maxCount<=0) {
        self.maxCount = MAX_SELECTION_COUNT;
    }else{
        self.maxCount = controller.maxCount;
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

-(void)addViews{
    [self.view addSubview:self.collectionView];
    [self.view addSubview:self.bottomView];
  //  self.collectionView.backgroundColor = [UIColor redColor];
    NSDictionary *view = @{@"collectionView":self.collectionView,
                           @"bottomView":self.bottomView};
    
    NSArray *constraintCollectionViewH = [NSLayoutConstraint constraintsWithVisualFormat:@"|-0-[collectionView]-0-|" options:0 metrics:nil views:view];
    NSArray *constraintV = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[collectionView]-0-[bottomView(49)]-0-|" options:NSLayoutFormatAlignAllLeading|NSLayoutFormatAlignAllTrailing metrics:nil views:view];
    NSArray *constraintBottomViewH = [NSLayoutConstraint constraintsWithVisualFormat:@"|-0-[bottomView]-0-|" options:0 metrics:nil views:view];
    
    [self.view addConstraints:constraintCollectionViewH];
    [self.view addConstraints:constraintBottomViewH];
    [self.view addConstraints:constraintV];

}

#pragma mark 添加取消按钮
-(void)addCancelButton{
    UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancel:)];
    
    self.navigationItem.rightBarButtonItem = cancelItem;
}

-(void)cancel:(UIBarButtonItem*)sender{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

#pragma mark 底部操作栏的按钮处理
/**添加处理bottomView的事件*/
-(void)bottomViewAction{
    
      __weak ZJSImagePickerViewController *weakSelf = self;
    // 预览
    self.bottomView.previewBlock = ^(void){
        ZJSImageBrowserStyle1 *imageBrowser = [ZJSImageBrowserStyle1 new];
        imageBrowser.images = [weakSelf.selectionArray mutableCopy];
        imageBrowser.imageBrowserDelegate = weakSelf;
        [weakSelf.navigationController pushViewController:imageBrowser animated:YES];
    };
    
    //__weak ZJSImagePickerController *weak = self.navigationController;
  
    self.bottomView.submitBlock = ^(void){
        ZJSImagePickerController *controller =(ZJSImagePickerController*) weakSelf.navigationController;
        [controller.pickerDelegate imagePickerComleted:weakSelf.selectionArray];
        
        [weakSelf dismissViewControllerAnimated:YES completion:nil];
    };
}

-(void)imageBrowserSelectComplete:(NSArray*)images{
    
    // 找出为选中的项
    NSMutableArray *temp = [[NSMutableArray alloc] init];
    [self.selectionArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([images containsObject:obj]) {
            
        }else{
            [temp addObject:obj];
        }
    }];
    
    // 删除未选中的项
    [self.selectionArray removeObjectsInArray:temp];
    
    // 取消选中
    [temp enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSUInteger index = [self.dataSource indexOfObject:obj];
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
        [self.collectionView deselectItemAtIndexPath:indexPath animated:YES];
        
    }];
}


#pragma mark - setter
-(void)setAssetsGroup:(ALAssetsGroup *)assetsGroup{
    if (_assetsGroup!=assetsGroup) {
        [_assetsGroup setAssetsFilter:[ALAssetsFilter allPhotos]];
        _assetsGroup = assetsGroup;
        
        NSUInteger count = [_assetsGroup numberOfAssets];
        [self.dataSource removeAllObjects];
        [_assetsGroup enumerateAssetsUsingBlock:^(ALAsset *asset, NSUInteger index, BOOL *stop) {
            
            if (asset) {
                
                [self.dataSource addObject:asset];
                
                
            }else if(self.dataSource.count>=count){
            
                // 遍历完成
                [self.collectionView reloadData];
                
            }
        }];
    }
}

#pragma mark - getter


-(NSMutableArray *)dataSource{

    if (!_dataSource) {
        _dataSource = [[NSMutableArray alloc] init];
    }
    return _dataSource;
}

-(UICollectionView *)collectionView{
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) collectionViewLayout:[UICollectionViewFlowLayout new]];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.translatesAutoresizingMaskIntoConstraints = NO;
        _collectionView.allowsMultipleSelection = YES;
    }
    
    return _collectionView;
}

-(NSMutableArray *)selectionArray{
    if (!_selectionArray) {
        _selectionArray = [[NSMutableArray alloc] init];
    }
    return _selectionArray;
}

-(ZJSImagePickerBottomView *)bottomView{
    if (!_bottomView) {
        _bottomView = [ZJSImagePickerBottomView bottomView];
//        _bottomView.backgroundColor = [UIColor purpleColor];
        _bottomView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _bottomView;
}

#pragma mark - collectionView datasource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return self.dataSource.count;
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ZJSImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CELL_IDENTIFIER_IMAGE forIndexPath:indexPath];
    cell.asset = self.dataSource[indexPath.row];
    return cell;
}

#pragma mark - collection delegate

#pragma mark 判断是否可选中
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.selectionArray.count<self.maxCount) {
        return YES;
    }
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:[NSString stringWithFormat:@"无法选择，最多选择%i个",self.maxCount] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
    [alertView show];
    


    return NO;
}

#pragma mark  选中
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    NSLog(@"seletion count:%li",[self.collectionView indexPathsForSelectedItems].count);
    
    [self.selectionArray addObject:self.dataSource[indexPath.row]];
    
//     UICollectionViewLayoutAttributes *attrs =   [collectionView layoutAttributesForItemAtIndexPath:indexPath];
//    
//    
//    NSLog(@"%@",NSStringFromCGRect(attrs.frame));
    
    [self.bottomView setSelectedCount:self.selectionArray.count];
    
}

#pragma mark 取消选中
-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{

    NSLog(@"seletion count:%li",[self.collectionView indexPathsForSelectedItems].count);
    [self.selectionArray removeObject:[self.dataSource objectAtIndex:indexPath.row]];
    
    [self.bottomView setSelectedCount:self.selectionArray.count];
    
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{

    CGFloat width = (self.collectionView.frame.size.width - 3*MARGIN)/4;
    CGFloat height = width;
    return CGSizeMake(width, height);
}
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return MARGIN;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return MARGIN;
}
//- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
//
//    return UIEdgeInsetsMake(0, MARGIN/2, MARGIN, MARGIN/2);
//}

@end
