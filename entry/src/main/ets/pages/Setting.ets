import router from '@ohos.router'
import preferences from '@ohos.data.preferences'
import PreferenceUtil, { Const } from '../utils/PreffrencesUtils'
@Entry
@Component
struct Setting {

  @State fontSize:number = 14;

  onPageShow(){
    PreferenceUtil.get(Const.KEY).then((val:number) => {
      this.fontSize = val;
    })
  }

  build() {
    Column(){
      Row(){
        Text("👈").fontSize(this.fontSize).onClick(e => {
          router.back()
        })
        Text("设置字体大小").fontSize(this.fontSize).margin({left: 15})
      }.margin({top:20,bottom: 20,left:5,right:5}).width("90%").justifyContent(FlexAlign.Start).alignItems(VerticalAlign.Center)
      Column({space: 20}){
        Row(){
          Text("你好啊，吃饭了没有啊？要打六点了哦").fontSize(this.fontSize).padding(12).backgroundColor(0x11FF88).fontColor(0X000000).borderRadius(10).width("90%")
          Image($r("app.media.personal_center")).width(26).height(26)
        }.justifyContent(FlexAlign.End).alignItems(VerticalAlign.Center).width("90%")
        Row(){
          Image($r("app.media.personal_center")).width(26).height(26)
          Text("吃了哦，你吃了没有啊？").fontSize(this.fontSize).padding(12).backgroundColor(0xffffff).borderRadius(10).width("90%")
        }.justifyContent(FlexAlign.Start).alignItems(VerticalAlign.Center).width("90%")
        Row(){
          Text("还没有哦，才从坡上回来耶").fontSize(this.fontSize).padding(12).backgroundColor(0x11FF88).fontColor(0X000000).borderRadius(10).width("90%")
          Image($r("app.media.personal_center")).width(26).height(26)
        }.justifyContent(FlexAlign.End).alignItems(VerticalAlign.Center).width("90%")
        Row(){
          Image($r("app.media.personal_center")).width(26).height(26)
          Text("吃得了哦，马上要六点了，不是多暗糟了？").fontSize(this.fontSize).padding(12).backgroundColor(0xffffff).borderRadius(10).width("90%")
        }.justifyContent(FlexAlign.Start).alignItems(VerticalAlign.Center).width("90%")
        Row(){
          Text("煮起的，马上就好了。都六点了你还走哪哈儿去哦？黑都要黑了哒嘛").fontSize(this.fontSize).padding(12).backgroundColor(0x11FF88).fontColor(0X000000).borderRadius(10).width("90%")
          Image($r("app.media.personal_center")).width(26).height(26)
        }.justifyContent(FlexAlign.End).alignItems(VerticalAlign.Center).width("90%")
        Row(){
          Image($r("app.media.personal_center")).width(26).height(26)
          Text("切了饭出去转哈路耍，黑还有一哈。").fontSize(this.fontSize).padding(12).backgroundColor(0xffffff).borderRadius(10).width("90%")
        }.justifyContent(FlexAlign.Start).alignItems(VerticalAlign.Center).width("90%")
        Row(){
          Text("那也是，你一个人弃哪哈儿转喏").fontSize(this.fontSize).padding(12).backgroundColor(0x11FF88).fontColor(0X000000).borderRadius(10).width("90%")
          Image($r("app.media.personal_center")).width(26).height(26)
        }.justifyContent(FlexAlign.End).alignItems(VerticalAlign.Center).width("90%")
        Row(){
          Image($r("app.media.personal_center")).width(26).height(26)
          Text("随便周围转哈就是").fontSize(this.fontSize).padding(12).backgroundColor(0xffffff).borderRadius(10).width("90%")
        }.justifyContent(FlexAlign.Start).alignItems(VerticalAlign.Center).width("90%")
      }.margin({left:5,right:5,bottom: 20})
      Text("字体大小").width("90%").fontSize(this.fontSize)
      Column(){
        Text(this.fontSize < 8 ? "特小" : (this.fontSize < 10 ? "小": (this.fontSize < 14 ? "适中" : (this.fontSize < 16 ? "大" : "特大")))).width("100%").textAlign(TextAlign.Center).fontSize(this.fontSize)
        Slider({
          min: 6,
          max: 20,
          step: 1,
          style: SliderStyle.OutSet,
          value: this.fontSize
        }).onChange((val:number,mode:SliderChangeMode) => {
          this.fontSize = val;
          this.persistFontSize()
        })
      }.width("90%").margin({left:5,right:5})
    }.backgroundColor(0xededed).width("100%").height("100%")
  }

  persistFontSize(){
    PreferenceUtil.update(Const.KEY,this.fontSize)
  }
}