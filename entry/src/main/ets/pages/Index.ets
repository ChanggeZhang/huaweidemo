import router from '@ohos.router'
import VideoPlayer from '../components/VideoPlayer';
import MainMenu from '../model/data/MainMenu'
import VideoInfo from '../model/data/VideoInfo';
@Entry
@Component
struct Index {

  @State cur:number = 0;
  private tabsController:TabsController = new TabsController();
  @Provide video:VideoInfo = new VideoInfo("https://v2.cri.cn/M00/01/09/rBABDWGCT6-AVJaOGX6mwyAWvGk744.mp4","https://p2.cri.cn/M00/3E/4D/rBABCWGCT6-AeuEhAAAAAAAAAAA60.856x480.jpeg")
  @Provide autoPlay:boolean = false

  private menu:Array<MainMenu> = [
    new MainMenu("首页",$r('app.media.home'),$r("app.media.home_select"),"pages/Index"),
    new MainMenu("代办列表",$r("app.media.todo_list"),$r("app.media.todo_list_select"),"pages/Changge",{greeting:"Hello"}),
    new MainMenu("最常使用",$r("app.media.recent_use"),$r("app.media.recent_use_select"),"pages/RecentUse"),
    new MainMenu("个人中心",$r("app.media.personal_center"),$r("app.media.personal_center_select"),"pages/PersonalCenter"),
    new MainMenu("任务列表",$r("app.media.todo_list"),$r("app.media.todo_list_select"),"pages/TaskList"),
  ]

  @Builder buildMainMenu(menu:MainMenu,index:number){
    Column(){
      Image(this.cur === index ? menu.getSelectIcon : menu.getIcon).width(30).height(30)
      Text(menu.getTitle).fontColor(this.cur === index ? 0x00abff : 0x000000)
    }
    .width("100%")
    .height("100%")
    .justifyContent(FlexAlign.Center)
    .onClick(e => {
      this.cur = index;
      this.tabsController.changeIndex(this.cur)
      router.pushUrl({
        url: menu.getLink,
        params: menu.getParam
      })
    })
  }

  build() {
    Column(){
      VideoPlayer({
        autoPlay: $autoPlay
      })
      Tabs({
        barPosition:BarPosition.End,
        controller: this.tabsController
      }){
        ForEach(this.menu,(e:MainMenu,index:number) => {
          TabContent().tabBar(this.buildMainMenu(e,index))
        },(e:MainMenu) => e.getTitle)
      }.vertical(false)
      .barWidth("100%")
      .barHeight(80)
      .height(80)
      .barMode(BarMode.Fixed)
      .onChange((index:number) => {
        this.cur = index;
      })
    }
    .width("100%")
    .height("100%")
  }
}