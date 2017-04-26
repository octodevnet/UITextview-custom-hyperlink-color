//
//  OCTTextView.m
//  OCTCustomUITextViewLinkColor
//
//  Created by dmitry.brovkin on 4/26/17.
//  Copyright © 2017 dmitry.brovkin. All rights reserved.
//

#import "OCTTextView.h"

NSString *const OCTLinkAttributeName = @"OCTLinkAttributeName";


@implementation OCTTextView
{
    NSArray<NSString *> *_linksAttributes;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    _linksAttributes = @[OCTLinkAttributeName, NSLinkAttributeName];
    
    UITapGestureRecognizer *tapGest = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTapAction:)];
    [self addGestureRecognizer:tapGest];
}

- (void)onTapAction:(UITapGestureRecognizer *)tapGest {
    CGPoint location = [tapGest locationInView:self];
    NSInteger charIndex = [self.layoutManager characterIndexForPoint:location
                                                     inTextContainer:self.textContainer
                            fractionOfDistanceBetweenInsertionPoints:nil];
    
    if (charIndex < self.textStorage.length) {
        NSRange range = NSMakeRange(0, 0);
        
        for (NSString *linkAttribute in _linksAttributes) {
            NSString *link = [self.attributedText attribute:linkAttribute atIndex:charIndex effectiveRange:&range];
            
            if ([link isKindOfClass:[NSString class]] && [link length]) {
                if (self.delegate && [self.delegate respondsToSelector:@selector(textView:shouldInteractWithURL:inRange:interaction:)]) {
                    [self.delegate textView:self shouldInteractWithURL:[NSURL URLWithString:link] inRange:range interaction:UITextItemInteractionInvokeDefaultAction];
                }
            }
        }
    }
}

@end
