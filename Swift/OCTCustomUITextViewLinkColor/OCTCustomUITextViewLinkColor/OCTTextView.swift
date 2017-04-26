//
//  OCTTextView.swift
//  OCTCustomUITextViewLinkColor
//
//  Created by fantom on 4/20/17.
//  Copyright © 2017 dmitry.brovkin. All rights reserved.
//

import UIKit

let OCTLinkAttributeName = "OCTLinkAttributeName"

class OCTTextView: UITextView {
    
    private let _linksAttributes = [OCTLinkAttributeName, NSLinkAttributeName]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let tapGest = UITapGestureRecognizer(target: self, action: #selector(self.onTapAction))
        self.addGestureRecognizer(tapGest)
    }
    
    @objc private func onTapAction(_ tapGest: UITapGestureRecognizer) {
        let location = tapGest.location(in: self)
        let charIndex = self.layoutManager.characterIndex(for: location, in: self.textContainer, fractionOfDistanceBetweenInsertionPoints: nil)
        
        if charIndex < self.textStorage.length {
            var range = NSMakeRange(0, 0)
            
            for linkAttribute in _linksAttributes {
                if let link = self.attributedText.attribute(linkAttribute, at: charIndex, effectiveRange: &range) as? String {
                    _ = self.delegate?.textView?(self, shouldInteractWith: URL(string: link)!, in: range, interaction: .invokeDefaultAction)
                }
            }
        }
    }
}
