//
//  MainViewController.m
//  Miko'sDemo
//
//  Created by admin1 on 2017/8/10.
//  Copyright © 2017年 shiqi. All rights reserved.
//

#import "MainViewController.h"
#import "JokeTableViewController.h"


static NSString* mainTableViewCell = @"mainCell";


@interface MainViewController ()<UITableViewDelegate,UITableViewDataSource>{
    UITableView *mainTableView;
    NSArray *cellTitles;
}

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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
    cell.textLabel.text = cellTitles[indexPath.row];
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

@end





























