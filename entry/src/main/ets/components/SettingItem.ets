import Menu from '../model/data/Menu'

@Component
export default struct SettingItem{
  @State menu:Menu = null;

  build(){
    Row(){
      Row({space: 5}){
        Image(this.menu.getIcon)
          .width(26)
          .width(26)
        Text(this.menu.getTitle)
      }.width("60%")
      if(this.menu.getLastNode){
        Toggle({type: ToggleType.Switch,isOn: this.menu.getOn}).onChange((val) => {
          this.menu.setOn = val
        })
      }else{
        Image(this.menu.getOn ? $r('app.media.open') : $r('app.media.close'))
          .onClick(() => this.menu.setOn = !this.menu.getOn)
          .height(26)
          .width(26)
      }
    }.justifyContent(FlexAlign.SpaceBetween).width("100%")
  }
}