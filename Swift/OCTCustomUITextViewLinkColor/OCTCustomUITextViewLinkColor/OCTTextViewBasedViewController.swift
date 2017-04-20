//
//  OCTViewController_v2.swift
//  OCTCustomUITextViewLinkColor
//
//  Created by dmitry.brovkin on 4/19/17.
//  Copyright © 2017 dmitry.brovkin. All rights reserved.
//

import UIKit

class OCTTextViewBasedViewController: UITableViewController, UITextViewDelegate {
    @IBOutlet weak var jobsTextView: UITextView!
    @IBOutlet weak var cookTextView: UITextView!
    
    //MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "UITextView based controller"
    }
    
    //MARK: UITextViewDelegate methods
    public func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        print(URL.absoluteString)
        return false
    }

}
