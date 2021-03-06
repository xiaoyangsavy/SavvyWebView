//
//  ViewController.m
//  SavvyWebView
//
//  Created by savvy on 16/2/3.
//  Copyright © 2016年 Savvy. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property(nonatomic,strong) UIProgressView  *myWebProgress;//浏览器加载条
 @property(nonatomic,strong) WKWebView         *myWebView;//浏览器视图
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    
    self.myWebView = [[WKWebView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
      self.myWebView.backgroundColor = [UIColor clearColor];
      self.myWebView.navigationDelegate = self;
      self.myWebView.tag = 1000000;
    
    [  self.myWebView setFrame:CGRectMake(0.0f, 0.0f, [UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.size.height-44)];
    
    NSURL *urlS = [[NSURL alloc] initWithString:@"https://www.hao123.com"];
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:urlS];
    [req setTimeoutInterval:300];
    [self.myWebView loadRequest:req];
 
    [self.view addSubview:   self.myWebView];
 
 
    
    [self.myWebView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    [self.myWebView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
    
    self.myWebProgress = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    [self.view addSubview:self.myWebProgress];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

# pragma WebKit delegate

- (void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    if ([keyPath isEqual:@"estimatedProgress"]) {
        self.myWebProgress.hidden = self.myWebView.estimatedProgress == 1;
        [self.myWebProgress setProgress:self.myWebView.estimatedProgress animated:true];
//        NSLog(@"当前进度为%f!!!!",self.myWebView.estimatedProgress);
    }else if([keyPath isEqual:@"title"]) {
        self.navigationItem.title = self.myWebView.title;
    }
}
@end
