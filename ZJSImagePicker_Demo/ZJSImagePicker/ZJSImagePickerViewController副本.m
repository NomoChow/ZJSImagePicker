//
//  ZJSImagePickerViewController.m
//  ZJSImagePicker_Demo
//
//  Created by 周建顺 on 15/4/16.
//  Copyright (c) 2015年 周建顺. All rights reserved.
//

#import "ZJSImagePickerViewController.h"
#import "ZJSImageCollectionViewCell.h"


#define CELL_IDENTIFIER_IMAGE @"CELL_IDENTIFIER_IMAGE"
#define MARGIN 4
#define MAX_SELECTION_COUNT 5


@interface ZJSImagePickerViewController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong) NSMutableArray *dataSource;
@property (nonatomic,strong) UICollectionView *collectionView;

/** 选中的图片列表*/
@property (nonatomic,strong) NSMutableArray *selectionArray;




@end

@implementation ZJSImagePickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    

    self.view.backgroundColor = [UIColor whiteColor];
    [self addCollectionView];
    
    //[self.collectionView registerClass:[ZJSImageCollectionViewCell class] forCellWithReuseIdentifier:CELL_IDENTIFIER_IMAGE];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"ZJSImageCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:CELL_IDENTIFIER_IMAGE];
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

-(void)addCollectionView{
    [self.view addSubview:self.collectionView];
    self.collectionView.backgroundColor = [UIColor redColor];
    NSDictionary *view = @{@"collectionView":self.collectionView};
    
    NSArray *constraintH = [NSLayoutConstraint constraintsWithVisualFormat:@"|-0-[collectionView]-0-|" options:0 metrics:nil views:view];
    NSArray *constraintV = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[collectionView]-0-|" options:0 metrics:nil views:view];
    
    [self.view addConstraints:constraintH];
    [self.view addConstraints:constraintV];

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
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.selectionArray.count<MAX_SELECTION_COUNT) {
        return YES;
    }
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:[NSString stringWithFormat:@"无法选择，做多选择%i个",MAX_SELECTION_COUNT] delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"123", nil];
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
}

#pragma mark 取消选中
-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{

    NSLog(@"seletion count:%li",[self.collectionView indexPathsForSelectedItems].count);
    [self.selectionArray removeObject:[self.dataSource objectAtIndex:indexPath.row]];
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
