
/* 02. 企业设备管理概述（仅对系统应用开放） 使用*/
import adminManager from '@ohos.enterprise.adminManager'
import Want from '@ohos.app.ability.Want'
import networkManager from '@ohos.enterprise.networkManager'

const admin: Want = {
  bundleName: 'com.example.hw20240410',
  abilityName: 'EnterpriseAdminAbility'
}
const enterpriseInfo: adminManager.EnterpriseInfo = { name: 'enterprise', description: 'description' }
const activeAdminType: number = 1

interface AdminError {
  code: string;
  message: string;
}

@Component
export default  struct AdminComps {
  @State enableAdminMsg: string = ""
  @State disableAdminMsg: string = ""
  @State subscribeManagedEventMsg: string = ""
  @State unsubscribeManagedEventMsg: string = ""

  build() {
    Row() {
      Column() {
        Text($r("app.string.extension_header"))
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .margin(40)
        Button() {
          Text($r("app.string.enable_admin"))
            .fontSize(20)
            .fontColor(Color.Blue)
        }
        .key('enableAdmin')
        .type(ButtonType.Capsule)
        .height(60)
        .width(320)
        .margin({
          left: 10,
          right: 10,
          bottom: 5
        })
        .enabled(true)
        .backgroundColor('#0D9FFB')
        .onClick(() => {
          this.enableAdmin()
        })

        Text(this.enableAdminMsg)
          .id('enableAdminMsg')

        Blank().height(20)

        Button() {
          Text($r("app.string.disable_admin"))
            .fontSize(20)
            .fontColor(Color.Blue)
        }
        .id('disableAdmin')
        .type(ButtonType.Capsule)
        .height(60)
        .width(320)
        .margin({
          left: 10,
          right: 10,
          bottom: 5
        })
        .enabled(true)
        .backgroundColor('#0D9FFB')
        .onClick(() => {
          this.disableSuperAdmin()
        })

        Text(this.disableAdminMsg)
          .id('disableAdminMsg')

        Blank().height(20)

        Blank().height(20)

        Button() {
          Text($r("app.string.subscribe_app_install_uninstall_event"))
            .fontSize(20)
            .fontColor(Color.Blue)
        }
        .id('subscribeManagedEvent')
        .type(ButtonType.Capsule)
        .height(60)
        .width(320)
        .margin({
          left: 10,
          right: 10,
          bottom: 5
        })
        .enabled(true)
        .backgroundColor('#0D9FFB')
        .onClick(() => {
          this.subscribeManagedEventCallback()
        })

        Text(this.subscribeManagedEventMsg)
          .id('subscribeManagedEventMsg')

        Blank().height(20)

        Button() {
          Text($r("app.string.unsubscribe_app_install_uninstall_event"))
            .fontSize(20)
            .fontColor(Color.Blue)
        }
        .id('unsubscribeManagedEvent')
        .type(ButtonType.Capsule)
        .height(60)
        .width(320)
        .margin({
          left: 10,
          right: 10,
          bottom: 5
        })
        .enabled(true)
        .backgroundColor('#0D9FFB')
        .onClick(() => {
          this.unsubscribeManagedEventPromise()
        })

        Text(this.unsubscribeManagedEventMsg)
          .id('unsubscribeManagedEventMsg')
      }
      .width('100%')
    }
    .height('100%')
  }

  async enableAdmin() {
    await adminManager.enableAdmin(admin, enterpriseInfo, activeAdminType).then(() => {
      this.enableAdminMsg = 'enableAdmin success'
    //   获取mac地址
      networkManager.getMac(admin, 'eth0', (err, result) => {
        if (err) {
          console.error(`Failed to get mac. Code: ${err.code}, message: ${err.message}`);
          return;
        }
        console.info(`Succeeded in getting mac, result : ${result}  ${enterpriseInfo.name}-${enterpriseInfo.description} ${admin.abilityName}-${admin.bundleName}`);
      });
    }).catch((error: AdminError ) => {
      console.error(`Failed to enableAdmin. Code: ${error.code}, message: ${error.message}`);
      this.enableAdminMsg = 'enableAdmin fail'
    })
  }

  async disableSuperAdmin() {
    await adminManager.disableSuperAdmin(admin.bundleName, (error) => {
      console.error(`Failed to disableSuperAdmin. Code: ${error.code}, message: ${error.message}`);
      if (error) {
        this.disableAdminMsg = 'disableSuperAdmin fail'
      } else {
        this.disableAdminMsg = 'disableSuperAdmin success'
      }
    })
  }

  async subscribeManagedEventCallback() {
    await adminManager.subscribeManagedEvent(admin,
      [adminManager.ManagedEvent.MANAGED_EVENT_BUNDLE_ADDED,
        adminManager.ManagedEvent.MANAGED_EVENT_BUNDLE_REMOVED], (error) => {
        if (error) {
          this.subscribeManagedEventMsg = 'subscribeManagedEvent fail'
        } else {
          this.subscribeManagedEventMsg = 'subscribeManagedEvent success'
        }
      })
  }

  async unsubscribeManagedEventPromise() {
    await adminManager.unsubscribeManagedEvent(admin,
      [adminManager.ManagedEvent.MANAGED_EVENT_BUNDLE_ADDED,
        adminManager.ManagedEvent.MANAGED_EVENT_BUNDLE_REMOVED]).then(() => {
      this.unsubscribeManagedEventMsg = 'unsubscribeManagedEvent success'
    }).catch((error: AdminError) => {
      this.unsubscribeManagedEventMsg = 'unsubscribeManagedEvent fail'
    })
  }
}