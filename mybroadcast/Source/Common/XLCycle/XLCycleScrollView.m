//
//  XLCycleScrollView.m
//  CycleScrollViewDemo
//
//  Created by xie liang on 9/14/12.
//  Copyright (c) 2012 xie liang. All rights reserved.
//

#import "XLCycleScrollView.h"

@implementation XLCycleScrollView

@synthesize scrollView = _scrollView;
@synthesize pageControl = _pageControl;
@synthesize currentPage = _curPage;
@synthesize datasource = _datasource;
@synthesize delegate = _delegate;
@synthesize httpImage = _image;
@synthesize httpText = _text;

- (void)dealloc
{
    [_scrollView release];
    [_pageControl release];
    [_curViews release];
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        _scrollView.delegate = self;
        _scrollView.contentSize = CGSizeMake(self.bounds.size.width * 5, self.bounds.size.height);
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.contentOffset = CGPointMake(0, 0);
        _scrollView.pagingEnabled = YES;
        [self addSubview:_scrollView];
        
        _curPage = 0;
        _pageControl.numberOfPages = _totalPages;
        _pageControl.currentPage = _curPage;
        CGRect rect = self.bounds;
        rect.origin.y = rect.size.height - 30;
        rect.size.height = 30;
        _pageControl = [[MyPageControl alloc] initWithFrame:rect];
        _pageControl.userInteractionEnabled = NO;
        _pageControl.backgroundColor = [UIColor clearColor];
        [_pageControl setImagePageStateNormal:[UIImage imageNamed:@"BluePoint.png"]];
        [_pageControl setImagePageStateHightlighted:[UIImage imageNamed:@"stop-32.png"]];
        [self addSubview:_pageControl];
        
    }
    return self;
}

- (void)setDataource:(id<XLCycleScrollViewDatasource>)datasource
{
    _datasource = datasource;
    [self reloadData];
}

- (void)reloadData
{
    _totalPages = [_datasource numberOfPages];
    if (_totalPages == 0) {
        return;
    }
    _pageControl.numberOfPages = _totalPages;
    [self loadData];
}

- (void)loadData
{
    
    _pageControl.currentPage = _curPage;
    
	NSArray *subView = _pageControl.subviews;     // UIPageControl的每个点
    
	for (int i = 0; i < [subView count]; i++) {
		UIImageView *dot = [subView objectAtIndex:i];
		dot.image = (_pageControl.currentPage == i ? [UIImage imageNamed:@"stop-32.png"] : [UIImage imageNamed:@"BluePoint.png"]);
	}
    //从scrollView上移除所有的subview
    NSArray *subViews = [_scrollView subviews];
    if([subViews count] != 0) {
        [subViews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    }
    
    [self getDisplayImagesWithCurpage:_curPage];
    
    for (int i = 0; i < [_curViews count]; i++) {
        UIView *v = [_curViews objectAtIndex:i];
        v.userInteractionEnabled = YES;
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                    action:@selector(handleTap:)];
        [v addGestureRecognizer:singleTap];
        [singleTap release];
        v.frame = CGRectOffset(v.frame, v.frame.size.width * i, 0);
        [_scrollView addSubview:v];
    }
    
    [_scrollView setContentOffset:CGPointMake(_scrollView.frame.size.width*0, 0)];
}

- (void)getDisplayImagesWithCurpage:(int)page {
    if (!_curViews) {
        _curViews = [[NSMutableArray alloc] init];
    }
    
    [_curViews removeAllObjects];
    int leng = [_pageControl.subviews count]<5?[_pageControl.subviews count]:5;
    for (int i=0; i<leng; i++) {
        [_curViews addObject:[_datasource pageAtIndex:i]];
    }
    
}

- (int)validPageValue:(NSInteger)value {
    
    if(value == -1) value = _totalPages - 1;
    if(value == _totalPages) value = 0;
    
    return value;
    
}

- (void)handleTap:(UITapGestureRecognizer *)tap {
    
    if ([_delegate respondsToSelector:@selector(didClickPage:atIndex:)]) {
        [_delegate didClickPage:self atIndex:_curPage];
    }
    
}

- (void)setViewContent:(UIView *)view atIndex:(NSInteger)index
{
    if (index == _curPage) {
        [_curViews replaceObjectAtIndex:1 withObject:view];
        for (int i = 0; i < 3; i++) {
            UIView *v = [_curViews objectAtIndex:i];
            v.userInteractionEnabled = YES;
            UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                        action:@selector(handleTap:)];
            [v addGestureRecognizer:singleTap];
            [singleTap release];
            v.frame = CGRectOffset(v.frame, v.frame.size.width * i, 0);
            [_scrollView addSubview:v];
        }
    }
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)aScrollView {
    
    
//	CGFloat pageWidth = _scrollView.frame.size.width;
//	int page = floor((_scrollView.contentOffset.x - pageWidth/2)/pageWidth) + 1;
//	_pageControl.currentPage = page;
	
//	NSArray *subView = _pageControl.subviews;     // UIPageControl的每个点
//    
//	for (int i = 0; i < [subView count]; i++) {
//		UIImageView *dot = [subView objectAtIndex:i];
//		dot.image = (_pageControl.currentPage == i ? [UIImage imageNamed:@"stop-32.png"] : [UIImage imageNamed:@"BluePoint.png"]);
//	}
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)aScrollView {
    int x = aScrollView.contentOffset.x;
    _curPage = x/320;
    _pageControl.currentPage = _curPage;
    [_pageControl setImagePageStateNormal:[UIImage imageNamed:@"BluePoint.png"]];
    [_pageControl setImagePageStateHightlighted:[UIImage imageNamed:@"stop-32.png"]];
    //[_scrollView setContentOffset:CGPointMake(_scrollView.frame.size.width, 0) animated:YES];
    
}

@end
