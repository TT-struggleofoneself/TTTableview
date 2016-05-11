//
//  UIViewController+TTViewController.m
//  ReshTableview
//
//  Created by TT_code on 16/1/27.
//  Copyright © 2016年 TT_code. All rights reserved.
//

#import "UIViewController+TTViewController.h"

@implementation UIViewController (TTViewController)

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0;
}




-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     [tableView deselectRowAtIndexPath:indexPath animated:YES];
}










- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView NS_AVAILABLE_IOS(3_2)
{
    
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset NS_AVAILABLE_IOS(5_0){
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
}
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    
}
//
//- (nullable UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
//    return nil;
//}
//- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(nullable UIView *)view NS_AVAILABLE_IOS(3_2){
//    
//}
//- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(nullable UIView *)view atScale:(CGFloat)scale{
//    
//}
//
//- (BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView{
//    return YES;
//}
//- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView{
//    
//}
@end
