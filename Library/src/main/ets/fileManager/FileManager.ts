import MediaLibraryManager from "./media/FileMediaManager"

/**
 * 文件管理接口，统一封装了各模块对外提供的功能接口
 */
class FileManager {

  /**
   * 申请文件管理权限
   * @param context 上下文对象
   */
  requestPermission(context): void {
    MediaLibraryManager.requestPermission(context)
  }
}

export default new FileManager()