import VideoTime from '../model/data/VideoTime';
export function prepared(event:{duration:number}):VideoTime{
  if(!event) return new VideoTime(0,"00:00")
  let { duration } = event
  let res = new VideoTime(duration,formatVideoTime(duration))
  return res;
}

export function formatVideoTime(duration:number){
  let second:number = duration % 60
  let min:number = parseInt((duration / 60).toString() )
  let head:string = padding(min,2)
  let end:string = padding(second,2)
  return `${head}:${end}`
}

function padding(num:number,pad:number){
  let str:string = num.toString()
  if(str.length < pad){
    let tmp:string = "0".repeat(pad) + num
    return tmp.substring(tmp.length - pad)
  }
  return str;
}