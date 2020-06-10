//
//  RouteViewControllerProtocol.swift
//  JLRoutesInSwift
//
//  Created by season on 2020/6/10.
//  Copyright © 2020 lostsakura. All rights reserved.
//

import Foundation

/// 支持路由的控制器所需要遵守的协议,该协议仅对UIViewController以及其子类有效
protocol RouteViewControllerProtocol {
    var arguments: Any? {set get}
    var modalType: Modal! {set get}
}
