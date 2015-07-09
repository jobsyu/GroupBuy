//
//  DetailViewController.m
//  GroupBuy
//
//  Created by qianfeng on 15/7/9.
//  Copyright (c) 2015年 ycp. All rights reserved.
//

#import "DetailViewController.h"
#import "Deal.h"

@interface DetailViewController() <UIWebViewDelegate>
@property (weak,nonatomic) IBOutlet UIWebView *webView;
@property (weak,nonatomic) IBOutlet UIActivityIndicatorView *loadingView;
@end

@implementation DetailViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    
    self.view.backgroundColor = GBGlobalBg;
    self.webView.hidden = YES;
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.deal.deal_h5_url]]];
}

-(NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscape;
}

#pragma mark －UIWebViewDelegate
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    GBLog(@"%@",webView.request.URL.absoluteString);
    GBLog(@"%@",self.deal.deal_h5_url);
    if ([webView.request.URL.absoluteString isEqualToString:self.deal.deal_h5_url]) {
        //旧的HTML5页面加载完毕
        NSString *ID = [self.deal.deal_id substringFromIndex:[self.deal.deal_id rangeOfString:@"-"].location +1];
        NSString *urlStr = [NSString stringWithFormat:@"http://lite.m.dianping.com/group/deal/moreinfo/%@", ID];
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]]];
    } else {//详情页面加载完毕
        //用来拼接所有的JS
        NSMutableString *js = [NSMutableString string];
        // 删除header
        [js appendString:@"var header = document.getElementsByTagName('header')[0];"];
        [js appendString:@"header.parentNode.removeChild(header);"];
        // 删除顶部的购买
        [js appendString:@"var box = document.getElementsByClassName('cost-box')[0];"];
        [js appendString:@"box.parentNode.removeChild(box);"];
        // 删除底部的购买
        [js appendString:@"var buyNow = document.getElementsByClassName('buy-now')[0];"];
        [js appendString:@"buyNow.parentNode.removeChild(buyNow);"];
        
        //利用webView执行JS
        [webView stringByEvaluatingJavaScriptFromString:js];
        
        //获得页面
        webView.hidden = NO;
        //隐藏正在加载
        [self.loadingView stopAnimating];
    }
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    return YES;
}
@end
