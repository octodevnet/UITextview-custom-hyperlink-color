//
//  OCTViewController_v2.swift
//  OCTCustomUITextViewLinkColor
//
//  Created by dmitry.brovkin on 4/19/17.
//  Copyright © 2017 dmitry.brovkin. All rights reserved.
//

import UIKit


extension NSMutableAttributedString {
    func addLink(_ link: String, linkColor: UIColor, text: String) {
        let pattern = "(\(text))"
        let regex = try! NSRegularExpression.init(pattern: pattern,
                                                  options: NSRegularExpression.Options(rawValue: 0))
        let matches = regex.matches(in: self.string,
                                    options: NSRegularExpression.MatchingOptions(rawValue: 0),
                                    range: NSRange.init(location: 0, length: self.string.count))
        
        for result in matches {
            self.addAttribute(NSAttributedStringKey(rawValue: OCTLinkAttributeName), value: link, range: result.range(at: 0))
            self.addAttribute(NSAttributedStringKey.foregroundColor, value: linkColor, range: result.range(at: 0))
        }
    }
}

private let kLinkUrl = "http://yourlinkhere.com"

private let kYellowColor = UIColor(red: 225.0/255.0, green: 196.0/255.0, blue: 40.0/255.0, alpha: 1)
private let kGreenColor = UIColor(red: 51.0/255.0, green: 255.0/255.0, blue: 0.0/255.0, alpha: 1)
private let kRedColor = UIColor(red: 249.0/255.0, green: 0.0/255.0, blue: 35.0/255.0, alpha: 1)


class OCTTextViewBasedViewController: UITableViewController, UITextViewDelegate {
    @IBOutlet weak var jobsTextView: OCTTextView!
    @IBOutlet weak var cookTextView: OCTTextView!
    
    //MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "UITextView based controller"
        
        self.loadJobsSpeech()
        self.loadCookSpeech()
    }
    
    //MARK: UITextViewDelegate methods
    public func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        print(URL.absoluteString)
        return false
    }
    
    //MARK: Private methods
    private func loadJobsSpeech() {
        let url = Bundle.main.url(forResource: "jobs_original_speech", withExtension: "txt")
        let text = try! String(contentsOf: url!, encoding: String.Encoding.utf8)
        let attributedString = NSMutableAttributedString(string: text)
        
        attributedString.addLink(kLinkUrl, linkColor: kYellowColor, text: "universities in the world")
        attributedString.addLink(kLinkUrl, linkColor: kGreenColor, text: "college graduation")
        attributedString.addLink(kLinkUrl, linkColor: kRedColor, text: "three stories")
        attributedString.addAttribute(NSAttributedStringKey.font, value: UIFont.systemFont(ofSize: 16),
                                      range: NSRange.init(location: 0, length: attributedString.string.count))
        
        self.jobsTextView.attributedText = attributedString
    }
    
    private func loadCookSpeech() {
        let url = Bundle.main.url(forResource: "cook_original_speech", withExtension: "txt")
        let text = try! String(contentsOf: url!, encoding: String.Encoding.utf8)
        let attributedString = NSMutableAttributedString(string: text)
        
        attributedString.addLink(kLinkUrl, linkColor: kYellowColor, text: "company")
        attributedString.addLink(kLinkUrl, linkColor: kGreenColor, text: "individual")
        attributedString.addLink(kLinkUrl, linkColor: kRedColor, text: "North Star")
        attributedString.addAttribute(NSAttributedStringKey.font, value: UIFont.systemFont(ofSize: 16),
                                      range: NSRange.init(location: 0, length: attributedString.string.count))
        
        self.cookTextView.attributedText = attributedString
    }
}
