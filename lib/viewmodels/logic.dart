import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:speakxassignment/services/fetch_data_api.dart";



final apiProvider= Provider((ref) =>Fetchdata() );
final hasMorePrd= StateProvider((ref) => true);
final lodingPrd=StateProvider((ref) => true );

final apiFetchPd = StateNotifierProvider<ItemGetAPI, List<Map<String,dynamic>>>((ref){
        return ItemGetAPI(ref);
});



class ItemGetAPI extends StateNotifier<List<Map<String,dynamic>>>{
  final Ref ref;

  ItemGetAPI(this.ref) : super([]);

   Future<void> fetchdatas(int lastid,String direction)  async {
     try {

       ref.read(lodingPrd.notifier).state=true;
       if(lastid <0 || lastid>2000){
         ref.read(hasMorePrd.notifier).state=false;
         return;
       }
       Fetchdata fd=ref.read(apiProvider);
       var result = await fd.fetchdata(lastid, direction);
       var data = result["items"];

       ref.read(hasMorePrd.notifier).state = result["hasMore"];


      state=data;



     }catch(e){
       print('Error fetching data : $e');

     } finally{
       ref.read(lodingPrd.notifier).state=false;
     }
  }

}



