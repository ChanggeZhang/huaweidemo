import preferencesBuilder from '@ohos.data.preferences';
export enum Const{
  DATABASE = "system_setting",
  KEY = "012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789",
}

const PreferenceUtil = {
  createPreference(context:any){
    globalThis.getPreferences = (() => {
      let preferences:Promise<preferencesBuilder.Preferences> = preferencesBuilder.getPreferences(context,Const.DATABASE)
      return preferences
    })
  },
  create(key:string,val:preferencesBuilder.ValueType){
    globalThis.getPreferences().then((preferences:preferencesBuilder.Preferences) => {
      preferences.has(key).then(async (exist) => {
        if(!exist){
          await preferences.put(key,val)
          preferences.flush()
        }
      })
    })
  },
  update(key:string,val:preferencesBuilder.ValueType){
    globalThis.getPreferences().then(async (preferences:preferencesBuilder.Preferences) => {
        await preferences.put(key,val)
        preferences.flush()
    })
  },
  async get(key:string,defaultValue?:preferencesBuilder.ValueType):Promise<preferencesBuilder.ValueType>{
    const preferences:preferencesBuilder.Preferences = await globalThis.getPreferences()
    let val:preferencesBuilder.ValueType = await preferences.get(key,defaultValue || 0)
    return val;
  }
}

export default PreferenceUtil;