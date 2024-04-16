import { BusinessError } from '@ohos.base';
import fs from '@ohos.file.fs';
import { bufferToString, expect, Logger, sleep } from '../../../common/Common';

const CONTENT = 'hello world';
const TAG: string = '[FileIO].[Watcher]';
const TIMEOUT: number = 500; // 超时时间
const IN_ACCESS: number = 0x00000001;
const IN_MODIFY: number = 0x00000002;
const IN_ATTRIB: number = 0x00000004;
const IN_CLOSE_WRITE: number = 0x00000008;
const IN_CLOSE_NOWRITE: number = 0x00000010;
const IN_OPEN: number = 0x00000020;
const IN_MOVED_FROM: number = 0x00000040;
const IN_MOVED_TO: number = 0x00000080;
const IN_CREATE: number = 0x00000100;
const IN_DELETE: number = 0x00000200;
const IN_DELETE_SELF: number = 0x00000400;
const IN_MOVE_SELF: number = 0x00000800;
const IN_ISDIR: number = 0x40000000;
const BUFFER: number = 4096; // 读写文件buffer大小
const FILE_NUMBER: number = 9; // 文件1-9命名时加上0

interface FILEINFO {
  path: string[],
  size: number
}

export default class MyWatcher {
  public fileSize: number = 0;
  private baseDir: string = '';
  public watcherList: Array<fs.Watcher> = [];
  private timeOut: number = TIMEOUT;
  public log: string[] = [];
  public fileInfo: FILEINFO= {
    path: [],
    size: 0
  };
  private watcherCodeMap = new Map([
    ['IN_ACCESS', IN_ACCESS],
    ['IN_MODIFY', IN_MODIFY],
    ['IN_ATTRIB', IN_ATTRIB],
    ['IN_CLOSE_WRITE', IN_CLOSE_WRITE],
    ['IN_CLOSE_NOWRITE', IN_CLOSE_NOWRITE],
    ['IN_OPEN', IN_OPEN],
    ['IN_MOVED_FROM', IN_MOVED_FROM],
    ['IN_MOVED_TO', IN_MOVED_TO],
    ['IN_CREATE', IN_CREATE],
    ['IN_DELETE', IN_DELETE],
    ['IN_DELETE_SELF', IN_DELETE_SELF],
    ['IN_MOVE_SELF', IN_MOVE_SELF],
    ['IN_ISDIR', IN_ISDIR]
  ]);
  public content1: string = AppStorage.Get<string>('fileContent1') as string;
  public content2: string = AppStorage.Get<string>('fileContent2') as string;
  public content3: string = AppStorage.Get<string>('fileContent3') as string;
  public content4: string = AppStorage.Get<string>('fileContent4') as string;

  constructor() {
    this.baseDir = AppStorage.Get<string>('sanBoxFileDir') as string;
  }
}