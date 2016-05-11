//
//  TTTableview.m
//  ReshTableview
//
//  Created by TT_code on 15/12/20.
//  Copyright © 2015年 TT_code. All rights reserved.
//
#define RefreshTop   50
#define RefreshTwoTop   50
#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]

#import "UIViewController+TTViewController.h"
#import "TTTableview.h"
@interface TTTableview()<SRRefreshDelegate,UITableViewDelegate,UIScrollViewDelegate>
{
    SRRefreshView* _slimeView;//下拉刷新控件
    CGFloat _height;
    CGFloat _oldheight;//旧的高度
    
    UIImageView* _headimageview;
    UILabel* _foottitle;
}
@end
@implementation TTTableview

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.isheadRefresh=YES;
        self.isfootRefresh=YES;
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.isheadRefresh=YES;
        self.isfootRefresh=YES;
    }
    return self;
}


-(void)addheader
{
    self.delegate=self;
    self.tableFooterView=[[UIView alloc]init];
    if(self.isheadRefresh==YES){
        if(!_slimeView){
            _slimeView = [[SRRefreshView alloc] init];
            _slimeView.delegate = self;
            _slimeView.upInset = 0;
            _slimeView.slimeMissWhenGoingBack = YES;
            _slimeView.slime.bodyColor = RGBCOLOR(216, 216, 216);
            _slimeView.slime.skinColor = [UIColor whiteColor];
            _slimeView.slime.lineWith = 0;
            _slimeView.slime.shadowBlur = 2;
            _slimeView.slime.shadowColor = [UIColor lightGrayColor];
            // _slimeView.backgroundColor=[UIColor greenColor];
            [self addSubview:_slimeView];
        }
    }
    //[self addNoingWifi];
    
    NSKeyValueObservingOptions options = NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld;
    [self addObserver:self forKeyPath:@"contentSize" options:options context:nil];
}




-(void)ResetRqust:(UIButton*)sender
{
    [self beginheadRefreshing];
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    
    if ([keyPath isEqualToString:@"contentSize"]) {
        
        CGSize size=self.contentSize;
        if(size.height>0){
            self.NoWifiView.hidden=YES;
        }else{
            self.NoWifiView.hidden=NO;
        }
        
        _height=self.contentSize.height;
        if(_height<=self.frame.size.height){
            _height=self.frame.size.height;
        }
        
        //底部
        if(self.isfootRefresh==YES){
            if(!self.footder){
                self.footder=[[UIView alloc]initWithFrame:CGRectMake(0, _height, self.bounds.size.width,RefreshTop)];
                _foottitle=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.footder.bounds.size.width, self.footder.bounds.size.height)];
                _foottitle.textAlignment=NSTextAlignmentCenter;
                _foottitle.font=[UIFont systemFontOfSize:14];
                _foottitle.text=@"上拉加载更多";
                _foottitle.textColor=[UIColor lightGrayColor];
                [self.footder addSubview:_foottitle];
                [self addSubview:self.footder];
            }
        }
        self.footder.frame=CGRectMake(0, _height, self.bounds.size.width,RefreshTop);
    }
}

//********IOS UIScrollView代理方法有很多，从头文件中找出来学习一下********

//只要滚动了就会触发
- (void)scrollViewDidScroll:(UIScrollView *)scrollView;
{
    [_slimeView scrollViewDidScroll];
    CGFloat height=0;
    if(self.contentSize.height-self.bounds.size.height<=0){
        height=RefreshTop;
    }else{
        height=self.contentSize.height-self.bounds.size.height+RefreshTop;
    }
    NSLog(@"我有多高呢:%f     %f     %f",_height+RefreshTop,height,scrollView.contentOffset.y);
    if(scrollView.contentOffset.y>0){
        if(scrollView.contentOffset.y+scrollView.bounds.size.height>_height+RefreshTop){
            _foottitle.text=@"松开立即刷新";
        }else if(scrollView.contentOffset.y==height){
            _foottitle.text=@"正在加载数据";
            NSLog(@"我不是进来了么");
        }else{
            _foottitle.text=@"上拉加载更多";
        }
    }
     NSLog(@"我到底还是进来了");
    NSLog(@"ContentOffset  x is  %f,yis %f",scrollView.contentOffset.x,scrollView.contentOffset.y);
}

//将开始降速时
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView;
{
    if(self.isfootRefresh==NO){
        return;
    }
    //底部开始刷新了
    if(_height!=0){
        if(scrollView.contentOffset.y>0){
           
            if(scrollView.contentOffset.y+scrollView.bounds.size.height>=_height+RefreshTop){
                _oldheight=_height;
                [scrollView setContentOffset:CGPointMake(0, _height+RefreshTop-scrollView.bounds.size.height) animated:YES];
                NSLog(@"我是打印出来的偏移量 %f   %f",scrollView.contentOffset.y,_height+RefreshTop-scrollView.bounds.size.height);
                _foottitle.text=@"正在加载数据";
                 NSLog(@"正在加载数据");
                self.Refootfreshblock(1);
            }
        }
    }
   
}

-(void)Click
{
    [self setContentOffset:CGPointMake(0, 0) animated:YES];
}

-(void)Clicks
{
   
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    //完成拖拽
    [_slimeView scrollViewDidEndDraging];
}

- (void)dealloc
{
    [self removeObserver:self forKeyPath:@"contentOffset"];
}


#pragma mark - slimeRefresh delegate

- (void)slimeRefreshStartRefresh:(SRRefreshView *)refreshView
{
     self.Reheadfreshblock(1);
   // [self endAllRefresh];
   // [self endheadRefreshing];
}

#pragma mark-监听下拉上拉刷新的
-(void)TagetHeadFresh:(CollecHeadBlock)Reheadfreshblock andCollecFootBlock:(CollecFootBlock)Refootfreshblock
{
    [self addheader];
    self.Reheadfreshblock= ^(NSInteger index){
        NSLog(@"头部开始刷新了");
        Reheadfreshblock(1);
    };
    self.Refootfreshblock= ^(NSInteger index){
        NSLog(@"底部开始刷新了");
        Refootfreshblock(1);
    };
}


#pragma mark-监听只刷新head的时候
-(void)TagetOnlyHeadFresh:(CollecHeadBlock)Reheadfreshblock
{
    self.isfootRefresh=NO;
    [self addheader];
    self.Reheadfreshblock= ^(NSInteger index){
        NSLog(@"头部开始刷新了");
        Reheadfreshblock(1);
    };
}








///所有头部停止刷新
-(void)beginheadRefreshing
{
    [_slimeView setLoadingWithexpansion];
    
    //[self endAllRefresh];
    NSLog(@"我到底执行了么");
   // [_slimeView setLoading:YES];
    [self setContentOffset:CGPointMake(0, -60) animated:YES];
    self.Reheadfreshblock(1);
     //self.Refootfreshblock(1);
}

///所有头部停止停止
-(void)endheadRefreshing
{
    [_slimeView performSelector:@selector(endRefresh)
                     withObject:_slimeView afterDelay:1.0
                        inModes:[NSArray arrayWithObject:NSRunLoopCommonModes]];
}


///所有底部刷新
-(void)beginfootRefreshing
{
   // 暂时不支持---后面完善
    CGFloat height=0;
    if(self.contentSize.height-self.bounds.size.height<=0){
        height=RefreshTop;
    }else{
        height=self.contentSize.height-self.bounds.size.height+RefreshTop;
    }
    NSLog(@"我是偏移的量:%f",height);
    [self setContentOffset:CGPointMake(0,height) animated:YES];
    //[self scrollViewWillBeginDecelerating:self];
     _foottitle.text=@"正在加载数据";
}


///所有头部底部停止
-(void)endfootRefreshing
{
    [self setContentOffset:CGPointMake(0,_oldheight-self.bounds.size.height+RefreshTop) animated:YES];
    
    [self performSelector:@selector(endfoot)
                     withObject:self afterDelay:0.0
                        inModes:[NSArray arrayWithObject:NSRunLoopCommonModes]];

}

-(void)endfoot
{
        [UIView animateWithDuration:2.0 animations:^{
            _foottitle.text=@"上拉加载更多";
            [self setContentOffset:CGPointMake(0,_oldheight-self.bounds.size.height) animated:YES];
        }];
}


///停止所有刷新
-(void)endAllRefresh
{
    NSLog(@"我的偏移量是多少呢:%f",self.contentOffset.y);
    
        if(self.contentOffset.y<=RefreshTop){
            NSLog(@"停止头部刷新");
            [self endheadRefreshing];
        }else{
             NSLog(@"停止底部刷新");
            [self endfootRefreshing];
        }
    
}


#pragma mark-tableview  delegate-or-datasource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return [self.VC tableView:self heightForRowAtIndexPath:indexPath];
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.VC tableView:tableView didSelectRowAtIndexPath:indexPath];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return [self.VC tableView:tableView heightForHeaderInSection:section];
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
     return [self.VC tableView:tableView heightForFooterInSection:section];
}













+(TTTableview*)tableviewWithFram:(CGRect)fram target:(id)target backcolor:(UIColor*)color
{
    TTTableview* tableview=[[TTTableview alloc]initWithFrame:fram];
    tableview.delegate=target;
    tableview.dataSource=target;
    tableview.delegate=target;
    tableview.VC=target;
    tableview.tableFooterView=[[UIView alloc]init];
    if(color){
        tableview.backgroundColor=color;
    }
    else{
        tableview.backgroundColor=[UIColor clearColor];
    }
    return tableview;
}




@end
