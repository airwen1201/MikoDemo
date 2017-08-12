//
//  MainViewController.m
//  Miko'sDemo
//
//  Created by admin1 on 2017/8/10.
//  Copyright © 2017年 shiqi. All rights reserved.
//

#import "MainViewController.h"
#import "JokeTableViewController.h"
#import "AdvertisingModel.h"

static NSString* mainTableViewCell = @"mainCell";


@interface MainViewController ()<UITableViewDelegate,UITableViewDataSource,SQAdvertisingScrollViewDelegate>{
    UITableView *mainTableView;
    NSArray *cellTitles;
}
@property(nonatomic,strong)NSMutableArray<AdvertisingModel*> *adArray;
@end

@implementation MainViewController

-(NSMutableArray <AdvertisingModel*>*)adArray
{
    if (_adArray == nil) {
        _adArray = [NSMutableArray array];
    }
    return _adArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadTodayThings];
    
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    mainTableView = [[UITableView alloc] init];
    [self.view addSubview:mainTableView];
    mainTableView.delegate = self;
    mainTableView.dataSource = self;
    [mainTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(64);
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(44);
    }];
    [mainTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:mainTableViewCell];
    mainTableView.tableFooterView = [UIView new];
    
    cellTitles = @[@"待定",@"开心一笑",@"待定",@"待定",@"待定",@"待定"];
    
    
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


#pragma mark - tableview

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [cellTitles count];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:mainTableViewCell forIndexPath:indexPath];
    if (indexPath.row == 0) {
        
    }else{
        cell.textLabel.text = cellTitles[indexPath.row];
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 1) {
        JokeTableViewController *vc = [[JokeTableViewController alloc] init];
        vc.title = @"笑话精选";
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
}



#pragma mark - others

- (void)loadTodayThings
{
    NSDictionary *dict = @{
                           @"key":@"b5c8907440d53ee326c0d6f7b91ac718",
                           @"month":@([[NSDate date] month:[NSDate date]]),
                           @"day":@([[NSDate date] day:[NSDate date]]),
                           @"v":@"1.0"
                           };
    BEFORDOWNLOAD(LOADINGSTRING);
    [SQServiceUtil AFNetworkingWithURL:@"http://api.juheapi.com/japi/toh" andParam:dict andFinished:^(NSError *error, NSDictionary *dictionary) {
        AFTERDOWNLOAD;
        if (error == nil) {
            [self.adArray removeAllObjects];
            NSArray *array = [dictionary objectForKey:@"result"];
            for (NSDictionary *dic in array) {
                if (![NSString isEmpty:[dic objectForKey:@"pic"]]) {
                    AdvertisingModel *model = [[AdvertisingModel alloc] init];
                    [model yy_modelSetWithDictionary:dic];
                    [self.adArray addObject:model];
                }
            }
            mainTableView.tableHeaderView = [self takeHeaderView];
            NSIndexPath *indexPath=[NSIndexPath indexPathForRow:0 inSection:0];
            [mainTableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
        }
    }];
    
}

- (SQAdvertisingScrollView*)takeHeaderView
{
    if (self.adArray.count == 0) {
        return nil;
    }
    SQAdvertisingScrollView *advertising = [[SQAdvertisingScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 280)];
    //[advertising setImageNames:@[@"便利店",@"服务",@"教育",@"美食"]];
    //[advertising setImages:@[[UIImage imageNamed:@"便利店"],[UIImage imageNamed:@"服务"],[UIImage imageNamed:@"教育"],[UIImage imageNamed:@"美食"]]];
    [advertising setImageUrls:@[self.adArray[0].pic,self.adArray[1].pic,self.adArray[2].pic,self.adArray[3].pic,self.adArray[4].pic]];
    advertising.titleArray = @[self.adArray[0].title,self.adArray[1].title,self.adArray[2].title,self.adArray[3].title,self.adArray[4].title];
    [advertising setDelegate:self];
    [advertising setAutoLoopInterval:3];
    return advertising;
}

- (void)advertisingScrollView:(SQAdvertisingScrollView *)scrollView clickEventAtIndex:(NSInteger)index {
    NSLog(@"点击了第%ld张图片",(long)index);
}

@end





























