// 01.基础使用

interface  paramType {
  paramA1: string
}

// 按引用传递参数
@Builder function overBuilder($$: paramType) {
  Row() {
    Text(`UseStateVarByReference: ${$$.paramA1} `)
  }
}

// 按值传递参数
@Builder function overValueBuilder(paramA1: string) {
  Row() {
    Text(`UseStateVarByValue: ${paramA1} `)
  }
}

@Styles function globalFancy(){
  .width(150)
  .height(100)
  .backgroundColor(Color.Pink)
}

@Component
struct HelloComponent{
  @State message: string = 'Hello, World!';
  @State label: string = 'child';
  @BuilderParam customBuilderChildParam: () => void;
  // 组件生命周期
  aboutToAppear() {
    console.info('HelloComponent aboutToAppear');
  }

  // 组件生命周期
  aboutToDisappear() {
    console.info('HelloComponent aboutToDisappear');
  }
  build() {
    // HelloComponent自定义组件组合系统组件Row和Text
    Row() {
      Text(this.message)
        .onClick(() => {
          // 状态变量message的改变驱动UI刷新，UI从'Hello, World!'刷新为'Hello, ArkUI!'
          this.message = 'Hello, ArkUI!';
        })
      this.customBuilderChildParam()

    }
  }
}

@Component
export default struct BaseComps {
  @State count: number = 12
  @State label: string = 'Hello';
  myClickHandler(): void {
    this.count += 1;
  }
  calcTextValue(): string {
    return 'Hello calcTextValue';
  }

  @Builder doSomeRender() {
    Text(`Hello doSomeRender${this.label}`)
  }
  // 使用自定义组件的自定义构建函数初始化@BuilderParam
  @BuilderParam customBuilderParam: () => void = this.doSomeRender;
  // 使用全局自定义构建函数初始化@BuilderParam
  @BuilderParam customOverBuilderParam: ($$: paramType) => void = overBuilder;
  build(){
    Column() {
      Text('item 1')
      Divider()
      Text('item 2')
      // Image('https://gd-hbimg.huaban.com/d1a519155876d4cb9d4260e5395610e81a3cac5e39865-6JJB8W_fw1200').width(50)
      // string类型的参数
      Text('test')
      // $r形式引入应用资源，可应用于多语言场景
      Text($r('app.string.module_desc'))
      // 无参数形式
      Text()
      Text(`count: ${this.count}`).fontSize(12)
      Row() {
        Button('Click me')
          .onClick(() => {
            this.count +=1;
          })
        Button('add counter')
          .onClick(()=>{
            this.count += 1;
          })
        Button('add counter')
          .onClick(this.myClickHandler)
      }
      // HelloComponent({ message: 'Hello, World!' })
      Divider()
      HelloComponent({message:'你好！',customBuilderChildParam: this.doSomeRender}).width('100%').backgroundColor('#eceff7')

      this.doSomeRender();
      Text(this.calcTextValue())
      overBuilder({ paramA1: this.label })
      overValueBuilder(this.label)
      Button('Click me').onClick(() => {
        // 点击“Click me”后，UI从“Hello”刷新为“ArkUI”
        this.label = 'ArkUI';
      })
    }
  }
}