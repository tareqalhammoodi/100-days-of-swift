//
//  WebView.swift
//  Project16
//
//  Created by Tareq Alhammoodi on 15.08.2023.
//

import UIKit
import WebKit

class WebView: UIViewController {

    var location: String!
    
    private let webView: WKWebView = {
            let webView = WKWebView()
            return webView
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .systemBackground
        view.addSubview(webView)
        let url = URL(string: "https://en.wikipedia.org/wiki/\(location!.lowercased())")!
        webView.load(URLRequest(url: url))
    }
    
    override func viewDidLayoutSubviews() {
            super.viewDidLayoutSubviews()
            webView.frame = view.bounds
        }

}
