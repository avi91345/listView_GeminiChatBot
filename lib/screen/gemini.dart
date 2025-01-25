import "package:flutter/material.dart";
import "package:speakxassignment/services/geminiAPIcall.dart";
import "package:speakxassignment/widgets/simmer.dart";
class gemini extends StatefulWidget{
  const gemini({super.key});


  @override
  State<gemini> createState() => geminiAPI();
}

class geminiAPI extends State<gemini>{
  bool isloding=false;
  String geminianswer="Welcome to Gemini chat bot :)";
  TextEditingController _tcc= new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text("GEMINI CHAT BOT",style: TextStyle(fontWeight: FontWeight.w500),),
        backgroundColor: Colors.blueAccent,
      ),
      body:  Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(

              child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.green, width: 2), // Border color and width
                borderRadius: BorderRadius.circular(15),
              
              ),
                child:SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: isloding?ShimmerLoading() :
                      Text(geminianswer,style: TextStyle(fontSize: 25)
                      ),
                    )
                )
              ),
            ),
            SizedBox(height: 8),

            Container(
               width: double.infinity,
               child: TextField(
                    controller: _tcc,
                  decoration: InputDecoration(
                      hintText: "Search",
                      suffixIcon: IconButton(onPressed: () async {
                        String prmt=_tcc.text;
                        if(prmt.isNotEmpty) {
                          _tcc.clear();

                          await gemini(prmt);
                        }

                      }, icon: Icon(Icons.send)),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Colors.green,width:2), // Green border
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Colors.green,width: 2), // Green border
                      )
             
             
             
             
             
                  ),
                ),
             ),

        ],
        ),
      )
    );
  }
  Future<void> gemini(String prompt) async {
    setState(() {
      isloding=true;
    });
    geminiservice g= geminiservice();
    geminianswer=(await g.geminianswer(prompt))!;
    setState(() {isloding=false;
    });

  }


}