
import webview from '@ohos.web.webview';
import http from '@ohos.net.http';
import { Axios } from '../web/http/HttpUtils';
@Entry
@Component
struct WebPage {

  controller:WebviewController = new webview.WebviewController();
  textOperator:TextInputController = new TextInputController();
  @State res:{error:any,data:http.HttpResponse} = null
  @State url:string = "";

  build() {
    Column(){
      TextInput({
        text: this.url || "http://localhost:8080",
        placeholder:"请输入网址",
        controller:this.textOperator
      }).borderWidth(0).onChange((val:string) => {
        this.url = val
      })
      Button("请求").onClick(e => {
        this.startRequest()
      })
      if (this.url) {
        Web({
          src: this.url,
          controller: this.controller
        }).imageAccess(true).javaScriptAccess(true).onlineImageAccess(true)
      }
    }
  }

  startRequest(){
    Axios.get({
      url: this.url,
      callback: (res:{error:any,data:http.HttpResponse}) => {
        this.res = res;
      }
    });
  }
}