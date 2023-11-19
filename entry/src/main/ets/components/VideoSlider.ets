import VideoInfo from '../model/data/VideoInfo';
import { formatVideoTime } from '../utils/VideoUtil';
@Component
export struct VideoSlider{
  private controller:VideoController
  @Link playing:boolean;
  @Consume video:VideoInfo

  build(){
    Row({space: 6}){
      Image(this.playing ? $r('app.media.pause') : $r('app.media.playing')).width(12).height(12).onClick(e => {
        this.playing ? this.controller.pause() : this.controller.start()
        this.playing = !this.playing
      })
      Text(this.video.getCurrentTimeStr)
      Slider({
        value: this.video.getCurrentTime,
        min: 0,
        max: this.video.getTotalTime,
        step: 1,
        style: SliderStyle.OutSet
      }).width('65%')
        .onChange((value:number,mode:SliderChangeMode) => {
        this.video.setCurrentTime = parseInt(value.toString())
        this.video.setCurrentTimeStr = formatVideoTime(this.video.getCurrentTime)
        this.controller.setCurrentTime(this.video.getCurrentTime,SeekMode.Accurate)
      })
      Text(this.video.getTotalTimeStr)
    }.width("100%").justifyContent(FlexAlign.Center).backgroundColor(0xababab)
  }
}
