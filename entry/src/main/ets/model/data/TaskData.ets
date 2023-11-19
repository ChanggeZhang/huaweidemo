
import {formatNow} from '../../utils/DateUtil';

@Observed
export class TaskData{
  private title:string;
  private editTime:Date;
  private progress:number = 0;
  private deleted:boolean;

  constructor(title:string) {
    this.title = title;
    this.deleted = false
    this.progress = 0;
    this.editTime = new Date()
  }

  set setProgress(progress:number){
    this.progress = progress;
    this.editTime = new Date();
  }

  set setDeleted(deleted:boolean){
    this.deleted = deleted;
  }

  get getDeleted():boolean{
    return this.deleted;
  }

  get getTitle():string{
    return this.title;
  }

  get getEditTime():Date{
    return this.editTime;
  }

  get getProgress():number{
    return this.progress;
  }
}