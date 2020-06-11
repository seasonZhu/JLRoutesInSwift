//
//  NextViewController.swift
//  JLRoutesInSwift
//
//  Created by season on 2020/6/10.
//  Copyright © 2020 lostsakura. All rights reserved.
//

import UIKit

class NextViewController: UIViewController, RouteViewControllerProtocol {
    var arguments: Any?
    
    var modalType: Modal!
    
    var result: BackResult?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        if let some = arguments as? String {
            title = some
        }else if arguments == nil {
            title = modalType.rawValue
        }
        
        let backButton = UIButton(frame: CGRect(x:  0, y:88, width: view.bounds.width, height: 44))
        backButton.setTitle("back", for: .normal)
        backButton.backgroundColor = UIColor.lightGray
        backButton.addTarget(self, action: #selector(backAction), for: .touchUpInside)
        view.addSubview(backButton)
    }
    
    @objc
    func backAction() {
        
        if navigationController?.viewControllers.count ?? 0 > 1 {
            let backVC = navigationController?.popViewController(animated: true)
            print(type(of: backVC))
        }else {
            dismiss(animated: true)
        }
        result?("\(arguments == nil ? "no arguments": "with arguments")\n\("modal: " + modalType.rawValue)\ngo back Success")
    }

}
