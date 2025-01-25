import 'package:flutter/material.dart';
import "package:flutter_riverpod/flutter_riverpod.dart";
import 'package:speakxassignment/screen/splash.dart';
import 'package:speakxassignment/viewmodels/logic.dart';
import 'package:speakxassignment/widgets/simmer.dart';
import 'package:speakxassignment/screen/gemini.dart';



void main() {
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: splashscreen(),
    );
  }
}

class MyHomePage extends ConsumerStatefulWidget {
  const MyHomePage({super.key, required this.title});


  final String title;

  @override
  ConsumerState<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<MyHomePage> {
  int firstid = 101;
  int lastid = 100;
  ScrollController _sc = ScrollController();
  List<dynamic> maindata =[];
  bool isscrollup=false;
  bool isscrolldown=false;
  TextEditingController _tc= TextEditingController();
  List<dynamic> searchdata=[];
  bool istextsearch=false;



  @override
  void initState() {
    super.initState();
    loaddown();

    _sc.addListener(() {
      if (_sc.position.pixels >= _sc.position.maxScrollExtent - 150 && lastid!=2000&& !ref
          .read(lodingPrd.notifier)
          .state) {
        loaddown();
      }
      if (_sc.position.pixels <= _sc.position.minScrollExtent +5 &&firstid!=0&&
          !ref.read(lodingPrd.notifier).state && _sc.offset == 0.0) {
        loadup();

      }
    });
    _tc.addListener((){
      if(_tc.text.isNotEmpty) {
        textsearch(_tc.text);

      }
      else{
        setState(() {
          istextsearch=false;
        });
      }
    });
  }
  void textsearch(String search){
    setState(() {
      istextsearch=true;
    });
    final filter=maindata.where((item){
      return item['title'].toString().toLowerCase().contains(search.toLowerCase());
    }).toList();
    setState(() {
      searchdata=filter;
    });

  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(

          backgroundColor: Colors.deepOrange,


          title: Text(widget.title,style: TextStyle(fontSize: 25,fontWeight: FontWeight.w500,color: Colors.white),),


        ),
        body:

        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children : [
            Padding(
              padding: EdgeInsets.all(10),
              child: Container(
                  width:250,
                  child: TextField(
                    controller: _tc,
                    decoration: InputDecoration(
                      hintText: "Search",
                      suffixIcon: Icon(Icons.search),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: Colors.green), // Green border
                        ),
                        focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: Colors.green,width: 2), // Green border
                  )





                    ),
                  )
              ),
            ),
            Expanded(
            child: istextsearch
            ?ListView.builder(
            itemCount:searchdata.length,
      itemBuilder:(context, index){
        return Padding(
          padding: EdgeInsets.all(6),
          child: Card(
            shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.blue, width: 2),
                borderRadius: BorderRadius.circular(15)

            ),
            child:ListTile(
              leading: CircleAvatar(child: Icon(Icons.person_2_sharp)),
              title:Text(searchdata[index]["id"].toString()),
              subtitle:Text(searchdata[index]["title"]),
            ),
          ),
        );
      },
    ):ListView.builder(

                itemCount: maindata.length + (isscrolldown?1:0) + (isscrollup?1:0),
                controller: _sc,
                itemBuilder: (context, index) {
                  if (index == 0 &&isscrollup&& firstid!=0) {
                    return ShimmerLoading();
                  }
                  if (index == maindata.length&&lastid!=2000&&isscrolldown) {
                    return ShimmerLoading();
                  }
                  final adind = isscrollup ? index - 1 : index;
                  return Padding(
                    padding: EdgeInsets.all(6),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.blue, width: 2),
                        borderRadius: BorderRadius.circular(15)

                      ),
                      child: ListTile(
                        leading: CircleAvatar(child: Icon(Icons.person_2_sharp)),
                        title: Text(maindata[adind]["id"].toString()),
                        subtitle: Text(maindata[adind]["title"]),
                      ),
                    ),
                  );
                }),
          )],
        ),


    floatingActionButton: FloatingActionButton(onPressed: (){
      Navigator.push(context,MaterialPageRoute(builder: (context)=>gemini()) );
    },
    child: Icon(Icons.emoji_objects_outlined),),

    );

  }

  Future<void> loaddown() async {
    setState(() {
      isscrolldown=true;
    });
    await ref.read(apiFetchPd.notifier).fetchdatas(lastid, "downscroll");
    var newData = await ref.read(apiFetchPd);
    setState(() {
      maindata.addAll(newData);
      lastid = newData[newData.length - 1]["id"];
      isscrolldown=false;
    });
  }

  Future<void> loadup() async {
    setState(() {
      isscrollup=true;
    });
    await ref.read(apiFetchPd.notifier).fetchdatas(firstid, "upscroll");
    var newdata = ref.read(apiFetchPd);
    setState(() {
      if (newdata.isNotEmpty) {
        maindata.insertAll(0, newdata);
        firstid = newdata[0]["id"];
        isscrollup = false;
      }
    });



    }

}
