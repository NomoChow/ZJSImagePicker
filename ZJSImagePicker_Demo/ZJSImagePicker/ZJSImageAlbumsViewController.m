//
//  ZJSPhotoAlbumsViewController.m
//  ZJSImagePicker_Demo
//
//  Created by 周建顺 on 15/4/16.
//  Copyright (c) 2015年 周建顺. All rights reserved.
//

#import "ZJSImageAlbumsViewController.h"
#import "ZJSImagePickerViewController.h"
#import "ZJSImageAlbumTableViewCell.h"
#import "ZJSAssetsLibraryManager.h"

#import <AssetsLibrary/ALAssetsLibrary.h>
#import <AssetsLibrary/ALAssetsGroup.h>
#import <AssetsLibrary/ALAsset.h>

#define CELL_IDENTIIFIER_PHONE_ALBUM @"CELL_IDENTIIFIER_PHONE_ALBUM"

@interface ZJSImageAlbumsViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) ALAssetsLibrary *assetsLibrary;
@property (nonatomic,strong) NSMutableArray *assetsGroups;

@property (nonatomic,strong) NSDictionary *nameDict;

@end

@implementation ZJSImageAlbumsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setTitle:@"照片"];
    [self addCancelButton];
    [self addTableView];
    [self getImages];
    [self.tableView registerNib:[UINib nibWithNibName:@"ZJSImageAlbumTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:CELL_IDENTIIFIER_PHONE_ALBUM];
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

/**获取照片 */
-(void)getImages{

    [self.assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupSavedPhotos|ALAssetsGroupPhotoStream usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
        
        if (group) {
            [self.assetsGroups addObject:group];
            
            NSLog(@"assetsGroups:%@",group);
            //            NSLog(@"label:%@",group.accessibilityLabel);
            //            NSLog(@"accessibilityElements:%@",group.accessibilityElements);
            //            NSLog(@"accessibilityElementsHidden:%@",group.accessibilityElementsHidden?@"YES":@"NO");
            //            NSLog(@"accessibilityFrame:%@",NSStringFromCGRect(group.accessibilityFrame));
            //            NSLog(@"accessibilityHint:%@",group.accessibilityHint);
            //            NSLog(@"accessibilityValue:%@",group.accessibilityValue);
            //            NSLog(@"accessibilityLabel:%@",group.accessibilityLabel);
            //            NSLog(@"accessibilityTraits:%@",group.accessibilityTraits);
            
            
        }else{
        
            [self.tableView reloadData];
            ALAssetsGroup *group = self.assetsGroups[0];
            
            ZJSImagePickerViewController *vc = [[ZJSImagePickerViewController alloc] init];
            vc.assetsGroup = self.assetsGroups[0];
            vc.title =  [self nameOfAlbumByALAssetsGroupPropertyName:[group valueForProperty:ALAssetsGroupPropertyName]];
            [self.navigationController pushViewController:vc animated:NO];
            NSLog(@"nil");
        }
        
    } failureBlock:^(NSError *error) {
        
        NSLog(@"error:%@",error.localizedDescription);
        
    }];

}

-(void)cancel:(UIBarButtonItem*)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark 添加取消按钮
-(void)addCancelButton{
    UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancel:)];

    self.navigationItem.rightBarButtonItem = cancelItem;
}

-(void)addTableView{

    [self.view addSubview:self.tableView];
    NSDictionary *views = @{@"tableView":self.tableView};
    NSArray *constraintH = [NSLayoutConstraint constraintsWithVisualFormat:@"|-0-[tableView]-0-|" options:0 metrics:nil views:views];
    NSArray *constraintV = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[tableView]-0-|" options:0 metrics:nil views:views];
    [self.view addConstraints:constraintH];
    [self.view addConstraints:constraintV];

}


-(NSString*)nameOfAlbumByALAssetsGroupPropertyName:(NSString*)propertyName{
    NSString *name=@"相册";
    
    name = self.nameDict[propertyName];

    return name;
}



#pragma mark - getter
-(NSDictionary *)nameDict{
    if (!_nameDict) {
        _nameDict = @{@"Camera Roll":@"相机胶卷",
                      @"My Photo Stream":@"我的照片流",};
    }
    return _nameDict;
}

-(ALAssetsLibrary *)assetsLibrary{
    if (!_assetsLibrary) {
        // 必须要使用单丽，不然无法保存选取的图片
        _assetsLibrary = [ZJSAssetsLibraryManager defaultAssetsLibrary];
    }
    
    return _assetsLibrary;
}


-(NSMutableArray *)assetsGroups{
    
    if (!_assetsGroups) {
        _assetsGroups = [[NSMutableArray alloc] init];
    }
    return _assetsGroups;
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.translatesAutoresizingMaskIntoConstraints = NO;
        _tableView.backgroundColor = [UIColor whiteColor];
        //_tableView
    }
    return _tableView;
}

#pragma mark - tableView delegate/datasource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.assetsGroups.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZJSImageAlbumTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELL_IDENTIIFIER_PHONE_ALBUM];
    //[0]	(null)	@"ALAssetsGroupPropertyName" : @"Camera Roll"
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    
    ALAssetsGroup *group = self.assetsGroups[indexPath.row];
    cell.myTextLabel.text =  [self nameOfAlbumByALAssetsGroupPropertyName:[group valueForProperty:ALAssetsGroupPropertyName]];
    UIImage *image = [UIImage imageWithCGImage:group.posterImage];
    cell.myImageView.image = image;
    
    cell.myDetailLabel.text = [NSString stringWithFormat:@"(%li)",[group numberOfAssets]];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    
    ALAssetsGroup *group = self.assetsGroups[indexPath.row];
   
    ZJSImagePickerViewController *vc = [[ZJSImagePickerViewController alloc] init];
    vc.assetsGroup = self.assetsGroups[indexPath.row];
    vc.title =  [self nameOfAlbumByALAssetsGroupPropertyName:[group valueForProperty:ALAssetsGroupPropertyName]];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
