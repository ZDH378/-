//
//  ViewController.m
//  IOS_OC_网格批量编辑
//
//  Created by 张东辉 on 2020-4-14.
//  Copyright © 2020 ZDH. All rights reserved.
//

#import "ViewController.h"
#import "CustomCollectionViewCell.h"
@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>{
    UIButton *_leftBtn;
    UIButton *_rightBtn;
    
}
@property(nonatomic,assign)BOOL isEdit;                      //网格状态按钮
@property(nonatomic,assign)BOOL isAllSelect;                      //全选状态按钮
@property(nonatomic,strong)UIButton *allBtn;                 //全选按钮
@property(nonatomic,strong)UIButton *deleteBtn;              //删除按钮
@property(nonatomic,strong)UICollectionView *collect;        //网格视图
@property(nonatomic,strong)NSMutableArray *dataArr;          //网格数据源
@property(nonatomic,strong)NSMutableArray *selectArr;        //选中数组
@property(nonatomic,strong)UIButton *editBtn;            //编辑按钮
@property (nonatomic, strong) NSMutableDictionary *cellDic;  //网格Cell复用标记数组
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.view.backgroundColor = [UIColor yellowColor];
    self.title = @"网格的批量操作";
    
    
    self.editBtn = [[UIButton alloc] init];
    [self.editBtn setTitle:@"管理" forState:UIControlStateNormal];
    self.editBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.editBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.editBtn addTarget:self action:@selector(EditBtnDidChage) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightCunstomButtonView = [[UIBarButtonItem alloc] initWithCustomView:self.editBtn];
    self.navigationItem.rightBarButtonItem = rightCunstomButtonView;
    
    self.allBtn = [[UIButton alloc] init];
    [self.allBtn setTitle:@"全选" forState:UIControlStateNormal];
    self.allBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.allBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.allBtn addTarget:self action:@selector(allBtnDidChage:) forControlEvents:UIControlEventTouchUpInside];
    self.deleteBtn = [[UIButton alloc] init];
    [self.deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
    self.deleteBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.deleteBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.deleteBtn addTarget:self action:@selector(deleteBtnDidChage) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftCunstomButtonView = [[UIBarButtonItem alloc] initWithCustomView:self.allBtn];
    UIBarButtonItem *leftCunstomButtonView2 = [[UIBarButtonItem alloc] initWithCustomView:self.deleteBtn];
    self.navigationItem.leftBarButtonItems = @[leftCunstomButtonView,leftCunstomButtonView2];
    
    
    
    
    
    self.allBtn.hidden = YES;
    self.deleteBtn.hidden = YES;
    
    
    
    
    

    //初始化数组字典
    self.isEdit = NO;//设置初始状态为不编辑状态
    self.isAllSelect = NO;
        self.cellDic = [[NSMutableDictionary alloc] init];
    self.dataArr = [NSMutableArray arrayWithObjects:@"飞",@"笑",@"雪",@"书",@"连",@"神",@"天",@"侠",@"射",@"倚",@"白",@"碧",@"鹿",@"鸳",nil];
    self.selectArr = [NSMutableArray array];
    [self initUI];
}
-(void)initUI{
    //创建网格布局
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    CGFloat itemH = 150;
    layout.itemSize = CGSizeMake([UIScreen mainScreen].bounds.size.width/2-15, itemH);
    layout.minimumInteritemSpacing = 10;
    layout.minimumLineSpacing      = 10;
    layout.sectionInset = UIEdgeInsetsMake(10,10,10, 10);
    
    //初始化网格视图
    self.collect = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 85, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-85) collectionViewLayout:layout];
    self.collect.delegate = self;
    self.collect.dataSource = self;
    self.collect.backgroundColor = [UIColor whiteColor];
    [self.collect registerClass:[CustomCollectionViewCell class] forCellWithReuseIdentifier:@"CustomCollectionViewCell"];
    [self.view addSubview:self.collect];
    
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArr.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
      // 每次先从字典中根据IndexPath取出唯一标识符
      NSString *identifier = [_cellDic objectForKey:[NSString stringWithFormat:@"%@",indexPath]];
      // 如果取出的唯一标示符不存在，则初始化唯一标示符，并将其存入字典中，对应唯一标示符注册Cell
      if (identifier == nil) {
          identifier = [NSString stringWithFormat:@"identifier%@",[NSString stringWithFormat:@"%@",indexPath]];
          [_cellDic setValue:identifier forKey:[NSString stringWithFormat:@"%@",indexPath]];
          //注册cell
          [self.collect registerClass:[CustomCollectionViewCell class] forCellWithReuseIdentifier:identifier];
      }
      
    
      
    CustomCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    cell.nameLabael.text = self.dataArr[indexPath.item];
    cell.backgroundColor = [UIColor blackColor];
     
     if (self.isEdit == YES) {
        cell.selectImgV.hidden = NO;
         if (self.isAllSelect == YES) {
             cell.selectImgV.image =  [UIImage imageNamed:@"select_yes"];
             cell.isSelectGo = YES;
         }else{
             cell.selectImgV.image =  [UIImage imageNamed:@"select_no"];
             cell.isSelectGo = NO;
         }
     }else{
        cell.selectImgV.hidden = YES;
        cell.isSelectGo = NO;
        cell.selectImgV.image =  [UIImage imageNamed:@"select_no"];
     }
    
    return cell;
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    
    
    if (self.isEdit == YES) {
        

        if (@available(iOS 11.0, *))
        {
            UIImpactFeedbackGenerator *feedBackGenertor = [[UIImpactFeedbackGenerator alloc] initWithStyle:UIImpactFeedbackStyleLight];
            [feedBackGenertor impactOccurred];
         }
        CustomCollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
        if (cell.isSelectGo == YES) {
            cell.isSelectGo = NO;
            cell.selectImgV.image =  [UIImage imageNamed:@"select_no"];
            [self.selectArr removeObject:self.dataArr[indexPath.row]];
        }else{
            cell.isSelectGo = YES;
            cell.selectImgV.image =  [UIImage imageNamed:@"select_yes"];
            [self.selectArr addObject:[NSString stringWithFormat:@"%@",self.dataArr[indexPath.item]]];

        }
    }else{
        
        
        
        
    }
    NSLog(@"%@",self.selectArr);

    
}



-(void)EditBtnDidChage{
    if (self.isEdit == YES) {
        self.isEdit = NO;
      
        [self.editBtn setTitle:@"管理" forState:UIControlStateNormal];
        self.allBtn.hidden = YES;
        self.deleteBtn.hidden = YES;

        [self.collect reloadData];
        [self.selectArr removeAllObjects];
        [self.allBtn setTitle:@"全选" forState:UIControlStateNormal];
     

    }else{
        
    
        self.isEdit = YES;
        [self.editBtn setTitle:@"取消" forState:UIControlStateNormal];
        self.allBtn.hidden = NO;
        self.deleteBtn.hidden = NO;
        [self.collect reloadData];
        
    }
}
-(void)allBtnDidChage:(UIButton *)btn{
    if (self.dataArr.count>0) {

    if ([btn.titleLabel.text isEqualToString:@"全选"]) {
        [btn setTitle:@"反选" forState:UIControlStateNormal];

        self.selectArr = [NSMutableArray arrayWithArray:self.dataArr];
        self.isAllSelect = YES;
        [self.collect reloadData];
        
        
    }else{
        self.isAllSelect = NO;
        [btn setTitle:@"全选" forState:UIControlStateNormal];
        [self.selectArr removeAllObjects];
        [self.collect reloadData];
    }
    }

}
-(void)deleteBtnDidChage{
    if (self.selectArr.count>0) {
        [self.dataArr removeObjectsInArray:self.selectArr];
        self.isEdit = NO;
        [self.editBtn setTitle:@"管理" forState:UIControlStateNormal];
        self.allBtn.hidden = YES;
        self.deleteBtn.hidden = YES;
        [self.collect reloadData];
        [self.selectArr removeAllObjects];
        [self.allBtn setTitle:@"全选" forState:UIControlStateNormal];
    }

}
@end
