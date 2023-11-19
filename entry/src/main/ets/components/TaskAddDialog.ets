
import HashMap from '@ohos.util.HashMap';
@CustomDialog
export default struct TaskAddDialog{

  callback?:(model:HashMap<String,Object>) => void;
  close?:(e:BaseEvent) => void
  private controller?:CustomDialogController
  title:string
  model:HashMap<String,Object> = new HashMap<String,Object>()

  build(){
    Column({space: 10}){
      Row(){
        Text(this.title)
        Text("×").fontColor(0x00abff).onClick((e:ClickEvent) => {
          if(this.close){
            this.close(e);
          }
          this.controller.close()
        })
      }.width("95%").justifyContent(FlexAlign.SpaceBetween)
      List(){
        ListItem(){
          TextInput({placeholder: "请输入子项目名称"})
            .type(InputType.Normal)
            .id("subProjectName")
            .onChange((val:string) => {
              this.model.set("subProjectName",val)
            })
            .caretColor(0x00abff)
        }
      }
      Row(){
        Text("提交").fontColor(0x00abff).onClick(e => {
          this.callback(this.model)
        })
      }.width("95%").justifyContent(FlexAlign.Center).alignItems(VerticalAlign.Center)
    }.width("90%").backgroundColor(0xffffff).justifyContent(FlexAlign.Center).padding(10).borderRadius(10)
  }
}