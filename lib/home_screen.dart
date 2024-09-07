import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:translator/translator.dart';

void main() async{
  final translator = GoogleTranslator();

  var translation = await translator.translate("Dart is very cool", to: 'pl');
  print(translation);

  print(await "I love you".translate(to: 'fr'));
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  var languages = ['English', 'Korean', 'Spanish', 'Chinese'];
  var originLanguage = "From";
  var destinationLanguage = "To";
  var output = "";
  TextEditingController languageController = TextEditingController();

  void translate(String src, String dest, String input) async{
    GoogleTranslator translator = new GoogleTranslator();
    var translation = await translator.translate(input, from: src, to: dest);
    setState(() {
      output = translation.text.toString();
    });
    if(src=='..' || dest =='..'){
      setState(() {
        output = "Failed to translate";
      });
    }
  }

  String getLanguageCode(String language){
    if(language == "English") {
      return "en";
    }else if(language == "Spanish"){
      return "es";
    }else if(language == "Korean") {
      return "ko";
    }else if(language == "Chinese") {
      return "zh";
    }
    return "--";
  }
  
  FlutterTts flutterTts = FlutterTts();
  
  void textToSpeech(String text) async{
    await flutterTts.setLanguage("$originLanguage - $destinationLanguage");
    await flutterTts.setVolume(0.5);
    await flutterTts.setSpeechRate(0.5);
    await flutterTts.setPitch(1);
    await flutterTts.speak(text);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF10223D),
        elevation: 0,
        centerTitle: true,
        title: Text('Language Translator', style: TextStyle(
          color: Colors.yellow,
          fontSize: 28,
        ),),
      ),
      
      body: Container(
        height: MediaQuery.of(context).size.height,
        color: Color(0xFF10223D),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 40,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    DropdownButton(
                      focusColor: Colors.yellow,
                      iconDisabledColor: Colors.white,
                      iconEnabledColor: Color(0xFF10223D),
                      hint: Text(
                        originLanguage, style: TextStyle(
                        color: Colors.yellow,
                      ),
                      ),
                      dropdownColor: Colors.yellow,
                      icon: Icon(Icons.keyboard_arrow_down),
                      items: languages.map((String dropDownItem){
                        return DropdownMenuItem(child: Text(dropDownItem),
                          value: dropDownItem);
                    }).toList(),
                      onChanged: (String? value){
                        setState(() {
                          originLanguage = value!;
                        });
                      }
                    ),

                    SizedBox(width: 40,),
                    Icon(Icons.arrow_forward_ios_rounded, color: Colors.yellow, size: 40,),
                    SizedBox(width: 40,),

                    DropdownButton(
                        focusColor: Colors.yellow,
                        iconDisabledColor: Colors.white,
                        iconEnabledColor: Color(0xFF10223D),
                        hint: Text(
                          destinationLanguage, style: TextStyle(
                          color: Colors.yellow,
                        ),
                        ),
                        dropdownColor: Colors.yellow,
                        icon: Icon(Icons.keyboard_arrow_down),
                        items: languages.map((String dropDownItem){
                          return DropdownMenuItem(child: Text(dropDownItem),
                              value: dropDownItem);
                        }).toList(),
                        onChanged: (String? value){
                          setState(() {
                            destinationLanguage = value!;
                          });
                        }
                    ),
                  ],
                ),

                SizedBox(height: 40,),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    cursorColor: Colors.yellow,
                    autofocus: false,
                    style: TextStyle(
                      color: Colors.yellow,
                    ),
                    decoration: InputDecoration(
                      labelText: 'Please enter text for convertion',
                      labelStyle: TextStyle(
                        fontSize: 15,
                        color: Colors.yellow,
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.yellow,
                          width: 1,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.yellow,
                          width: 1,
                        ),
                      ),
                      errorStyle: TextStyle(
                        color: Colors.red,
                        fontSize: 15,
                      )
                    ),
                    controller: languageController,
                    validator: (value){
                      if(value == null || value.isEmpty){
                        return 'Please enter text to translate';
                      }
                      return null;
                    },
                  ),
                ),
                
                Padding(
                  padding: EdgeInsets.all(8),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.yellow,
                    ),
                    onPressed:(){
                      translate(
                        getLanguageCode(originLanguage),
                        getLanguageCode(destinationLanguage),
                        languageController.text.toString()
                      );
                      textToSpeech(languageController.text.toString());
                    },
                    child: Text('Translate', style: TextStyle(
                        color: Color(0xFF10223D),
                    ),)
                  ),
                ),

                SizedBox(height: 20,),

                Text("\n$output", style: TextStyle(
                  color: Colors.yellow,
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),),

                GestureDetector(
                  onTap: (){
                    textToSpeech(languageController.text.toString());
                  },
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.yellow,
                    ),
                    child: Center(
                      child: Icon(
                        Icons.volume_up,
                        color: Color(0xFF10223D),
                      ),
                    ),
                  ),
                )

              ],
            ),
          ),
        ),
      ),
    );
  }
}
