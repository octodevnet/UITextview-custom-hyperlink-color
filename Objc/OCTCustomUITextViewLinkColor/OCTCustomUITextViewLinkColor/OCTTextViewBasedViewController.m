//
//  OCTTextViewBasedViewController.m
//  OCTCustomUITextViewLinkColor
//
//  Created by dmitry.brovkin on 4/26/17.
//  Copyright © 2017 dmitry.brovkin. All rights reserved.
//

#import "OCTTextViewBasedViewController.h"
#import "OCTTextView.h"


static NSString *const kLinkUrl = @"http://yourlinkhere.com";


@implementation UIColor (Hyperlink)
+ (UIColor *)linkYellowColor {
    return [UIColor colorWithRed:225.0/255.0 green:196.0/255.0 blue:40.0/255.0 alpha:1];
}

+ (UIColor *)linkGreenColor {
    return [UIColor colorWithRed:51.0/255.0 green:255.0/255.0 blue:0.0/255.0 alpha: 1];
}

+ (UIColor *)linkRedColor {
    return [UIColor colorWithRed:249.0/255.0 green:0.0/255.0 blue:35.0/255.0 alpha: 1];
}

@end


@implementation NSMutableAttributedString (Hyperlink)

- (void)addLink:(NSString *)link linkColor:(UIColor *)linkColor text:(NSString *)text {
    NSString *pattern = [NSString stringWithFormat:@"(%@)", text];
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:nil];
    
    NSArray<NSTextCheckingResult *> *matches = [regex matchesInString:self.string options:0 range:NSMakeRange(0, self.length)];
    
    for (NSTextCheckingResult *result in matches) {
        [self addAttribute:OCTLinkAttributeName value:link range:[result rangeAtIndex:0]];
        [self addAttribute:NSForegroundColorAttributeName value:linkColor range:[result rangeAtIndex:0]];
    }
}

@end


@interface OCTTextViewBasedViewController () <UITextViewDelegate>

@property (nonatomic, weak) IBOutlet OCTTextView *jobsTextView;
@property (nonatomic, weak) IBOutlet OCTTextView *cookTextView;

@end


@implementation OCTTextViewBasedViewController

#pragma mark Life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"UITextView based controller";
    
    [self loadJobsSpeech];
    [self loadCookSpeech];
}

#pragma mark UITextViewDelegate methods

- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange interaction:(UITextItemInteraction)interaction {
    NSLog(@"%@", URL.absoluteString);
    return NO;
}

#pragma mark Private methods

- (void)loadJobsSpeech {
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"jobs_original_speech" withExtension:@"txt"];
    NSString *text = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text];
    
    [attributedString addLink:kLinkUrl linkColor:[UIColor linkYellowColor] text:@"universities in the world"];
    [attributedString addLink:kLinkUrl linkColor:[UIColor linkGreenColor] text:@"college graduation"];
    [attributedString addLink:kLinkUrl linkColor:[UIColor linkRedColor] text:@"three stories"];
    [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16] range:NSMakeRange(0, attributedString.string.length)];
    
    self.jobsTextView.attributedText = attributedString;
}

- (void)loadCookSpeech {
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"cook_original_speech" withExtension:@"txt"];
    NSString *text = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text];
    
    [attributedString addLink:kLinkUrl linkColor:[UIColor linkYellowColor] text:@"company"];
    [attributedString addLink:kLinkUrl linkColor:[UIColor linkGreenColor] text:@"individual"];
    [attributedString addLink:kLinkUrl linkColor:[UIColor linkRedColor] text:@"North Star"];
    [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16] range:NSMakeRange(0, attributedString.string.length)];
    
    self.cookTextView.attributedText = attributedString;
}

@end
