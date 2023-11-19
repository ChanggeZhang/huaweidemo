declare class FormatOption{
  pattern?:string;
  twentyFour?:boolean;
}

export function dateFormat(date: Date,option?:FormatOption):string{
  date = date || new Date()
  let pattern = (option && option.pattern) || "yyyy-MM-dd"
  let yy:Number = date.getFullYear() % 100
  let yyyy:number = date.getFullYear();
  let M:number = date.getMonth() + 1;
  let MM:string = paddingZero(date.getMonth() + 1,"0",2)
  let d:number = date.getDate();
  let dd:string = paddingZero(date.getDate(),"0",2)
  let H:number = date.getHours()
  let HH:string = paddingZero(date.getHours(),"0",2)
  let hour = date.getHours() === 12 ? 12 : date.getHours() % 12;
  let h:string = (date.getHours() > 12 ? "上午" : "下午") + hour
  let hh:string = (date.getHours() > 12 ? "上午" : "下午") + paddingZero(hour,"0",2)
  let m:number = date.getMinutes();
  let mm:string = paddingZero(date.getMinutes(),"0",2)
  let s:number = date.getSeconds()
  let ss:string = paddingZero(date.getSeconds(),"0",2)
  let S:number = date.getMilliseconds()
  let SSS:string = paddingZero(date.getMilliseconds(),"0",3)
  let W:string = "日一二三四五六".charAt(date.getDay());
  let WWWW:string = "星期" + W;
  return pattern.replace("yyyy",yyyy.toString()).replace("MM",MM).replace("dd",dd)
    .replace("HH",HH).replace("mm",mm).replace("ss",ss).replace("SSS",SSS)
    .replace("yy",yy.toString()).replace("M",M.toString()).replace("d",d.toString()).replace("H",H.toString()).replace("m",m.toString()).replace("s",s.toString()).replace("S",S.toString())
    .replace("hh",hh).replace("h",h).replace("WWWW",WWWW).replace("W",W)
}

export function formatNow(option?:FormatOption):string{
  return dateFormat(new Date(),option)
}

function paddingZero(template:any,paddingStr:string,paddingLength:number):string {
  let newStr:string = (paddingStr.repeat(paddingLength) + template);
  return newStr.substring(newStr.length - paddingLength)
}
