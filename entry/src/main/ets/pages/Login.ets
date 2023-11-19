import router from '@ohos.router'
import promptAction from '@ohos.promptAction'
import LoginForm from '../model/data/LoginForm'
import ErrorData from '../validators/error/ErrorData'
import validate from '../validators/login/Validate'

@Entry
@Component
struct Login{

  @State loginForm:LoginForm = new LoginForm()
  @State lock:boolean = false;

  build(){
    Column({space: 20}){
      Image($r('app.media.app_icon')).width(60).height(60).borderRadius(30).objectFit(ImageFit.Cover)
      Text("登陆系统")
        .width('100%')
        .height(26)
        .textAlign(TextAlign.Center)
        .lineHeight(26)
        .fontWeight(FontWeight.Bold)
      Text("登录账号已使用更好的服务").fontColor(Color.Gray)
      TextInput({placeholder: "请输入账号"})
        .type(InputType.Normal)
        .focusable(!this.lock)
        .onChange(v => {
          this.loginForm.setAccount = v
        })
      TextInput({placeholder: "请输入密码"})
        .type(InputType.Password)
        .focusable(!this.lock)
        .onChange(v => this.loginForm.setPassword = v)
      Row(){
        Text("短信验证码登录").fontColor(0x00abff).width('50%')
        Text("忘记密码").fontColor(0x00abff).width('50%').textAlign(TextAlign.End)
      }.justifyContent(FlexAlign.SpaceAround)
      Button("登录").margin({top: 50})
        .type(ButtonType.Capsule)
        .fontColor(0xffffff)
        .backgroundColor(this.lock ? "rgba(0,171,255,0.6)" : 0x00abff)
        .width("100%")
        .onClick(e => {
          if(this.lock) return;
          this.lock = true;
          let err:ErrorData = validate(this.loginForm);
          if(!err){
            AppStorage.SetOrCreate("hasLogin", JSON.stringify(this.loginForm))
            promptAction.showToast({
              message: "登录成功",
              duration: 2000,
              bottom: "50fp"
            })
            this.lock = false
          }else{
            AlertDialog.show({
              title: "登录提示",
              message: err.getMsg,
              autoCancel: true
            })
            this.lock = false
          }
        })
      Text("注册账号")
        .fontColor(0x00abff)
      LoadingProgress().color(0xdedede).visibility(this.lock ? Visibility.Visible : Visibility.None).width(60).height(60).position({x: '50%',y: "50%"})
      Text("其他方式登录").fontColor(Color.Gray)
      Row(){
        Image($r('app.media.mail')).width('60px').height('60px').margin({right: 30})
        Image($r('app.media.qq')).width('60px').height('60px').margin({right: 30})
        Image($r('app.media.wechat')).width('60px').height('60px')
      }
    }.width("90%").margin({top: 30}).padding({left: '5%'})
  }
}
