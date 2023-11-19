export default class MainMenu{
  private title:string;
  private icon:Resource;
  private selectIcon:Resource;
  private link:string;
  private param:Object;

  constructor(title:string,icon:Resource,selectIcon:Resource,link:string,param?:Object) {
    this.title = title;
    this.icon = icon;
    this.selectIcon = selectIcon;
    this.link = link;
    this.param = param
  }

  get getTitle():string{
    return this.title;
  }

  get getIcon():Resource{
    return this.icon;
  }

  get getSelectIcon():Resource{
    return this.selectIcon;
  }

  get getLink():string{
    return this.link;
  }

  get getParam():Object{
    return this.param;
  }
}