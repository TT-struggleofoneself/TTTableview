//
//  TTTableview.h
//  ReshTableview
//
//  Created by TT_code on 15/12/20.
//  Copyright © 2015年 TT_code. All rights reserved.
//




#import <UIKit/UIKit.h>
#import "SRRefreshView.h"

/**
 *  头部刷新blok
 */
typedef void (^CollecHeadBlock) (NSInteger index);
/**
 *  底部刷新blok
 */
typedef void (^CollecFootBlock) (NSInteger index);







@interface TTTableview : UITableView



/**
 *  头部刷新
 */
@property(nonatomic,strong)SRRefreshView* headr;
/**
 *  底部刷新视图
 */
@property(nonatomic,strong)UIView*  footder;
/**
 *  头部刷新blok
 */
@property(nonatomic,strong)CollecHeadBlock Reheadfreshblock;
/**
 *  底部刷新blok
 */
@property(nonatomic,strong)CollecFootBlock Refootfreshblock;


/**
 *  代理
 */
@property(nonatomic,strong)UIViewController* VC;










/**
 *  是否需要显示头部刷新
 */
@property(nonatomic)BOOL isheadRefresh;
/**
 *  是否需要显示底部刷新
 */
@property(nonatomic)BOOL isfootRefresh;



/**
 *  创建tableview
 *
 *  @param fram   fram
 *  @param target
 *  @param color
 *
 *  @return  tableview
 */
+(TTTableview*)tableviewWithFram:(CGRect)fram target:(id)target backcolor:(UIColor*)color;



/**
 *  停止所有刷新
 */
-(void)endAllRefresh;
/**
 *  所有头部停止刷新
 */
-(void)beginheadRefreshing;
/**
 *  所有头部停止停止
 */
-(void)endheadRefreshing;
/**
 *  所有底部刷新
 */
-(void)beginfootRefreshing;
/**
 *  所有头部底部停止
 */
-(void)endfootRefreshing;










/**
 *  监听开始刷新事件
 */
-(void)TagetHeadFresh:(CollecHeadBlock)Reheadfreshblock andCollecFootBlock:(CollecFootBlock)Refootfreshblock;






/**
 *  只监听头部刷新
 *
 *  @param Reheadfreshblock  头部刷新block
 */
-(void)TagetOnlyHeadFresh:(CollecHeadBlock)Reheadfreshblock;




/**
 *  无wifi试图
 */
@property(nonatomic,strong)UIView* NoWifiView;
/**
 *  add  header  resh
 */
-(void)addheader;
@end
