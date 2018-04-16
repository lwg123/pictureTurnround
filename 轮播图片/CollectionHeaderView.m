//
//  CollectionHeaderView.m
//  轮播图片
//
//  Created by weiguang on 2018/4/16.
//  Copyright © 2018年 weiguang. All rights reserved.
//

#import "CollectionHeaderView.h"

@implementation CollectionHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        UIView *btmSeparator = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 0.5, self.frame.size.width, 0.5)];
        btmSeparator.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:btmSeparator];
    }
    return self;
}

- (void)setAdsWith:(NSArray *)imageArray frame:(CGRect)frame{
    // 先移除之前的，避免重复添加
    [_adScrollView removeFromSuperview];
    _adScrollView = nil;
    [_pageScrollIndicator removeFromSuperview];
    _pageScrollIndicator = nil;
    [_scrollTimer invalidate];
    _scrollTimer = nil;
    
    _adScrollView = [[UIScrollView alloc] initWithFrame:frame];
    _adScrollView.pagingEnabled = YES;
    _adScrollView.delegate = self;
    _adScrollView.showsHorizontalScrollIndicator = NO;
    _adScrollView.bounces = NO;
    [self addSubview:_adScrollView];
    
    _imageArray = imageArray;
    
    for (int i = 0; i < imageArray.count; i++) {
        UIImageView *AdView = [[UIImageView alloc] initWithFrame:CGRectMake(frame.origin.x + (i + 1) * frame.size.width, 0, frame.size.width, frame.size.height)];
        UIImage *Adimage = [UIImage imageNamed:[NSString stringWithFormat:@"%@",_imageArray[i]]];
        
        AdView.image = Adimage;
        AdView.userInteractionEnabled = YES;
        [_adScrollView addSubview:AdView];
        
    }
    
    if (_imageArray.count == 0) {
        
    }else {
         UIImageView *leftView = [[UIImageView alloc] initWithFrame:CGRectMake(frame.origin.x, 0, frame.size.width, frame.size.height)];
        UIImage *adimage = [UIImage imageNamed:[NSString stringWithFormat:@"%@",_imageArray.lastObject]];
        leftView.image = adimage;
        [_adScrollView addSubview:leftView];
        
        UIImageView *rightView = [[UIImageView alloc] initWithFrame:CGRectMake(frame.origin.x + (imageArray.count + 1) * frame.size.width, 0, frame.size.width, frame.size.height)];
        adimage = [UIImage imageNamed:[NSString stringWithFormat:@"%@",_imageArray[0]]];
        rightView.image = adimage;
        [_adScrollView addSubview:rightView];
    }
    
    _adScrollView.contentSize = CGSizeMake(frame.size.width * (imageArray.count + 2), frame.size.height);
    _adScrollView.contentOffset = CGPointMake(frame.size.width, 0);
    
    _pageScrollIndicator = [[UIPageControl alloc] initWithFrame:CGRectMake(0, frame.origin.y + frame.size.height - 20, frame.size.width, 20)];
    _pageScrollIndicator.numberOfPages = imageArray.count;
    _pageScrollIndicator.currentPageIndicatorTintColor = [UIColor lightGrayColor];
    _pageScrollIndicator.userInteractionEnabled = NO;
    [self addSubview:_pageScrollIndicator];
    
     _scrollTimer = [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(autoScroll) userInfo:nil repeats:YES];
    
}

- (void)autoScroll {
    int width = _adScrollView.frame.size.width;
    int xOffset = _adScrollView.contentOffset.x;
    int ratio = xOffset / width;
    [_adScrollView setContentOffset:CGPointMake(_adScrollView.frame.size.width * (ratio + 1), 0) animated:YES];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    int pageNum = scrollView.contentOffset.x / _adScrollView.frame.size.width;
    int num = (int)_pageScrollIndicator.numberOfPages + 1;
    if (pageNum == num) {
        _pageScrollIndicator.currentPage = 0;
        [_adScrollView setContentOffset:CGPointMake(_adScrollView.frame.size.width * (_pageScrollIndicator.currentPage + 1), 0) animated:NO];
        return;
    }
    
    _pageScrollIndicator.currentPage = scrollView.contentOffset.x / _adScrollView.frame.size.width - 1;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    int pageNum = scrollView.contentOffset.x / _adScrollView.frame.size.width;
   // NSLog(@"%d",pageNum);
    if (pageNum == 0) {
        _pageScrollIndicator.currentPage = _pageScrollIndicator.numberOfPages - 1;
        [_adScrollView setContentOffset:CGPointMake(_adScrollView.frame.size.width * (_pageScrollIndicator.currentPage + 1), 0) animated:NO];
        return;
    }
    if (pageNum == _pageScrollIndicator.numberOfPages + 1) {
        _pageScrollIndicator.currentPage = 0;
        [_adScrollView setContentOffset:CGPointMake(_adScrollView.frame.size.width * (_pageScrollIndicator.currentPage + 1), 0) animated:NO];
        return;
    }
}

@end
