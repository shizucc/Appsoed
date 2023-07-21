import 'package:flutter/material.dart';
// import 'package:ukm/livechat.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("UKM"),
        centerTitle: true,
      ),
      body: SafeArea(
          child: Column(
            children: <Widget>[
              Text("Rifki Romadhan"),
              ElevatedButton(
                  onPressed: () {
                    // Navigator.push(context,
                    //     MaterialPageRoute(builder: (context) => LiveChat()));
                    Navigator.pushNamed(context, "/livechat");
                  },
                  child: Text("Live Chat"))
            ],
          )),
    );
  }
}


// export default Home;
