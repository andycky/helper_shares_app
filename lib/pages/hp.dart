import 'dart:convert';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../const/const.dart';
import '../response/employers.dart';
import '../response/helpers.dart';

class NewScreen extends StatelessWidget {

  static String gasUrl = "https://script.google.com/macros/s/AKfycbyDoiqgjNI0mDqXgN7zLiLFkt-8H_Pssc1OqG8pgHmAG3_UTY-ayjDf4ix7c4ds35xa/exec";

  final Employer employer;

  const NewScreen(this.employer);

  @override
  Widget build(BuildContext context) {

    late Future<List<Helper>> futureHelpers;

    futureHelpers = fetchApi();

    return Scaffold(
      appBar: AppBar(title: Center(child:Text('${this.employer.name} 在搜尋      '))),
      body: Center(
        child: FutureBuilder<List<Helper>>(
            future: futureHelpers,
            builder: (context, snapshot) {
              final ScrollController _homeController = ScrollController();
              if (snapshot.hasData) {
                return HelpersList(helpers: snapshot.data!);
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              // By default, show a loading spinner.
              return const CircularProgressIndicator();
            }
        )
      ),
    );
  }

  Future<List<Helper>> fetchApi() async {
    final response = await http.Client()
        .get(Uri.parse("${Const.gasUrl}?api=${Const.API_NAME_HELPERDATA_BY_EM}&employer=${employer.name}"));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      print(jsonDecode(response.body));
      return compute(Helper.parseHelpers, response.body);
      //return Employer.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }
}

class HelpersList extends StatelessWidget {
  const HelpersList({super.key, required this.helpers});

  final List<Helper> helpers;

  @override
  Widget build(BuildContext context) {
    final ScrollController _homeController = ScrollController();

    return GridView.builder(
        controller: _homeController,
        itemBuilder: (BuildContext context, int index) {
          return HelperItem(
              helpers.elementAt(index),
            );
        },
        // separatorBuilder: (BuildContext context, int index) => const Divider(
        //   thickness: 0,
        // ),
        itemCount: helpers.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),    );
  }
}

class HelperItem extends StatelessWidget {
  const HelperItem(this.helper);

  final Helper helper;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    //print(helper.mark.length.toString());
    return Card(child:ListTile(title:Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(child: CircleAvatar(
          radius: 14,
          backgroundColor: Colors.grey,
          child:Text(helper.mark.length.toString(),style: const TextStyle(fontSize: 12,color: Colors.white)),
        )),
        Expanded(flex:4,child: Container(
            //alignment: Alignment.center,
            child:Text(helper.nname.substring(0,min(helper.nname.length,10))
        ))),
        Expanded(child: (helper.L=="Oversea")?
          const CircleAvatar(
          radius: 14,
          backgroundColor: Colors.blue,
          child:Text("O",style: TextStyle(fontSize: 12,color: Colors.white)),
        ):const CircleAvatar(
          radius: 14,
          backgroundColor: Colors.green,
          child:Text("L",style: TextStyle(fontSize: 12,color: Colors.white)),
        )),
        Expanded(child: (helper.count!="")?CircleAvatar(
          radius: 14,
          backgroundColor: Colors.grey,
          child:Text(helper.count.toString(),style: const TextStyle(fontSize: 12,color: Colors.white)),
        ):const Text("")),
        Expanded(child: (helper.count_interview!="")?CircleAvatar(
          radius: 14,
          backgroundColor: Colors.grey,
          child:Text(helper.count_interview.toString(),style: const TextStyle(fontSize: 12,color: Colors.white)),
        ):const Text("")),
        // Expanded(flex:1,child: GestureDetector(
        //     onTap: _launchURL,
        //     child:Image.asset('assets/img/whatsapp.png',width:35,height:35,
        //     ))),
      ],
    ),
      //subtitle: Text(helper.service+" | "+helper.N+" | "+helper.L+" | "+helper.S.toString()+" | "+helper.age.toString()+" | "+helper.D+" | "+helper.R+" | "+helper.H+" | "+helper.G),
      subtitle: (helper.image!="")?Image.network(helper.image):Image.asset("assets/img/logo.jpeg"),
    ),
    );

    throw UnimplementedError();
  }

  void _navigateToNextScreen(BuildContext context,employerName) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => NewScreen(employerName)));
  }
}