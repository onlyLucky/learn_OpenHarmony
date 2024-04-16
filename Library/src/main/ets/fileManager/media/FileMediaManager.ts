import image from '@ohos.multimedia.image'
import mediaLibrary from '@ohos.multimedia.mediaLibrary' // 媒体库管理 即将废除
import Logger from '../../utils/Logger'
import abilityAccessCtrl from '@ohos.abilityAccessCtrl'; // 程序访问控制管理
import type { Permissions } from '@ohos.abilityAccessCtrl';


/**
 * 主要封装了mediaLibrary库相关的接口
 */

class MediaLibraryManager {
  requestPermission(context): void {
    let permissions: Array<Permissions> = [
      'ohos.permission.READ_MEDIA',
      'ohos.permission.WRITE_MEDIA'
    ]
    Logger.info(`requestPermission:=======`)
    let atManager: abilityAccessCtrl.AtManager = abilityAccessCtrl.createAtManager();
    atManager.requestPermissionsFromUser(context, permissions, (code, result) => {
      Logger.info(`requestPermission:=======${code} - ${result}`)
      Logger.debug('permissionRequest ' + JSON.stringify(code) + ' Result: ' + JSON.stringify(result))
    })
  }
}

export default new MediaLibraryManager()