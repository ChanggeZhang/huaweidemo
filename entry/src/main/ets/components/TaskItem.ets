import { TaskData } from '../model/data/TaskData';
import { dateFormat } from '../utils/DateUtil';
@Component
export default struct TaskItem{
  @Prop editable:boolean;
  selfIndex:number;
  @ObjectLink taskData:TaskData;
  @Link @Watch("clickIndexChange") clickIndex:number;
  @State opened:boolean = false;
  @State selectAll:boolean = false
  @State selected:boolean = false
  progress:number = 0;
  @Link finishedItem:number;

  build(){
    Row(){
      Column(){
        Row(){
          Text(this.taskData.getTitle).fontSize("16fp").fontWeight(FontWeight.Bold).width(this.editable ? `${16*5}fp` : `${16*6}fp`)
          Row(){
            Column(){
              Text(`${(this.taskData.getProgress || 0).toFixed(2)}%`).fontSize("16fp").fontWeight(FontWeight.Bold)
              Text(`更新时间: ${dateFormat(this.taskData.getEditTime,{pattern: "yyyy/MM/dd HH:mm:ss"})}`)
            }.alignItems(HorizontalAlign.End)
            if(this.editable){
              Checkbox({group: "select-all"})
                .selectedColor(0x00abff).borderColor(0x00abff).selectedColor(0x00abff).onChange(e => {
                this.taskData.setDeleted = e.valueOf()
              })
            }
          }
        }.width("100%").justifyContent(FlexAlign.SpaceBetween)
        if(this.opened){
          Column(){
            Slider({
              value: this.taskData.getProgress,
              style: SliderStyle.InSet,
              direction: Axis.Horizontal,
              step: 0.01,
              min: 0,
              max: 100
            }).showTips(true).onChange((value:number,mode:SliderChangeMode) => {
              this.progress = value
            })
            Row({space: 40}){
              Text("取消")
                .fontColor(0x00abff)
                .fontWeight(FontWeight.Bolder)
                .onClick(e => this.opened = false)
              Text("确认")
                .fontColor(0x00abff)
                .fontWeight(FontWeight.Bolder)
                .onClick(e => {
                  let preProgress:number = this.taskData.getProgress;
                  this.taskData.setProgress = this.progress
                  let changed:boolean = preProgress !== this.progress && (preProgress === 100 || this.progress === 100)
                  if(changed){
                    if(this.taskData.getProgress == 100){
                      this.finishedItem += 1
                    }else{
                      this.finishedItem -= 1
                    }
                  }
                  this.opened = false
                })
            }
          }.margin({top: 30})
        }
      }
    }.justifyContent(FlexAlign.SpaceBetween)
    .width("100%")
    .padding(5)
    .height(this.opened ? 160 : 80)
    .borderRadius(5)
    .backgroundColor(
        this.taskData && this.taskData.getProgress === 100 ? 0xababab : 0xffffff
    ).onClick(e => {
      this.clickIndex = this.selfIndex
      this.opened = !this.opened
    })
  }

  clickIndexChange(){
    if(this.clickIndex !== this.selfIndex){
      this.opened = false
    }
  }
}