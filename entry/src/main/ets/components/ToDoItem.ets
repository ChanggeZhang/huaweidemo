
import ToDoData from '../model/data/ToDoData';
@Component
export default struct ToDoItem{

  @State item: ToDoData = new ToDoData(false,"");

  @Builder labelIcon(url:Resource){
    Image(url)
      .objectFit(ImageFit.Contain)
      .width(26)
      .height(26)
  }

  build(){
    Row(){
      if(this.item.isComplete){
        this.labelIcon($r('app.media.done'))
      }else{
        this.labelIcon($r('app.media.did_not'))
      }
      Text(this.item.toDoContent)
        .margin(5)
        .decoration({type: this.item.isComplete ? TextDecorationType.LineThrough : TextDecorationType.None})
    }
    .opacity(this.item.isComplete ? 0.6 : 1)
    .onClick(e =>{
        this.item.isComplete = !this.item.isComplete
    })
  }
}