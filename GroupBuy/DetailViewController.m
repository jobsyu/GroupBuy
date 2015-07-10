//
//  DetailViewController.m
//  GroupBuy
//
//  Created by qianfeng on 15/7/9.
//  Copyright (c) 2015年 ycp. All rights reserved.
//

#import "DetailViewController.h"
#import "Deal.h"
#import "Restrictions.h"
#import "DPAPI.h"
#import "MJExtension.h"
#import "MBProgressHUD+MJ.h"
#import "DealTool.h"

@interface DetailViewController() <UIWebViewDelegate,DPRequestDelegate>
@property (weak,nonatomic) IBOutlet UIWebView *webView;
@property (weak,nonatomic) IBOutlet UIActivityIndicatorView *loadingView;
-(IBAction)back;
@property (weak,nonatomic) IBOutlet UILabel *titleLabel;
@property (weak,nonatomic) IBOutlet UILabel *descLabel;
-(IBAction)buy;
-(IBAction)collect;
-(IBAction)share;
@property (weak,nonatomic) IBOutlet UIButton *collectButton;
@property (weak,nonatomic) IBOutlet UIButton *refundableAnyTimeButton;
@property (weak,nonatomic) IBOutlet UIButton *refundableExpireButton;
@property (weak,nonatomic) IBOutlet UIButton *leftTimeButton;
@end

@implementation DetailViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    
    //基本设置
    self.view.backgroundColor = GBGlobalBg;
    //加载网页
    self.webView.hidden = YES;
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.deal.deal_h5_url]]];
    
    //设置基本信息
    self.titleLabel.text =self.deal.title;
    self.descLabel.text =self.deal.desc;
    
    //设置剩余时间
    NSDateFormatter *fmt =[[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    NSDate *dead = [fmt dateFromString:self.deal.purchase_deadline];
    //追加一天
    dead = [dead dateByAddingTimeInterval:24 * 60 *60];
    NSDate *now = [NSDate date];
    NSCalendarUnit unit = NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute;
    NSDateComponents *cmps = [[NSCalendar currentCalendar] components:unit fromDate:now toDate:dead options:0];
    if (cmps.day > 365) {
        [self.leftTimeButton setTitle:@"一年内不过期" forState:UIControlStateNormal];
    } else {
        [self.leftTimeButton setTitle:[NSString stringWithFormat:@"%ld天%ld小时%ld分钟",cmps.day,cmps.hour,cmps.minute] forState:UIControlStateNormal];
    }
    
    //发送请求获得更详细的数据
    DPAPI *api = [[DPAPI alloc] init];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    //页码
    params[@"deal_id"] = self.deal.deal_id;
    [api requestWithURL:@"v1/deal/get_single_deal" params:params delegate:self];
    
    //设置收藏状态
    self.collectButton.selected = [DealTool isCollected:self.deal];
}

-(NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscape;
}

#pragma mark －UIWebViewDelegate
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
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

//-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
//{
//    GBLog(@"%@",webView.request.URL.absoluteString);
//    GBLog(@"%@",self.deal.deal_h5_url);
//    return YES;
//}


#pragma mark － DPRequestDelegate
-(void)request:(DPRequest *)request didFinishLoadingWithResult:(id)result
{
    self.deal = [Deal objectWithKeyValues:[result[@"deals"] firstObject]];
    //设置退款信息
    self.refundableAnyTimeButton.selected = self.deal.restrictions.is_refundable;
    self.refundableExpireButton.selected = self.deal.restrictions.is_refundable;
}

-(void)request:(DPRequest *)request didFailWithError:(NSError *)error
{
    [MBProgressHUD showError:@"网络繁忙,请稍后再试" toView:self.view];
}

-(IBAction)back
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


-(IBAction)collect
{
    if (self.collectButton.selected) {//取消收藏
        [MBProgressHUD showSuccess:@"取消收藏" toView:self.view];
        [DealTool removeCollectDeal:self.deal];
    } else {//收藏成功
        [MBProgressHUD showSuccess:@"收藏成功" toView:self.view];
        [DealTool addCollectDeal:self.deal];
    }
    
    //状态取反
    self.collectButton.selected =!self.collectButton.isSelected;
    
    //发通知
    [MTNotificationCenter postNotificationName:CollectDidChangeNotification object:nil];
}

-(IBAction)share
{

}

-(IBAction)buy
{
   
}

@end
