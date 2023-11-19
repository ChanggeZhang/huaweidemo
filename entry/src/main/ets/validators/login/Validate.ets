import LoginForm from '../../model/data/LoginForm'
import ErrorData from '../error/ErrorData'

export default function validate(loginForm:LoginForm):ErrorData {
  let i = 10000;
  while (i-- >= 0 ){
    console.log(i + '');
  }
  if(!loginForm || !loginForm.getAccount){
    return ErrorData.buildError("请填写账号");
  }
  if(!loginForm.getPassword){
    return ErrorData.buildSuccess("请输入密码");
  }
  return null;
}