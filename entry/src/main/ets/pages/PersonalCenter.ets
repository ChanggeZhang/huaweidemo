
import Menu from '../model/data/Menu'
import SettingItem from '../components/SettingItem'
@Entry
@Component
struct PersonalCenter{

  private menus:Array<Menu> = [
    new Menu($r('app.media.qq'),"企鹅登录",false),
    new Menu($r('app.media.wechat'),"微信登录",false),
    new Menu($r('app.media.mail'),"腾讯登录",true),
    new Menu($r('app.media.icon'),"随便登录",false),
  ]

  @Builder singleSetting(e:Menu){
    SettingItem({menu: e})
  }

  build(){
    Column({space: 5}){
      Row(){
        Image($r('app.media.avatar')).width(60).height(60).borderRadius("50%").margin({right: 10})
        Column(){
          Text("Changge Zhang").fontWeight(FontWeight.Bold).fontSize(26)
          Text("18296200068@163.com").fontColor(0xababab).margin({top: 5})
        }
      }.justifyContent(FlexAlign.Center).alignItems(VerticalAlign.Center).margin({top: 20,left: "5%"})
      List(){
        ForEach(this.menus,(e:Menu) => {
          ListItem(){
            this.singleSetting(e)
          }.height(48)
        },(e:Menu) => e.getTitle)
      }.divider({
        strokeWidth: "3px",
        color: "rgba(0,0,0,0.2)",
        startMargin: 25,
        endMargin: 25
      }).margin({top: 20,left: "5%"})
    }.width('90%').justifyContent(FlexAlign.Center)
  }
}