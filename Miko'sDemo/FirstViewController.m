//
//  FirstViewController.m
//  Miko'sDemo
//
//  Created by admin1 on 2017/7/6.
//  Copyright © 2017年 shiqi. All rights reserved.
//

#import "FirstViewController.h"
#import "NSDate+EX.h"
#import "LYWCollectionViewCell.h"
#import "LYWCollectionReusableView.h"

@interface FirstViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>{
    UIButton *rightBtn;
    BOOL isPanban;
    NSDate *selectDate;
}

@end

#define NumberMounthes 12 //想要展示的月数

#define LMUserInfoCachePath       [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"mikoDate.archiver"]


static NSString *cellID = @"cellID";
static NSString *headerID = @"headerID";
static NSString *footerID = @"footerID";

@implementation FirstViewController{
    //自动布局
    UICollectionViewFlowLayout *_layout;
    //表格视图
    UICollectionView *_collectionView;
    //当月第一天星期几
    NSInteger firstDayInMounthInWeekly;
    NSMutableArray *_firstMounth;
    //容纳六个数组的数组
    NSMutableArray *_sixArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    selectDate = [NSKeyedUnarchiver unarchiveObjectWithFile:LMUserInfoCachePath];
    // Do any additional setup after loading the view, typically from a nib.
    //定义星期视图,若为周末则字体颜色为绿色
    self.automaticallyAdjustsScrollViewInsets = NO;//关闭自动适应
    NSArray *weekTitleArray = @[@"周日",@"周一",@"周二",@"周三",@"周四",@"周五",@"周六"];
    for (int i = 0; i < weekTitleArray.count; i++) {
        UILabel *weekTitleLable = [[UILabel alloc]initWithFrame:CGRectMake(i * ((ScreenWidth/(weekTitleArray.count))), 64, ScreenWidth/(weekTitleArray.count ), 30)];
        if (i == 0 || i == 6) {
            weekTitleLable.textColor = [UIColor greenColor];
        }else{
            weekTitleLable.textColor = [UIColor blackColor];
        }
        weekTitleLable.text = [weekTitleArray objectAtIndex:i];
        weekTitleLable.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:weekTitleLable];
    }
    
    
    //设置collectionView及自动布局,代理方法尤为重要
    _layout = [[UICollectionViewFlowLayout alloc]init];
    //头部始终在顶端
    _layout.sectionHeadersPinToVisibleBounds = YES;
    //头部视图高度
    _layout.headerReferenceSize = CGSizeMake(414, 40);
    _layout.minimumLineSpacing = 0;
    _layout.minimumInteritemSpacing = 0;
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 64 + 30, ScreenWidth, ScreenHeight - 64 - 30) collectionViewLayout:_layout];
    _collectionView.backgroundColor = [UIColor whiteColor];
    //注册表格
    [_collectionView registerClass:[LYWCollectionViewCell class] forCellWithReuseIdentifier:cellID];
    //注册头视图
    [_collectionView registerClass:[LYWCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerID];
    //注册尾视图
    // [_collectionView registerClass:[UICollectionReusableView class] forCellWithReuseIdentifier:footerID];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [self.view addSubview:_collectionView];
    
    
    //NumberMounthes 为宏定义,表示要显示月的个数,程序要求是六个月,所以宏定义为六
    //创建六个数组,并将这六个数组装入大数组中
    NSDate *currentDate = [[NSDate alloc]init];
    _sixArray = [[NSMutableArray alloc]init];
    for (int i = 0; i < NumberMounthes ; i++ ) {
        NSMutableArray *array = [[NSMutableArray alloc]init];
        [_sixArray addObject:array];
    }
    //为六个数组写入每个月的日历信息
    for (int i = 0 ; i < NumberMounthes; i++) {
        //获取月份
        int mounth = ((int)[currentDate month:currentDate] + i)%12; //
        if (mounth == 0) {
            mounth = 12;
        }
        NSDateComponents *components = [[NSDateComponents alloc]init];
        //获取下个月的年月日信息,并将其转为date
        components.month = mounth;
        components.year = 2017 + (((int)[currentDate month:currentDate] + i) -1)/12;
        components.day = 1;
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSDate *nextDate = [calendar dateFromComponents:components];
        //获取该月第一天星期几
        NSInteger firstDayInThisMounth = [nextDate firstWeekdayInThisMonth:nextDate];
        //该月的有多少天daysInThisMounth
        NSInteger daysInThisMounth = [nextDate totaldaysInMonth:nextDate];
        NSString *string = [[NSString alloc]init];
        for (int j = 0; j < (daysInThisMounth > 29 && (firstDayInThisMounth == 6 || firstDayInThisMounth ==5) ? 42 : 35) ; j++) {
            if (j < firstDayInThisMounth || j > daysInThisMounth + firstDayInThisMounth - 1) {
                string = @"";
                [[_sixArray objectAtIndex:i]addObject:string];
            }else{
                string = [NSString stringWithFormat:@"%ld",j - firstDayInThisMounth +1];
                [[_sixArray objectAtIndex:i]addObject:string];
            }
        }
    }
    

    
    rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 80, 20);
    [rightBtn setTitle:@"开始排班" forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    
    isPanban = NO;
    
}


- (void)rightBtnClick:(UIButton*)button
{
//    NSLog(@"222");
//    if (isPanban == NO) {
//        isPanban = YES;
//        leftBtn.hidden = NO;
//        [rightBtn setTitle:@"确定" forState:UIControlStateNormal];
//    }else{
//        isPanban = NO;
//        leftBtn.hidden = YES;
//        [rightBtn setTitle:@"排班" forState:UIControlStateNormal];
//        [self showPanban];
//    }
    EASYLOADINGVIEW(@"宝宝请选择第一天上班的日子");
    isPanban = YES;
    selectDate = nil;
    [[NSFileManager defaultManager] removeItemAtPath:LMUserInfoCachePath error:nil];
    [_collectionView reloadData];
}

- (void)showPanban
{
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//这里是自定义cell,非常简单的自定义
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    LYWCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor whiteColor];
    for (UIView *view in cell.contentView.subviews) {
        
        [view removeFromSuperview];
        
    }
//    UIView *blackgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height)];
//    blackgroundView.backgroundColor = [UIColor yellowColor];
    cell.dateLable.text = [[_sixArray objectAtIndex:indexPath.section]objectAtIndex:indexPath.row];
    NSDate *date = [[NSDate alloc]init];
    NSInteger day = [date day:date];
    //设置单击后的颜色
//    cell.selectedBackgroundView = blackgroundView;

    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
//    [formatter setDateFormat:[NSString stringWithFormat:@"%ld-%ld-%ld 10:00:00",([date year:date]+indexPath.section),(indexPath.section+1),(indexPath.row+1)]];
    NSInteger year = ([date month:date] + indexPath.section -1)/12 + 2017;
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *ss = [NSString stringWithFormat:@"%ld-%ld-%@ 10:00:00",year,([date month:date]+indexPath.section)%12==0?12:([date month:date]+indexPath.section)%12,[[_sixArray objectAtIndex:indexPath.section]objectAtIndex:indexPath.row]];
    NSDate *dd =[formatter dateFromString:ss];
    if (selectDate&&dd)
    {
        if ([SQTools mikoIsWorkday:selectDate andToday:dd]) {
            UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(1, 1, cell.contentView.frame.size.width-2, cell.contentView.frame.size.height-2)];
            bgView.backgroundColor = [UIColor redColor];
            [cell.contentView addSubview:bgView];
//            cell.contentView.backgroundColor = [UIColor redColor];
        }
    }
    return cell;
}


#pragma mark -- collectViewDelegate

//这两个不用说,返回cell个数及section个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [[_sixArray objectAtIndex:section] count];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return _sixArray.count;
}

//cell大小及间距
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(ScreenWidth/7, ScreenWidth/7);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if (kind == UICollectionElementKindSectionHeader) {
        LYWCollectionReusableView *headerRV = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:headerID forIndexPath:indexPath];
        //自定义蓝色
        headerRV.backgroundColor = [UIColor blueColor];
        NSDate *currentDate = [[NSDate alloc]init];
        NSInteger year = ([currentDate month:currentDate] + indexPath.section - 1)/12 + 2017;
        NSInteger mounth = ([currentDate month:currentDate] + indexPath.section) % 12 == 0 ? 12 : ([currentDate month:currentDate] + indexPath.section)%12;
        headerRV.dateLable.text = [NSString stringWithFormat:@"%ld年%ld月",year,mounth];
        return headerRV;
    }else{
        return nil;
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (isPanban == NO) {
        return;
    }
    isPanban = NO;

    LYWCollectionViewCell *cell = [self collectionView:_collectionView cellForItemAtIndexPath:indexPath];
   
    
    
    
    
    
    
    
    NSDate *currentDate = [[NSDate alloc]init];
    
    //打印当前日期
    
    if (![cell.dateLable.text isEqualToString:@""]) {
        
        NSInteger year = ([currentDate month:currentDate] + indexPath.section -1)/12 + 2017;
        
        NSInteger mounth = ([currentDate month:currentDate] + indexPath.section)%12;
        if (mounth == 0) {
            mounth = 12;
        }
        
        NSInteger day = [cell.dateLable.text intValue];
        
        NSLog(@"%ld年%02ld月%02ld日",year,mounth,day);
        
        selectDate = [SQTools dateWithYear:[NSString stringWithFormat:@"%ld",year] withMonth:[NSString stringWithFormat:@"%ld",mounth] withDay:[NSString stringWithFormat:@"%ld",day]];
        
        
        BOOL succeeded = [NSKeyedArchiver archiveRootObject:selectDate toFile:LMUserInfoCachePath];
        NSLog(@"%d",succeeded);
    }
    
    //排除空值cell
    
    //获取月份
    
    NSInteger mounth = ([currentDate month:currentDate] + indexPath.section) % 12 == 0 ? 12 : ([currentDate month:currentDate] + indexPath.section)%12;
    
    NSDateComponents *components = [[NSDateComponents alloc]init];
    
    components.month = mounth;
    
    components.year = 2017 + (((int)[currentDate month:currentDate] + indexPath.section) -1)/12;
    
    components.day = 1;
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDate *nextDate = [calendar dateFromComponents:components];
    
    //获取该月第一天星期几
    
    NSInteger firstDayInThisMounth = [nextDate firstWeekdayInThisMonth:nextDate];
    
    //该月的有多少天daysInThisMounth
    
    NSInteger daysInThisMounth = [nextDate totaldaysInMonth:nextDate];
    
    if ((indexPath.row < firstDayInThisMounth || indexPath.row > daysInThisMounth + firstDayInThisMounth - 1)){
        
        //如果点击空表格则单击无效
        
        [collectionView cellForItemAtIndexPath:indexPath].userInteractionEnabled = NO;
        
        [collectionView reloadData];
        return;
        
    }
    
    
    LYWCollectionViewCell *cell10 = (LYWCollectionViewCell*)[collectionView cellForItemAtIndexPath:indexPath];
    cell10.isSelect = !cell10.isSelect;
    
    NSDate *date = [[NSDate alloc]  init];
    
    
    
//    if (cell10.isSelect) {
//        cell10.backgroundColor = [UIColor redColor];
//    }else{
//        cell10.backgroundColor = [UIColor whiteColor];
//    }
    [_collectionView reloadData];
}

@end






















