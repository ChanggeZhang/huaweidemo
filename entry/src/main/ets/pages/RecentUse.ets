import GridMenu from '../components/GridMenu'
import Menu from '../model/data/Menu'

@Entry
@Component
struct RecentUse{

  private menus:Array<Menu> = [
    new Menu($r('app.media.qq'),"企鹅登录",false),
    new Menu($r('app.media.wechat'),"微信登录",false),
    new Menu($r('app.media.mail'),"腾讯登录",true),
    new Menu($r('app.media.icon'),"web",false,"pages/WebPage"),
    new Menu($r('app.media.qq'),"系统设置",false,"pages/Setting"),
    new Menu($r('app.media.wechat'),"微信登录2",false),
    new Menu($r('app.media.mail'),"腾讯登录2",true),
    new Menu($r('app.media.icon'),"随便登录2",false),
    new Menu($r('app.media.qq'),"企鹅登录3",false),
    new Menu($r('app.media.wechat'),"微信登录3",false),
    new Menu($r('app.media.mail'),"腾讯登录3",true),
  ]

  @Builder buildGridItem(e:Menu){
    GridMenu({menu: e})
  }

  build(){
    Grid(){
      ForEach(this.menus,(e:Menu) => {
        GridItem(){
          this.buildGridItem(e)
        }
      },(e:Menu) => e.getTitle)
    }
    .columnsTemplate("1fr 1fr 1fr 1fr")
    .columnsGap(8)
    .rowsGap(12)
    .height(2 * 88)
  }
}