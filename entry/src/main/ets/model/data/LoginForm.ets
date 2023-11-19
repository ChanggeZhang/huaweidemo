export default class LoginForm{
  private account:string;
  private password:string;

  get getAccount():string{
    return this.account;
  }
  set setAccount(val:string){
    this.account = val;
  }

  get getPassword():string {
    return this.password;
  }

  set setPassword(val:string){
    this.password = val;
  }

}