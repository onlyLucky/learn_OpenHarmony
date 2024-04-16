import web_webview from '@ohos.web.webview';
import networkManager from '@ohos.enterprise.networkManager';
import Want from '@ohos.app.ability.Want';
import adminManager from '@ohos.enterprise.adminManager';
import AdminComps from '../learning/admin'

@Entry
@Component
struct Index {
  @State message: string = 'Hello World'

  controller: web_webview.WebviewController = new web_webview.WebviewController()

  getNetInfo(){
    let wantTemp: Want = {
      bundleName: 'com.example.hw20240410',
      abilityName: 'EntryAbility',
    };

    // name: 'enterprise', description: 'WuHan'
    let enterpriseInfo: adminManager.EnterpriseInfo = {
      name: 'enterprise',
      description: 'WuHan'
    }
    adminManager.enableAdmin(wantTemp, enterpriseInfo, adminManager.AdminType.ADMIN_TYPE_SUPER, (err) => {
      if (err) {
        console.error(`Failed to enable admin. Code: ${err.code}, message: ${err.message}`);
        return;
      }
      console.info('Succeeded in enabling admin');
    });
    /*networkManager.getMac(wantTemp, 'eth0', (err, result) => {
      if (err) {
        console.error(`Failed to get mac. Code: ${err.code}, message: ${err.message}`);
        return;
      }
      console.info(`Succeeded in getting mac, result : ${result}`);
    });*/
    return '123'
  }

  // 只有被@Entry装饰的组件才可以调用页面的生命周期
  onPageShow() {
    console.info('Index onPageShow');
  }
  // 只有被@Entry装饰的组件才可以调用页面的生命周期
  onPageHide() {
    console.info('Index onPageHide');
  }

  // 只有被@Entry装饰的组件才可以调用页面的生命周期
  onBackPress() {
    console.info('Index onBackPress');
    return true // 返回true表示页面自己处理返回逻辑，不进行页面路由；返回false表示使用默认的路由返回逻辑，不设置返回值按照false处理
  }

  // 组件生命周期
  aboutToAppear() {
    console.info('MyComponent aboutToAppear');
  }

  // 组件生命周期
  aboutToDisappear() {
    console.info('MyComponent aboutToDisappear');
  }


  build() {
    Column() {
      // 组件创建时
      // Web({ src: 'https://www.baidu.com/', controller: this.controller})
      // Web({ src: $rawfile("node/index.html"), controller: this.controller})
      // Web({ src: $rawfile("index.html"), controller: this.controller})
      // BasicComps()
      AdminComps()
    }
  }
}
