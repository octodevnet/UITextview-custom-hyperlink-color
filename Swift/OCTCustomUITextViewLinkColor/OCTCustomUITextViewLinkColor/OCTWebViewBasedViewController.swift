//
//  OCTViewController_v1.swift
//  OCTCustomUITextViewLinkColor
//
//  Created by dmitry.brovkin on 4/19/17.
//  Copyright © 2017 dmitry.brovkin. All rights reserved.
//

import UIKit

extension String {
    mutating func addLink(_ link: String, linkHexColor: String, text: String) {
        let targetString = "<a href=\(link) style=\"color:\(linkHexColor); text-decoration:none\" >\(text)</a>"
        self = self.replacingOccurrences(of: text, with: targetString)
    }
}

private let kLinkUrl = "http://yourlinkhere.com"

private let kYellowColor = "#e1c428"
private let kGreenColor = "#33ff00"
private let kRedColor = "#f90023"


class OCTWebViewBasedViewController: UITableViewController, UIWebViewDelegate {
    @IBOutlet weak var jobsWebView: UIWebView!
    @IBOutlet weak var cookWebView: UIWebView!

    //MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.jobsWebView.scrollView.bounces = false
        self.cookWebView.scrollView.bounces = false

        self.title = "WebView based controller"

        self.loadJobsSpeech()
        self.loadCookSpeech()
    }
    
    //MARK: UIWebViewDelegate methods
    public func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        print(request.url!)
        return request.url!.absoluteString.hasPrefix("file:")
    }
    
    //MARK: Private methods
    private func loadJobsSpeech() {
        let url = Bundle.main.url(forResource: "jobs_completed_speech", withExtension: "html")
        self.jobsWebView.loadRequest(URLRequest(url: url!))
    }
    
    private func loadCookSpeech() {
        let url = Bundle.main.url(forResource: "cook_complete_speech", withExtension: "html")
        self.cookWebView.loadRequest(URLRequest(url: url!))
    }
    
    private func loadFormattedJobsSpeech() {
        let url = Bundle.main.url(forResource: "jobs_original_speech", withExtension: "txt")
        var text = try! String(contentsOf: url!, encoding: String.Encoding.utf8)
        
        text.addLink(kLinkUrl, linkHexColor: kYellowColor, text: "universities in the world")
        text.addLink(kLinkUrl, linkHexColor: kGreenColor, text: "college graduation")
        text.addLink(kLinkUrl, linkHexColor: kRedColor, text: "three stories")
        
        let htmlFileUrl = Bundle.main.url(forResource: "template", withExtension: "html")
        var htmlText = try! String(contentsOf: htmlFileUrl!, encoding: String.Encoding.utf8)
        htmlText = htmlText.replacingOccurrences(of: "${text}", with: text)
        
        self.jobsWebView.loadHTMLString(htmlText, baseURL: Bundle.main.bundleURL)
    }
}
