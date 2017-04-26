//
//  OCTWebViewBasedViewController.m
//  OCTCustomUITextViewLinkColor
//
//  Created by dmitry.brovkin on 4/26/17.
//  Copyright © 2017 dmitry.brovkin. All rights reserved.
//

#import "OCTWebViewBasedViewController.h"


static NSString *const kLinkUrl = @"http://yourlinkhere.com";

static NSString *const kYelowColor = @"#e1c428";
static NSString *const kGreenColor = @"#33ff00";
static NSString *const kRedColor = @"#f90023";


@implementation NSMutableString (Hyperlink)

- (void)addLink:(NSString *)link linkHexColor:(NSString *)linkHexColor text:(NSString *)text {
    NSString *targetString = [NSString stringWithFormat:@"<a href=%@ style=\"color:%@; text-decoration:none\" >%@</a>", link, linkHexColor, text];
    [self replaceOccurrencesOfString:text withString:targetString options:NSCaseInsensitiveSearch range:NSMakeRange(0, self.length)];
}

@end


@interface OCTWebViewBasedViewController () <UIWebViewDelegate>

@property (nonatomic, weak) IBOutlet UIWebView *jobsWebView;
@property (nonatomic, weak) IBOutlet UIWebView *cookWebView;

@end


@implementation OCTWebViewBasedViewController

#pragma mark Life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.jobsWebView.scrollView.bounces = false;
    self.cookWebView.scrollView.bounces = false;

    self.title = @"WebView based controller";

    [self loadJobsSpeech];
    [self loadCookSpeech];
}

#pragma mark UIWebViewDelegate methods

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSLog(@"%@", request.URL.absoluteString);
    return [request.URL.absoluteString hasPrefix:@"file:"];
}

#pragma mark Private methods

- (void)loadJobsSpeech {
    NSURL *url = [[NSBundle mainBundle]  URLForResource:@"jobs_completed_speech" withExtension:@"html"];
    [self.jobsWebView loadRequest:[NSURLRequest requestWithURL:url]];
}

- (void)loadCookSpeech {
    NSURL *url = [[NSBundle mainBundle]  URLForResource:@"cook_complete_speech" withExtension:@"html"];
    [self.cookWebView loadRequest:[NSURLRequest requestWithURL:url]];
}

- (void)loadFormattedJobsSpeech {
    NSURL *url = [[NSBundle mainBundle]  URLForResource:@"jobs_original_speech" withExtension:@"txt"];
    NSMutableString *text = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil].mutableCopy;

    [text addLink:kLinkUrl linkHexColor:kYelowColor text:@"universities in the world"];
    [text addLink:kLinkUrl linkHexColor:kGreenColor text:@"college graduation"];
    [text addLink:kLinkUrl linkHexColor:kRedColor text:@"three stories"];

    url = [[NSBundle mainBundle]  URLForResource:@"template" withExtension:@"html"];
    NSString *htmlText = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
    htmlText = [htmlText stringByReplacingOccurrencesOfString:@"${text}" withString:text];
    
    [self.jobsWebView loadHTMLString:htmlText baseURL:[NSBundle mainBundle].bundleURL];
}

@end
