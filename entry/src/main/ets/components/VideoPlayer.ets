
import promptAction from '@ohos.promptAction'
import VideoInfo from '../model/data/VideoInfo'
import VideoTime from '../model/data/VideoTime'
import { prepared } from '../utils/VideoUtil'
import { VideoSlider } from './VideoSlider'
@Component
export default struct VideoPlayer{
  private videoController:VideoController = new VideoController()
  @Consume video:VideoInfo
  @State playing:boolean = false;
  @Link @Watch("switchAutoPlay") autoPlay:boolean;

  build(){
    Column(){
      Video({
        controller: this.videoController,
        src: this.video.getSrc,
        previewUri: this.video.getPreviewUrl,
        currentProgressRate: PlaybackSpeed.Speed_Forward_1_00_X
      }).autoPlay(true).controls(false).loop(false).objectFit(ImageFit.Auto).height(230).muted(false)
      .onPrepared((event:{duration:number}) => {
        let res:VideoTime = prepared(event)
        this.video.setTotalTime = res.getTime
        this.video.setTotalTimeStr = res.getTimeStr
      }).onUpdate((event:{time:number}) => {
        let res:VideoTime = prepared({ duration: event.time })
        this.video.setCurrentTime = res.getTime
        this.video.setCurrentTimeStr = res.getTimeStr
      })
        .onFinish(() => {
          this.playing = false
          this.video.setCurrentTimeStr = "00:00"
          this.video.setTotalTimeStr = "00:00"
          this.video.setCurrentTime = 0
          this.video.setTotalTime = 0
        })
        .onError(() => {
          promptAction.showToast({
            message: "视频播放出错",
            duration: 2000,
            bottom: 500
          })
      })
      VideoSlider({
        controller: this.videoController,
        playing: $playing
      })
    }.width("100%")
  }

  switchAutoPlay(){
    if(this.autoPlay){
      this.playing = true
    }
  }
}