# JLRoutesInSwift
JLRoutes在Swift中的使用

最近因为Flutter中的路由缘故,开始反向学习iOS中的路由了.
但是相比较Flutter中官方支持,并且在顺传值和反向传值的各种便利,iOS的路由都是第三方,而且跟多的场景适用于顺传值,但是对于反向传值,基本上是没有没可能的.

[JLRoutesDemo](https://github.com/destinyzhao/JLRoutesDemo)我通过这个Demo中学习思路,并进行简化与封装,通过协议的方式更好的进行顺传路由的功能.

并且原Demo中在openUrl函数中,会出现再次调用下面的方法:
```
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options
```
回导致递归调用而进入死循环,而这种情况主要是在外部通过浏览器或者是通过其他App打开该App时候产生.

目前大概就是这么多,个人认为iOS中的路由框架,其实最好的使用场景是推送/网页打开/其他App打开.

我更新了在目标路由关闭后,回调数据的方法,并且行之有效,这样的话,路由顺传值与反向传值的功能都满足了,但是由于没有await与async,于是展示出来的就是闭包,理解起来不是特别好.
