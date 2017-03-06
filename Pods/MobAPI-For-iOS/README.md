###一、获取AppKey


#### 手动导入


![image](images/图二.jpg)




注意：请务必在上述步骤中选择“Create groups for any added folders”单选按钮组。如果你选择“Create folder references for any added folders”，一个蓝色的文件夹引用将被添加到项目并且将无法找到它的资源。


第二步：添加依赖库 添加步骤见下图 	

必须添加的依赖库如下(Xcode 7 下 *.dylib库后缀名更改为*.tbd)：





只需要在 Podfile 里面加入这两句命令，pod install 即可：
	pod 'MobAPI-For-iOS'
	pod 'MOBFoundation'




在- (BOOL)application: didFinishLaunchingWithOptions:方法中调用registerApp方法来初始化SDK

	- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
	{
	    //替换您自己在Mob官网注册的App Key.注册地址[注册您要使用的sdk的app key]：http://dashboard.mob.com/#/
	    [MobAPI registerApp:@"14e2650055847"];
	    
	    return YES;
	}


------------ | ------------- 
MOBABankCardRequest | 银行卡信息查询 
MOBABoxOfficeRequest | 电影票房相关请求 