//
//  JokeTableViewController.m
//  Miko'sDemo
//
//  Created by admin1 on 2017/8/10.
//  Copyright © 2017年 shiqi. All rights reserved.
//

#import "JokeTableViewController.h"
#import "JokeModel.h"
#import "JokeTableViewCell.h"

@interface JokeTableViewController (){
    NSString *joketime;
    NSInteger page;
}

@property(nonatomic,strong)NSMutableArray<JokeViewModel *> *jokeArray;

@end

@implementation JokeTableViewController

-(NSMutableArray<JokeViewModel *> *)jokeArray
{
    if (_jokeArray == nil) {
        _jokeArray = [NSMutableArray array];
    }
    return _jokeArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    page = 1;
    joketime = [NSString stringWithFormat:@"%ld",(NSInteger)[[NSDate date] timeIntervalSince1970]];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    self.tableView.estimatedRowHeight = 66.0f;
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self.tableView registerClass:[JokeTableViewCell class] forCellReuseIdentifier:NSStringFromClass(JokeTableViewCell.class)];
    [self loadData];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        page = 1;
        [self.tableView.mj_header endRefreshing];
        
        [self loadData];
    }];
    
    self.tableView.estimatedRowHeight = 66;
    
    [self.navigationController rightBarButtonWithTarget:self withTitle:@"换一批" AndBack:^{
        page++;
        
        [self loadData];
    }];
   
}

- (void)loadData
{
    NSDictionary *dict = @{
                           @"key":APPKEYFORAVATAR,
                           @"time":joketime,
                           @"sort":@"desc",
                           @"page":@(page),
                           @"rows":@10
                           };
    BEFORDOWNLOAD(@"正在加载");
    [SQServiceUtil AFNetworkingWithURL:@"http://api.avatardata.cn/Joke/QueryJokeByTime" andParam:dict andFinished:^(NSError *error, NSDictionary *dictionary) {
        AFTERDOWNLOAD;
        if (error == nil) {
            [self.jokeArray removeAllObjects];
            NSArray *list = [dictionary objectForKey:@"result"];
            for (NSDictionary*dic in list) {
                JokeModel *model = [[JokeModel alloc] init];
                JokeViewModel *viewModel = [[JokeViewModel alloc] init];
                [model yy_modelSetWithDictionary:dic];
                viewModel.jokeModel = model;
                [self.jokeArray addObject:viewModel];
            }
            [self.tableView reloadData];
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return self.jokeArray.count;
}

//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    NSLog(@"%f",self.jokeArray[indexPath.row].height);
//    return self.jokeArray[indexPath.row].height+20;
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    JokeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(JokeTableViewCell.class) forIndexPath:indexPath];
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.text = self.jokeArray[indexPath.row].jokeModel.content;
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
