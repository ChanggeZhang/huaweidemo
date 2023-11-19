
import promptAction from '@ohos.promptAction';
import HashMap from '@ohos.util.HashMap';
import TaskAddDialog from '../components/TaskAddDialog';
import TaskItem from '../components/TaskItem';
import { TaskData } from '../model/data/TaskData';
import { formatNow } from '../utils/DateUtil';

@Entry
@Component
struct TaskList{

  @State editable:boolean = false;
  d:string = formatNow({pattern: "yyyy-MM-dd HH:mm:ss"})
  @State tasks:Array<TaskData> = [
    new TaskData("学习ArkTS"),
    new TaskData("学习进阶课程"),
  ]
  @State selectAll:boolean = false;
  @State clickedIndex:number = -1;
  @State finishedItem:number = 0;
  @State dialogShow:boolean = false;
  private tabsController:TabsController = new TabsController();
  taskAddDialogController:CustomDialogController = new CustomDialogController({
    builder: TaskAddDialog({
      callback: (model:HashMap<String,Object>) => {
        this.tasks.push(new TaskData(model.get("subProjectName").toString()))
        this.tasks = [...this.tasks]
        this.taskAddDialogController.close()
        promptAction.showToast({
          message: "添加成功",
          duration: 2000,
          bottom: 500
        })
        this.dialogShow = false;
      },
      close: (e:BaseEvent) => {
        this.dialogShow = false
      },
      title: "添加子项目",
    }),
    alignment: DialogAlignment.Bottom,
    offset: {
      dx: 0,
      dy: -20
    },
    customStyle: true,
    autoCancel: false,
  })

  @Builder btnButtonBuilder(){
    if(this.editable){
      Text("删除").fontColor(0xff6000).onClick(e => {
        this.tasks = [...this.tasks.filter((t: TaskData) => !t.getDeleted)]
        this.selectAll = false
      })
    }else{
      Text("添加子项目").fontColor(0x00abff).onClick(e => {
        this.dialogShow = true
        this.taskAddDialogController.open()
      })
    }
  }

  build(){
    Column(){
      Column(){
        Column(){
          Row(){
            Image("https://img-prod-cms-rt-microsoft-com.akamaized.net/cms/api/am/imageFileData/RE4wpoi?ver=4952")
              .objectFit(ImageFit.Auto)
              .width(120)
              .height(120)
              .borderRadius(10)
            Column(){
              Text("第一季度运营目标"){
                Span("")
              }.fontSize(20).width("100%").textAlign(TextAlign.Start)
              Text("实现用户量与用户活跃度提升。").fontColor(0xababab).width("100%").textAlign(TextAlign.Start)
            }.margin({left: 5}).width("60%").justifyContent(FlexAlign.Start)
          }
          Row(){
            Column(){
              Text("整体进度").fontWeight(FontWeight.Bold).width("100%").textAlign(TextAlign.Start)
              Text(`更新时间：${this.d}`).width("100%").textAlign(TextAlign.Start)
            }.width("80%")
            Row(){
              Progress({
                value: this.finishedItem || !this.finishedItem ? this.tasks.filter((t:TaskData) => {
                  return t.getProgress === 100
                }).length : this.tasks.filter((t:TaskData) => {
                  return t.getProgress === 100
                }).length,
                total: this.tasks.length,
                style: ProgressStyle.Ring,
                type: ProgressType.Ring
              }).color(0x00abff).backgroundColor(0xababab).margin({bottom: 10}).width("100%").height("100%")
              Text(this.finishedItem === this.tasks.length ? "√" : (this.tasks.length == 0 ? "0%" : ((this.finishedItem * 100 / this.tasks.length).toFixed(1) + "%")))
                .fontColor(this.finishedItem === this.tasks.length ? 0x00ABFF : "rgba(0,171,255,0.6)")
                .width("100%")
                .fontSize(this.finishedItem === this.tasks.length ? 26 : 16)
                .fontWeight(this.finishedItem === this.tasks.length ? FontWeight.Bold : FontWeight.Normal)
                .offset({ x: (this.finishedItem === this.tasks.length ? (0 - 60 - 22) : (0 - 60 - 16 * 2)) / 2 })
            }.width(60).height(60)

          }.width("100%").justifyContent(FlexAlign.SpaceBetween).padding(5)
        }.width("95%").backgroundColor(0xffffff).margin({top: "2%"}).borderRadius(5)
        Column(){
          Row(){
            Text("子目标").fontSize(16).fontWeight(FontWeight.Bold)
            if(this.editable){
              Row(){
                Text("取消")
                  .fontColor(0x00abff).onClick(e => this.editable = false).margin({right: 5})
                Text("全选").fontColor(0x00abff)
                CheckboxGroup({group: "select-all"}).selectedColor(0x00abff).selectAll(this.selectAll).onChange(e => this.selectAll = e.status === SelectStatus.All)
              }
            }else{
              Text("编辑")
                .fontColor(0x00abff).onClick(e => this.editable = true)
            }
          }.justifyContent(FlexAlign.SpaceBetween).width("100%").margin({bottom: 10})
          List({space: 10}){
            ForEach(this.tasks,(t:TaskData,index) => {
              ListItem(){
                TaskItem({
                  editable: this.editable,
                  taskData: this.tasks[index],
                  selfIndex: index,
                  clickIndex: $clickedIndex,
                  finishedItem: $finishedItem
                })
              }
            },(t:TaskData) => t.getTitle)
          }
        }.width("95%").margin({top: 30})
      }
      Tabs({
        barPosition: BarPosition.End,
        controller: this.tabsController
      }) {
        if (!this.dialogShow) {
          TabContent().tabBar(this.btnButtonBuilder())
        }
      }
      .vertical(false)
      .barWidth("100%")
      .barHeight('16fp')
      .height("16fp")
      .width("100%")
      .barMode(BarMode.Fixed).margin({bottom: 20})
    }
    .width("100%")
    .height("100%")
    .backgroundColor(0xdedede)
    .justifyContent(FlexAlign.SpaceBetween)
  }
}