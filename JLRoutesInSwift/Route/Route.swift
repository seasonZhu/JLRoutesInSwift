//
//  Route.swift
//  JLRoutesInSwift
//
//  Created by season on 2020/6/10.
//  Copyright © 2020 lostsakura. All rights reserved.
//

import Foundation
import JLRoutes

/// 无参数url的格式
private let routePatternNoArguments = "/:module/:target/:modal"

/// 有参数的url格式
private let routePatternWithArguments = "/:module/:target/:modal/:arguments"

/// 命名空间
private let nameSpace = Bundle.main.infoDictionary?["CFBundleExecutable"] as! String

/// 路由
public final class Route {
    
    /// 打开无参路由
    /// - Parameter url: 路由网址
    public static func open(noArguments url: URL) {
        Route.shared.open(url: url, hasParameters: false)
    }
    
    /// 打开有参路由
    /// - Parameter url: 路由网址
    public static func open(withArguments url: URL) {
        Route.shared.open(url: url, hasParameters: true)
    }
    
    private init() {}
    
}

extension Route {
    
    /// 私有单例
    private static let shared = Route()
    
    /// 注册模块
    /// - Parameter hasParameters: 是否有参数
    private func registerModule(hasParameters: Bool) {
        let routePattern = hasParameters ? routePatternWithArguments : routePatternNoArguments
        JLRoutes.global().addRoute(routePattern) { return self.goTargetVC(parameters: $0) }
    }
    
    /// 打开URL
    /// - Parameters:
    ///   - url: url
    ///   - hasParameters: 是否有参数
    private func open(url: URL, hasParameters: Bool) {
        registerModule(hasParameters: hasParameters)
        JLRoutes.global().routeURL(url)
    }
    
    /// 去目标控制器
    /// - Parameter parameters: 参数
    /// - Returns: Bool
    private func goTargetVC(parameters: [String: Any]? = nil) -> Bool {
        if let target = parameters?["target"] as? String, // 获取目标控制器的字符串名称
            let modal = parameters?["modal"] as? String, // 获取打开方式 present or push
            let targetVC = creatInstance(by: target) as? UIViewController, // 生成控制器
            var routeVC = targetVC as? RouteViewControllerProtocol // 判断控制器是否遵守协议
        {
            
                routeVC.arguments = parameters?["arguments"]
                routeVC.modalType = Modal(rawValue: modal)
                
                let currentVC = topViewController()
                switch routeVC.modalType {
                case .push:
                    currentVC?.navigationController?.pushViewController(targetVC, animated: true)
                case .present:
                    let navi = UINavigationController(rootViewController: targetVC)
                    currentVC?.present(navi, animated: true)
                case .none:
                    break
                    
            }
            return true
        }
        
        return false
    }
}

extension Route {
    
    /// 通过字符串生成对应的控制器类,将泛型约束变窄,更有利于理解与安全
    /// - Parameter className: 类名字符串
    /// - Returns: 类
    private func creatInstance<T: UIViewController>(by className: String) -> T? {
        guard let `class` = NSClassFromString(nameSpace + "." + className), let typeClass = `class` as? T.Type else {
            return nil
        }
        return typeClass.init()
    }
    
    /// 获取顶层控制器
    /// - Parameter rootVC: 根控制器
    /// - Returns: 顶层控制器
    private func topViewController(_ rootVC: UIViewController? = UIApplication.shared.windows.first?.rootViewController) -> UIViewController? {
        if let nav = rootVC as? UINavigationController {
            return topViewController(nav.visibleViewController)
        }
        
        if let tab = rootVC as? UITabBarController {
            if let selected = tab.selectedViewController {
                return topViewController(selected)
            }
        }
        
        if let presented = rootVC?.presentedViewController {
            return topViewController(presented)
        }
        
        return rootVC
    }
}
