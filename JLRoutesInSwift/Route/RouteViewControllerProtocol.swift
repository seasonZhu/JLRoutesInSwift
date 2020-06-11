//
//  RouteViewControllerProtocol.swift
//  JLRoutesInSwift
//
//  Created by season on 2020/6/10.
//  Copyright © 2020 lostsakura. All rights reserved.
//

import UIKit

/// 控制器关闭后回调数据
public typealias BackResult = (Any) -> Void

/// 支持路由的控制器所需要遵守的协议,该协议仅对UIViewController以及其子类有效
protocol RouteViewControllerProtocol {
    
    /// 传入参数
    var arguments: Any? {set get}
    
    /// 控制打开方式 push or present
    var modalType: Modal! {set get}
    
    /// 控制器关闭的回调数据
    var result: BackResult? {set get}
}
