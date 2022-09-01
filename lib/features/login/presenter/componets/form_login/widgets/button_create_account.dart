import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ButtonCreateAccount extends StatelessWidget {
  const ButtonCreateAccount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mediaSize = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        launchUrl(Uri.parse('https://www.themoviedb.org/signup'));
      },
      child: Container(
        width: mediaSize.width * 0.8,
        height: mediaSize.height * 0.2,
        constraints:
            const BoxConstraints(maxHeight: 70, minHeight: 50, maxWidth: 300),
        decoration: BoxDecoration(
          color: Colors.black87,
          border: Border.all(width: 1, color: Colors.white),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Image.asset(
                'assets/images/moviesDB2.png',
                width: 60,
              ),
              const Expanded(
                  flex: 2,
                  child: Center(
                    child: Text(
                      'Criar conta',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )),
              Expanded(
                  flex: 1,
                  child: Center(
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.black,
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.white,
                              blurRadius: 5,
                              spreadRadius: 0.3,
                              offset: Offset(-2, -2),
                            ),
                            BoxShadow(
                              color: Colors.white,
                              blurRadius: 5,
                              spreadRadius: 0.3,
                              offset: Offset(2, 2),
                            )
                          ]),
                      child: const Icon(
                        Icons.double_arrow,
                        size: 40,
                        color: Colors.white,
                      ),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
// Link(
//                   uri: Uri.parse("https://www.instagram.com/ricardooliver.ads/"),
//                   target: LinkTarget.blank, 
//                   builder: (context, followLink){
//                     return GestureDetector(
//                       onTap: followLink,
//                       child: Icon(FontAwesomeIcons.instagramSquare, color: Definicoes.bgColor,size: 30),
//                     );
//                   }
//                 )