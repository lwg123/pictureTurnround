//
//  CollectionHeaderView.h
//  轮播图片
//
//  Created by weiguang on 2018/4/16.
//  Copyright © 2018年 weiguang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectionHeaderView : UICollectionReusableView<UIScrollViewDelegate>
{
@private
    UIScrollView *_adScrollView;
    UIPageControl *_pageScrollIndicator;
    NSTimer *_scrollTimer;
    NSArray *_imageArray;
}

- (void)setAdsWith:(NSArray *)imageArray frame:(CGRect)frame;

@end
