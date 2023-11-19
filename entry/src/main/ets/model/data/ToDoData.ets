export default class ToDoData{
  isComplete: boolean;
  toDoContent: string;
  id: number;

  constructor(isComplete:boolean = false,toDoContent: string = "",id:number = 0) {
    this.isComplete = isComplete;
    this.toDoContent = toDoContent;
    this.id = id;
  }
}