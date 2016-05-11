//
//  UIViewController+TTViewController.h
//  ReshTableview
//
//  Created by TT_code on 16/1/27.
//  Copyright © 2016年 TT_code. All rights reserved.
//

#import <UIKit/UIKit.h>
///增加的TTviewController
@interface UIViewController (TTViewController)

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;


-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section;


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;













//scrollview  delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView;
- (void)scrollViewDidZoom:(UIScrollView *)scrollView NS_AVAILABLE_IOS(3_2);
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView;

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset NS_AVAILABLE_IOS(5_0);

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate;

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView;
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView;
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView;

//- (nullable UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView;
//- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(nullable UIView *)view ;
//- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(nullable UIView *)view atScale:(CGFloat)scale;
//
//- (BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView;
//- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView;
@end
