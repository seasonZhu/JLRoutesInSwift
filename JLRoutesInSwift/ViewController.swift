//
//  ViewController.swift
//  JLRoutesInSwift
//
//  Created by season on 2020/6/10.
//  Copyright © 2020 lostsakura. All rights reserved.
//

import UIKit

import Aspects
import EasySwiftHook

class ViewController: UIViewController {
    
    private var token: EasySwiftHook.Token?
    
    var someView: UIView?
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        token?.cancelHook()
        token = nil
    }

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
        
        /// swift中已经不能使用Aspects
        
//        let _ = try? UIApplication.shared.aspect_hook(#selector(UIApplication.shared.sendEvent(_:)), with: .positionBefore) { (aspectInfo: AspectInfo, event: UIEvent) -> Void in
//            print(event)
//        }
        
//        let _ = try? UIViewController.aspect_hook(#selector(viewWillAppear(_:)), with: .positionBefore) { (aspectInfo: AspectInfo, animate: Bool) -> Void in
//            print(aspectInfo.instance())
//        }
        
//        do {
//            let token = try argumentPresentButton.aspect_hook(#selector(UIButton.setTitle(_:for:)), with: .positionBefore) { (aspectInfo: AspectInfo, title: String?, state: UIControl.State) -> Void in
//                print(aspectInfo.instance())
//            }
//        } catch {
//            print(error)
//        }
        
        do {
            let hookClosure = { object, selector, event in
                    print("Nice to see you \(event)")
                    print("The object is: \(object)")
                    print("The selector is: \(selector)")
                
                if let touch = event.allTouches?.first,
                   let view = touch.view {
                    
                    print("Event view:\(view)")
                    
                } else {
                    object.sendEvent(event)
                }
                
                } as @convention(block) (UIApplication, Selector, UIEvent) -> Void
            
            token = try hookBefore(targetClass: UIApplication.self, selector: #selector(UIApplication.sendEvent(_:)), closure: hookClosure)
        } catch {
            print(error)
        }
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

