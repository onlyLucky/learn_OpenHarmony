import prompt from '@ohos.promptAction';
import router from '@ohos.router';
import { FileManager } from "@ohos/feature-file-manager"
import environment from '@ohos.file.environment';
import { BusinessError } from '@ohos.base';
import fs from '@ohos.file.fs';

class MainListItemModel {
  image: Resource | null = null
  title: Resource | null = null
  routerUrl: string = ''
  isReady?: boolean = true
  isFileWatcher?: boolean = false
}

const ONE_SECOND: number = 1000

const MAIN_LIST_ITEMS: MainListItemModel[] = [
  {
    image: $r('app.media.image'),
    title: $r('app.string.image'),
    routerUrl: 'pages/Image/ImageFileList'
  },
  {
    image: $r('app.media.video'),
    title: $r('app.string.video'),
    routerUrl: 'filemanager/pages/video/VideoFileList' },
  {
    image: $r('app.media.document'),
    title: $r('app.string.document'),
    routerUrl: 'filemanager/pages/document/DocumentFileList'
  },
  {
    image: $r('app.media.music'),
    title: $r('app.string.audio'),
    routerUrl: 'filemanager/pages/audio/AudioFileList'
  },
  {
    image: $r('app.media.compressed_package'),
    title: $r('app.string.compressed_package'),
    routerUrl: '',
    isReady: false
  },
  {
    image: $r('app.media.my_phone'),
    title: $r('app.string.my_phone'),
    routerUrl: 'filemanager/pages/MyPhone/MyPhone'
  },
  {
    image: $r('app.media.watcher'),
    title: $r('app.string.watcherFileText'),
    routerUrl: 'pages/WatcherFile',
    isFileWatcher: true
  }
]

@Component
struct MainListItemComponent{
  private mainListItem: MainListItemModel = new MainListItemModel();
  private filePathDir: string = '';

  @Styles itemPressedStyles() {
    .backgroundColor($r('app.color.item_pressed'))
  }

  async handleFileFunc(){
    try {
      let path: string = await environment.getStorageDataDir()
      let filePath = `${path}/example.txt`;
      let file = fs.openSync(filePath, fs.OpenMode.CREATE | fs.OpenMode.READ_WRITE | fs.OpenMode.TRUNC);
      fs.writeSync(file.fd, 'hello world \n');
      fs.closeSync(file);
      console.info("getStorageDataDir successfully, Path: " + path);
    } catch (err) {
      console.info("getStorageDataDir failed with error message: " + err.message + ", error code: " + err.code);
    }
  }

  build(){
    Row(){
      Image(this.mainListItem.image)
        .width(24)
        .height(24)
        .margin({ left: 20 })
        .objectFit(ImageFit.Fill)
      Text(this.mainListItem.title)
        .fontSize(16)
        .margin({ left: 16 })
        .fontColor($r('app.color.black'))
      Blank()
      Image($r('app.media.right_arrow'))
        .width(12)
        .height(24)
        .margin({ right: 20 })
    }
    .height(56)
    .width('100%')
    .borderRadius(24)
    .backgroundColor($r('app.color.white'))
    .margin({ top: 10 })
    .stateStyles({
      pressed: this.itemPressedStyles
    })
    .onClick(() => {
      this.handleFileFunc()
    })
  }
}

@Component
export default struct FilesHomeComps{

  aboutToAppear() {
    console.info("aboutToAppear:===")
    FileManager.requestPermission(getContext(this))
  }

  build(){
    Row() {
      Column() {
        Text($r('app.string.file_manager'))
          .fontSize(24)
          .margin({ left: 20, top: 10, bottom: 20 })
          .fontWeight(FontWeight.Bold)
          .fontColor($r('app.color.black'))
          .alignSelf(ItemAlign.Start)
        List() {
          ForEach(MAIN_LIST_ITEMS,(listItem: MainListItemModel, index: number)=>{
            ListItem(){
              MainListItemComponent({mainListItem: listItem})
            }.id('ListItem' + index)
          })
        }.width('100%')
      }


    }
  }
}