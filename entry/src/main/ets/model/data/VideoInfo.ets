@Observed
export default class VideoInfo{
  private src:string | Resource
  private previewUrl:string | Resource | PixelMap
  private currentTime:number;
  private currentTimeStr:string;
  private totalTime:number;
  private totalTimeStr:string;

  constructor(src: string | Resource, previewUrl?: string | Resource | PixelMap) {
    this.src = src;
    this.previewUrl = previewUrl
  }

  get getSrc():string | Resource{
    return this.src
  }

  get getPreviewUrl():string | Resource | PixelMap{
    return this.previewUrl
  }

  set setCurrentTime(duration:number){
    this.currentTime = duration
  }

  set setCurrentTimeStr(durationStr:string){
    this.currentTimeStr = durationStr
  }

  set setTotalTime(duration:number){
    this.totalTime = duration
  }

  set setTotalTimeStr(durationStr:string){
    this.totalTimeStr = durationStr
  }

  get getCurrentTime():number{
    return this.currentTime
  }

  get getCurrentTimeStr():string{
    return this.currentTimeStr
  }

  get getTotalTime():number{
    return this.totalTime
  }

  get getTotalTimeStr():string{
    return this.totalTimeStr
  }


}