export default class VideoTime{
  private time:number;
  private timeStr:string

  constructor(time:number,timeStr:string) {
    this.time = time;
    this.timeStr = timeStr
  }

  get getTime():number{
    return this.time;
  }

  set setTime(time:number){
    this.time = time;
  }

  get getTimeStr():string{
    return this.timeStr
  }

  set setTimeStr(timeStr:string){
    this.timeStr = timeStr
  }
}