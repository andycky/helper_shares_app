import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../const/const.dart';
import '../pages/hp.dart';
import '../response/employers.dart';

class EmployersPage extends StatelessWidget{

  static String gasUrl = "https://script.google.com/macros/s/AKfycbyDoiqgjNI0mDqXgN7zLiLFkt-8H_Pssc1OqG8pgHmAG3_UTY-ayjDf4ix7c4ds35xa/exec";

  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  const EmployersPage({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return showPage();
    throw UnimplementedError();
  }

  static FutureBuilder showPage() {
    late Future<List<Employer>> futureEmployers;

    futureEmployers = fetchApi();

    return FutureBuilder<List<Employer>>(
        future: futureEmployers,
        builder: (context, snapshot) {
          final ScrollController _homeController = ScrollController();
          if (snapshot.hasData) {
            return EmployersList(employers: snapshot.data!);
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }

          // By default, show a loading spinner.
          return const CircularProgressIndicator();
        }
    );
  }

  static Future<List<Employer>> fetchApi() async {
    final response = await http.Client()
        .get(Uri.parse(Const.gasUrl));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      //print(jsonDecode(response.body));
      return compute(Employer.parseEmployers, response.body);
      //return Employer.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }
}

class EmployersList extends StatelessWidget {
  const EmployersList({super.key, required this.employers});

  final List<Employer> employers;

  @override
  Widget build(BuildContext context) {
    final ScrollController _homeController = ScrollController();

    return ListView.builder(
        controller: _homeController,
        itemBuilder: (BuildContext context, int index) {
          return Center(
            child: EmployerItem(
              employers.elementAt(index),
            ),
          );
        },
         // separatorBuilder: (BuildContext context, int index) => const Divider(
         //   thickness: 0,
         // ),
        itemCount: employers.length);
  }
}

class EmployerItem extends StatelessWidget {
  const EmployerItem(this.employer);

  final Employer employer;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Card(child:ListTile(title:Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(flex:4,child: Text(employer.name)),
        Expanded(child: CircleAvatar(
          radius: 14,
          backgroundColor: Colors.grey,
          child:Text(employer.count.toString(),style: TextStyle(fontSize: 12,color: Colors.white)),
        )),
        Expanded(child: CircleAvatar(
          radius: 14,
          backgroundColor: Colors.grey,
          child:Text(employer.count_interview.toString(),style: TextStyle(fontSize: 12,color: Colors.white)),
        )),
        Expanded(flex:1,child: GestureDetector(
          //onTap: _launchURL,
          child:Image.asset('assets/img/whatsapp.png',width:35,height:35,
        ))),
        Expanded(flex:1,child: IconButton(
            icon:Image.asset('assets/img/helperplace2.png',width:35,height:35),
            padding: const EdgeInsets.all(0.0),
                        onPressed: () {
              _navigateToNextScreen(context,employer.name);
            })),
        Expanded(flex:2,child: (employer.match!="")?Chip(
            label:Text(employer.match,style: TextStyle(fontSize: 12)),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            visualDensity: const VisualDensity(horizontal: 0.0, vertical: -4),
        ):const Text("")),
      ],
        ),
      subtitle: Text(employer.service+" | "+employer.N+" | "+employer.L+" | "+employer.S.toString()+" | "+employer.age.toString()+" | "+employer.D+" | "+employer.R+" | "+employer.H+" | "+employer.G),
    ),
        );

    throw UnimplementedError();
  }

  void _navigateToNextScreen(BuildContext context,employerName) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => NewScreen(employer)));
  }

  // _launchURL() async {
  //
  //   String url = "https://api.whatsapp.com/send?phone=${employer.mobile}";
  //
  //   if (await canLaunchUrlString(url)) {
  //     await launchUrlString(url);
  //   } else {
  //     throw 'Could not launch $url';
  //   }
  // }
}
