//
//  ViewController.swift
//  JLRoutesInSwift
//
//  Created by season on 2020/6/10.
//  Copyright © 2020 lostsakura. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    private func setUpUI() {
        let noArgumentPushButton = UIButton(frame: CGRect(x:  0, y:88, width: view.bounds.width, height: 44))
        noArgumentPushButton.setTitle("无参数push", for: .normal)
        noArgumentPushButton.backgroundColor = UIColor.lightGray
        noArgumentPushButton.addTarget(self, action: #selector(noArgumentPush), for: .touchUpInside)
        view.addSubview(noArgumentPushButton)
        
        let argumentPushButton = UIButton(frame: CGRect(x:  0, y: 132, width: view.bounds.width, height: 44))
        argumentPushButton.setTitle("传值push", for: .normal)
        argumentPushButton.backgroundColor = UIColor.lightGray
        argumentPushButton.addTarget(self, action: #selector(argumentPush), for: .touchUpInside)
        view.addSubview(argumentPushButton)
        
        let noArgumentPresentButton = UIButton(frame: CGRect(x:  0, y: 176, width: view.bounds.width, height: 44))
        noArgumentPresentButton.setTitle("无参数present", for: .normal)
        noArgumentPresentButton.backgroundColor = UIColor.lightGray
        noArgumentPresentButton.addTarget(self, action: #selector(noArgumentPresent), for: .touchUpInside)
        view.addSubview(noArgumentPresentButton)
        
        let argumentPresentButton = UIButton(frame: CGRect(x:  0, y: 220, width: view.bounds.width, height: 44))
        argumentPresentButton.setTitle("传值present", for: .normal)
        argumentPresentButton.backgroundColor = UIColor.lightGray
        argumentPresentButton.addTarget(self, action: #selector(argumentPresent), for: .touchUpInside)
        view.addSubview(argumentPresentButton)
    }
}

extension ViewController {
    @objc
    func noArgumentPush() {
        let url = URL(string: "JLRoutesInSwift://MouduleA/NextViewController/\(Modal.push.rawValue)")!
        Route.open(noArguments: url) { (result) in
            if let info = result as? String {
                print("这是回调回来的数据\(info)")
            }
        }
    }
    
    @objc
    func argumentPush() {
        let arguments = "这里push传递的是一个字符串"
        /// 一定要addingPercentEncoding JLRoutes不能传递中文汉字
        let urlString = "JLRoutesInSwift://MouduleA/NextViewController/\(Modal.push.rawValue)/\(arguments)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let url = URL(string: urlString)!
        Route.open(withArguments: url) { (result) in
            if let info = result as? String {
                print("这是回调回来的数据\(info)")
            }
        }
    }
    
    @objc
    func noArgumentPresent() {
        let url = URL(string: "JLRoutesInSwift://MouduleA/NextViewController/\(Modal.present.rawValue)")!
        Route.open(noArguments: url) { (result) in
            if let info = result as? String {
                print("这是回调回来的数据\(info)")
            }
        }
    }
    
    @objc
    func argumentPresent() {
        let arguments = "这里present传递的是一个字符串"
        let urlString = "JLRoutesInSwift://MouduleA/NextViewController/\(Modal.present.rawValue)/\(arguments)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let url = URL(string: urlString)!
        Route.open(withArguments: url) { (result) in
            if let info = result as? String {
                print("这是回调回来的数据\(info)")
            }
        }
    }
}

