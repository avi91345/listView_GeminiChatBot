

class Fetchdata{

  static const int itemToFetch=20;



  Future<Map<String, dynamic>> fetchdata(int id ,String dir) async {
    await Future.delayed(Duration(seconds: 2));
    bool isFetched = true;

    //get the data here
    List<Map<String,dynamic>> items=[];
    bool hasMore =true;
    int startid=(dir=="upscroll"?id-1:id+1);


    if(dir=="upscroll"){
      if (startid < 0) {
        hasMore = false;
      } else {


        for(int i =(startid-itemToFetch<0?0:startid-itemToFetch);i<=startid ;i++){

          items.add({"id": i, "title": "Item $i"});
        }
        if(startid-itemToFetch<0){
          hasMore=false;
        }
      }




    }
    else if(dir=="downscroll"){
      if (startid>2000) {
        hasMore = false;
      } else {

        for(int i =startid;i<startid+itemToFetch;i++){
          if (i > 2000) {
            hasMore = false;
            break;
          }
          items.add({"id": i, "title": "Item $i"});
        }
      }


    }
    if(isFetched) {
      return {
        "items": items,
        "hasMore": hasMore
      };
    }else{
      //as i kept isFetched true above so this code become dead.
      throw Exception("Failed to connect to Api and get the data");
    }

  }
}
