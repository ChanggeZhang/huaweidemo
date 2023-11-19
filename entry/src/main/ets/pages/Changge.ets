import router from '@ohos.router'
import ToDoItem from '../components/ToDoItem';
import ToDoData from '../model/data/ToDoData';

@Entry
@Component
struct Changge {

  private dataset:Array<ToDoData> = [
    new ToDoData(false,"学习ArkTS",1),
    new ToDoData(false,"学习ArkTS",2),
    new ToDoData(true,"学习ArkTS",3),
    new ToDoData(true,"学习ArkTS",4),
  ];
  greeting:string = router.getParams()?.['greeting']

  build() {
    Column() {
      Text("待办" + this.greeting)
        .fontSize(26)
        .fontWeight(FontWeight.Bolder)
        .textAlign(TextAlign.Start)
        .width('100%')
      ForEach(this.dataset, (item: ToDoData) => {
        ToDoItem({ item })
      }, (item: ToDoData) => item.id.toString())

    Button('提交')
      .height(26)
      .width(50)
      .backgroundColor("#00abff")
      .fontColor("#ffffff")
      .fontWeight(FontWeight.Bold)
      .onClick(e => {
        AlertDialog.show({
          title: '提示',
          message: JSON.stringify(this.dataset),
          autoCancel: true,
        });
      })
    }
    .width('90%')
    .height('90%')
  }
}