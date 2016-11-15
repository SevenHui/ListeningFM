//
//  XQ_WKWebViewController.m
//  ListeningFM
//
//  Created by apple on 16/10/8.
//  Copyright © 2016年 Ma Baihui. All rights reserved.
//

#import "XQ_WKWebViewController.h"
#import <WebKit/WebKit.h>

@interface XQ_WKWebViewController ()
<WKScriptMessageHandler>
/**WKWebview*/
@property (nonatomic, retain)WKWebView *wkWebView;

@end

@implementation XQ_WKWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = _strTitle;
    self.view.backgroundColor = [UIColor colorWithRed:0.93 green:0.93 blue:0.91 alpha:1.00];
   
    [self createNavigation];
    
    [self creatWKWebView];
    
        

}

-(void)creatWKWebView{
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc]init];
    // 设置html页面 显示字体大小 默认是0
    config.preferences.minimumFontSize = 0;
    // 是否启用js 默认是yes
    config.preferences.javaScriptEnabled = YES;
    [config.userContentController addScriptMessageHandler:self name:@"AppModel"];
        
    self.wkWebView = [[WKWebView alloc]initWithFrame:CGRectMake(0, 0, WIDTHSCREEN, HEIGHTSCREEN - 64) configuration:config];
    [self.view addSubview:_wkWebView];
    self.wkWebView.scrollView.backgroundColor = [UIColor whiteColor];
    [self.wkWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.strURL]]];
    
}
-(void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    
    if ([message.name isEqualToString:@"AppModel"]) {
        NSLog(@"%@", message.body);
        
    }
    
}



@end
