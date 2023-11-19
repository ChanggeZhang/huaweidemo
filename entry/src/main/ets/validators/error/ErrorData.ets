
import { ErrCode } from './ErrCode';
export default class ErrorData{
  private code:ErrCode;
  private msg:string;

  constructor(code:ErrCode,msg:string) {
    this.code = code;
    this.msg = msg;
  }

  get getCode():ErrCode{
    return this.code;
  }

  get getMsg():string{
    return this.msg;
  }

  public toString():string{
    return JSON.stringify(this);
  }

  public static buildError(msg:string):ErrorData{
    return new ErrorData(ErrCode.ERROR,msg);
  }

  public static buildSuccess(msg:string):ErrorData{
    return new ErrorData(0,msg);
  }

  public static buildErr():ErrorData{
    return new ErrorData(ErrCode.ERROR,"错误");
  }

  public static buildSucc():ErrorData{
    return new ErrorData(0,"操作完成");
  }
}