import http from '@ohos.net.http';
import HashMap from '@ohos.util.HashMap';

/**
 * 常见的媒体类型如
 * text/html ： HTML格式
 * text/plain ：纯文本格式
 * text/xml ：  XML格式(它会忽略xml头所指定编码格式而默认采用us-ascii编码)
 * image/gif ：gif图片格式
 * image/jpeg ：jpg图片格式
 * image/png：png图片格式
 * application/xml     ： XML格式(它会根据xml头指定的编码格式来编码)
 * application/xhtml+xml ：XHTML格式
 * application/atom+xml  ：AtomXML聚合格式
 * application/json    ： JSON数据格式
 * application/pdf       ：pdf格式
 * application/msword  ： Word文档格式
 * application/octet-stream ： 二进制流数据（如常见的文件下载）
 * application/x-www-form-urlencoded ： <formencType=””>中默认的encType，form表单数据被编码为key/value格式发送到服务器（表单默认的提交数据的格式）
 * multipart/form-data ： 需要在表单中进行文件上传时，就需要使用该格式。
 */
export enum MediaType{
  JSON = "application/json",
  JSON_UTF8 = "application/json;charset=UTF-8",
  XML = "text/xml",
  XML_UTF8 = "text/xml;charset=UTF-8",
  TEXT = "text/plain",
  TEXT_UTF8 = "text/plain;charset=UTF-8",
  HTML = "text/html",
  HTML_UTF8 = "text/html;charset=UTF-8",
  X_WWW_FORM_URLENCODED = "application/x-www-form-urlencoded",
  X_WWW_FORM_URLENCODED_UTF8 = "application/x-www-form-urlencoded;charset=UTF-8",
  FORM_DATA = "multipart/form-data",
  FORM_DATA_UTF8 = "multipart/form-data;charset=UTF-8",
  XHTML = "application/xhtml+xml ",
  XHTML_UTF8 = "application/xhtml+xml;charset=UTF-8",
  ATOM_XML = "application/atom+xml ",
  ATOM_XML_UTF8 = "application/atom+xml;charset=UTF-8",
  BINARY = "application/octet-stream"
}

export interface HttpRequestOption{
  url:string
  type?: MediaType
  params?:string | Object | ArrayBuffer
  headers?:HashMap<string,string>
  callback?:PromiseCallback | Function
  method?:http.RequestMethod
  error?:(err:string) => void
}

export class Axios{
  static get(option:HttpRequestOption):void | Promise<http.HttpResponse>{
    option = option || {url:null}
    option.method = http.RequestMethod.GET
    return Axios.axios(option)
  }
  static post(option:HttpRequestOption):void | Promise<http.HttpResponse>{
    option = option || {url:null}
    option.method = http.RequestMethod.POST
    return Axios.axios(option)
  }
  static put(option:HttpRequestOption):void | Promise<http.HttpResponse>{
    option = option || {url:null}
    option.method = http.RequestMethod.PUT
    return Axios.axios(option)
  }
  static options(option:HttpRequestOption):void | Promise<http.HttpResponse>{
    option = option || {url:null}
    option.method = http.RequestMethod.OPTIONS
    return Axios.axios(option)
  }
  static head(option:HttpRequestOption):void | Promise<http.HttpResponse>{
    option = option || {url:null}
    option.method = http.RequestMethod.HEAD
    return Axios.axios(option)
  }
  static delete(option:HttpRequestOption):void | Promise<http.HttpResponse>{
    option = option || {url:null}
    option.method = http.RequestMethod.DELETE
    return Axios.axios(option)
  }
  static trace(option:HttpRequestOption):void | Promise<http.HttpResponse>{
    option = option || {url:null}
    option.method = http.RequestMethod.TRACE
    return Axios.axios(option)
  }
  static connect(option:HttpRequestOption):void | Promise<http.HttpResponse>{
    option = option || {url:null}
    option.method = http.RequestMethod.CONNECT
    return Axios.axios(option)
  }
  static download(option:HttpRequestOption):void | Promise<http.HttpResponse>{
    option = option || {url:null}
    option.type = MediaType.BINARY
    return Axios.axios(option)
  }
  static axios(option:HttpRequestOption):void | Promise<http.HttpResponse>{
    option = option || {url:null}
    if(!option.url){
      return error("请求地址不能为空",option)
    }
    if(!option.method){
      return error("请求方法不能为空",option)
    }
    if (!option.type) {
      option.type = MediaType.JSON_UTF8
    }
    let httpRequest = http.createHttp()
    if(option.callback){
      return request(httpRequest,option)
    }else{
      return requestPromise(httpRequest,option)
    }
  }
}

function error(message:string,option:HttpRequestOption){
  if(!message)return;
  console.error(message)
  if(option && option.error){
    option.error(message)
  }
}

export interface PromiseCallback{
  resolve?:Function
  reject?:Function
}

function requestPromise(httpRequest:http.HttpRequest,option:HttpRequestOption):Promise<http.HttpResponse>{
  return httpRequest.request(option.url,{
    method: option.method || http.RequestMethod.POST,
    usingCache: true,
    usingProtocol: http.HttpProtocol.HTTP1_1,
    header: appendHeader(option.headers),
    extraData: option.params,
    expectDataType: http.HttpDataType.STRING
  })
}

function request(httpRequest:http.HttpRequest,option:HttpRequestOption){
  httpRequest.request(option.url,{
    method: http.RequestMethod.GET,
    expectDataType: http.HttpDataType.STRING,
    usingCache: true,
    usingProtocol: http.HttpProtocol.HTTP1_1,
    header: appendHeader(option.headers),
    extraData: option.params
  },(err:any,data:http.HttpResponse) => {
    if(option.callback instanceof Function){
      option.callback({
        url: option.url,
        err,
        data
      })
    }else{
      if (option.callback.resolve) {
        option.callback.resolve(data)
      }
      if (option.callback.reject) {
        option.callback.reject(err)
      }
    }
  })
}

function appendHeader(headers:HashMap<string,string>):HashMap<string,string>{
  let header = new HashMap<string,string>();
  header.set("Accept", "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7")
  header.set("Accept-Encoding", "gzip, deflate, br")
  header.set("Accept-Language", "en,en-US;q=0.9")
  header.set("Cache-Control", "max-age=0")
  header.set("Connection", "keep-alive")
  header.set("Host", "localhost:8080")
  header.set("If-None-Match", "W/\"27d-zpkk9Q0jauBEimHoAyhCaVDqD9A\"")
  header.set("Sec-Ch-Ua", '"Microsoft Edge";v="119", "Chromium";v="119", "Not?A_Brand";v="24"')
  header.set("Sec-Ch-Ua-Mobile", "?0")
  header.set("Sec-Ch-Ua-Platform", "Windows")
  header.set("Sec-Fetch-Dest", "document")
  header.set("Sec-Fetch-Mode", "navigate")
  header.set("Sec-Fetch-Site", "none")
  header.set("Sec-Fetch-User", "?1")
  header.set("Upgrade-Insecure-Requests", "1")
  header.set("User-Agent", "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/119.0.0.0 Safari/537.36 Edg/119.0.0.0")
  if(headers){
    headers.forEach((val:string,key:string) => {
      if(key && val){
        header.set(key,val)
      }
    })
  }
  return header;
}