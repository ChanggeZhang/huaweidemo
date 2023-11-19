export default class Menu{
  private icon:Resource;
  private title:string;
  /**
   * switch or label
   */
  private lastNode:boolean;
  private on:boolean;
  private page:string;
  private params:object;

  constructor(icon:Resource,title:string,lastNode:boolean,page?:string) {
    this.icon = icon;
    this.title = title;
    this.lastNode = lastNode;
    this.page = page;
  }

  get getOn():boolean{
    return this.on;
  }

  set setOn(on:boolean){
    this.on = on;
  }

  get getIcon():Resource{
    return this.icon;
  }

  get getTitle():string {
    return this.title;
  }

  get getLastNode():boolean{
    return this.lastNode;
  }

  set setPage(page:string){
    this.page = page;
  }

  get getPage():string{
    return this.page;
  }

  set setParams(params:object){
    this.params = params
  }

  get getParams():object{
    return this.params
  }
}