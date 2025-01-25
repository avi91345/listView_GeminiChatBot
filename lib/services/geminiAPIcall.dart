import 'package:google_generative_ai/google_generative_ai.dart';

class geminiservice {
  static const String apikey = "put your gemini api key ";

  Future<String?> geminianswer(String prompt) async {
    // all implementation code is availavle on google generative ai docs
    //i just copied from there and modified according to my app needs
    try {
      final model = GenerativeModel(apiKey: apikey, model: 'gemini-1.5-flash-latest');
      final content=Content.text(prompt);
      final response= await model.generateContent([content]);
      if(response!=null) {
        return response.text;
      }
      else{
        return "error occured";
      }
    } catch (e) {
      print("error: $e");
      return 'Error occurred';
    }
  }
}
