//
//  ViewController.m
//  TTTableview
//
//  Created by TT_code on 16/4/18.
//  Copyright © 2016年 TT_code. All rights reserved.
//

#import "ViewController.h"
#import "TTTableview.h"
@interface ViewController ()
@property(nonatomic,strong)TTTableview* tableview;
@property(nonatomic,strong)NSMutableArray* dataarray;
@end

@implementation ViewController
static NSString* idetifier=@"mycell";
- (void)viewDidLoad {
    [super viewDidLoad];
    //基础设置
    self.automaticallyAdjustsScrollViewInsets = YES;
    
    //增加tableview
    [self addtableview];
}


/**
 *  懒加载
 *
 *  @return
 */
-(NSMutableArray *)dataarray
{
    if(!_dataarray){
        _dataarray=[NSMutableArray array];
        _dataarray=[@[@"标题1",@"标题2",@"标题3",@"标题4",@"标题5",@"标题6",@"标题7"] mutableCopy];
    }
    return _dataarray;
}


/**
 *  增加 tableview
 */
-(void)addtableview
{
    self.tableview=[TTTableview tableviewWithFram:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) target:self backcolor:nil];
    [self.tableview registerClass:[UITableViewCell class] forCellReuseIdentifier:idetifier];
    [self.view addSubview:self.tableview];
    
    
    //检测刷新的
    [self.tableview TagetHeadFresh:^(NSInteger index) {
        NSLog(@"下拉刷新了");
        [self RefreshAdditionalData];
        [self.tableview endAllRefresh];
        
    } andCollecFootBlock:^(NSInteger index) {
        NSLog(@"上拉刷新了");
        [self  performSelector:@selector(EndRefresh) withObject:self afterDelay:1];
    }];
}


/**
 *  结束刷新
 */
-(void)EndRefresh
{
    [self RefreshAdditionalData];
     [self.tableview endAllRefresh];
   
}


-(void)RefreshAdditionalData
{
    NSArray* array=@[@"追加数据1",@"追加数据2",@"追加数据3"];
    for (NSString* string in array) {
        [self.dataarray addObject:string];
    }
    [self.tableview reloadData];
}



#pragma mark-tableview  delegate-or-datasource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataarray.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:idetifier];
    cell.textLabel.text=self.dataarray[indexPath.row];
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}



@end
