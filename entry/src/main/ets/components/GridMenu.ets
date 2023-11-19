import router from '@ohos.router';
import Menu from '../model/data/Menu'

@Component
export default struct GridMenu{
  @State menu:Menu = null;

  build(){
    Column(){
      Image(this.menu.getIcon)
        .width(60)
        .height(60)
      Text(this.menu.getTitle)
    }.onClick(e => {
      if(this.menu.getPage){
        router.pushUrl({
          url: this.menu.getPage,
          params: this.menu.getParams
        })
      }
    })
  }
}