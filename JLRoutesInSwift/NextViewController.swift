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
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        if let some = arguments as? String {
            title = some
        }else if arguments == nil {
            title = modalType.rawValue
        }
    }

}
