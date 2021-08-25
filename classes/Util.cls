public class Util {


    public static map<string, string> clasifySecondFieldByFirstField(list<SObject> sObjectList, string fieldForKey, string fieldForValue){
        map<string, string> retMap = new map<string, string>();
        for(sObject i : sObjectList){
            retMap.put(String.valueOf(i.get(fieldForKey)), String.valueOf(i.get(fieldForValue)));
        }
        return retMap;
    }


    public static String convertSetToIn(set<String> setToConvert){
        return convertListToIn(new list<String>(setToConvert));

    }

    public static String convertListToIn(list<String> listToConvert){
        return '\''+String.join(listToConvert, '\',\'')+'\'';
    }


    
}