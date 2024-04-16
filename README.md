

- [OpenHarmony Full-SDK下载和替换教程](https://forums.openharmony.cn/forum.php?mod=viewthread&tid=758)
- [AppGallery Connect](https://developer.huawei.com/consumer/cn/service/josp/agc/index.html#/)


### learning

- [01.基础使用语法](./entry/src/main/ets/learning/base.ets)
- [02.开发企业管理应用权限处理](./entry/src/main/ets/learning/base.ets)

**注意前置条件** 

1. Full-SDK 下载安装替换 Stage模型
2. 在应用签名文件中设置应用为系统应用，即app-feature字段为hos_system_app
    - 打开 OpenHarmony SDK 所在目录，可通过工程根路径 local.properties 文件或 DevEco Studio 菜单栏中单击 File > Settings > SDK > OpenHarmony 界面查看 。
    - 在 OpenHarmony SDK 目录下，进入 {Version} > `toolchains` > lib 文件夹，打开 UnsgnedReleasedProfileTemplate.json 文件。
    - 将 apl 配置项配置为 system_core ，app-feature 配置项配置为 ohos_system_app ， Profile 文件的修改参考[HarmonyAppProvision 配置文件的说明](https://docs.openharmony.cn/pages/v4.0/zh-cn/application-dev/security/app-provision-structure.md/)。
    - 重新进行应用签名文件生成 File > Project Structure > signing configs 自动生成应用签名
3. 创建EnterpriseAdminExtensionAbility，[项目文件参考](./entry/src/main/ets/EnterpriseExtAbility/index.ets), [官方文档](https://docs.openharmony.cn/pages/v4.0/zh-cn/application-dev/application-models/enterprise-extensionAbility.md)
4. 根据调用api 添加所需要的权限,[参考配置项](./entry/src/main/module.json5) 中的 `requestPermissions` 配置项
``` txt
   networkManager.getAllNetworkInterfaces
   getAllNetworkInterfaces(admin: Want, callback: AsyncCallback<Array<string>>): void
   指定设备管理应用获取所有激活的网络接口。使用callback异步回调。
   
   需要权限： ohos.permission.ENTERPRISE_GET_NETWORK_INFO
```
5. adminManager.enableAdmin 参数传参说明

|  参数名   |  类型   |  必填   |   说明  |
|-----|-----|-----|-----|
|  admin   |   Want  |  是   |  设备管理应用   |
|  enterpriseInfo   |   EnterpriseInfo  |   是  |  设备管理应用的企业信息   |
|   type  |  AdminType   |  是   |  激活的设备管理应用类型   |
|  callback   |   AsyncCallback<void>  |   是  |   回调函数，当接口调用成功，err为null，否则为错误对象  |

EnterpriseInfo:

名称	类型	必填	说明
name	string	是	表示设备管理应用所属企业的名称。
description	string	是	表示设备管理应用所属企业的描述。

|  参数名   |  类型   |  必填   | 说明                                                                                                                             |
|-----|-----|-----|--------------------------------------------------------------------------------------------------------------------------------|
|  name   |  string   |   是  | 表示设备管理应用所属企业的名称(随便填,最好是[AppGallery Connect](https://developer.huawei.com/consumer/cn/service/josp/agc/index.html#/)上面的唯一值账号名称) |
|  description |   string  |   是  | 表示设备管理应用所属企业的描述（随便填）                                                                                                           |

Want：

|  参数名   |  类型   |  必填   | 说明                                                                                                                                                                                       |
|-----|-----|-----|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|  bundleName   |   string  |   否  | 表示待启动Ability所在的应用Bundle名称(应用包名)                                                                                                                                                          |
|   abilityName  |  string   |   否  | 表示待启动Ability名称。如果在Want中该字段同时指定了BundleName和AbilityName，则Want可以直接匹配到指定的Ability。AbilityName需要在一个应用的范围内保证唯一。（创建EnterpriseAdminExtensionAbility[配置项](./entry/src/main/module.json5)中的的名称name） |

**注意通过开发企业管理应用权限设置之后，才能去获取设备信息，mac信息等......**