import 'package:flutter/material.dart';
import 'package:memory_game/flip-card-game.dart';
import 'data.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('memory'),
      ),
      body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
                itemCount: 3,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=> _list[index].goto));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Stack(
                        children: [
                          Container(
                            height: 100,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: _list[index].primary,
                                borderRadius: BorderRadius.circular(30),
                                boxShadow: [
                                  BoxShadow(
                                      blurRadius: 4,
                                      spreadRadius: 0.5,
                                      color: Colors.black26,
                                      offset: Offset(3, 4)),
                                ]),
                          ),
                          Container(
                            height: 90,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: _list[index].secondary,
                                borderRadius: BorderRadius.circular(30),
                                boxShadow: [
                                  BoxShadow(
                                      blurRadius: 2,
                                      spreadRadius: 0.5,
                                      color: Colors.black26,
                                      offset: Offset(2, 2)),
                                ]),
                            child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                              _list[index].name,
                              style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 30,
                                      shadows: [
                                        Shadow(
                                          color: _list[index].primary,
                                          offset: Offset(2, 2),
                                          blurRadius: 0.5
                                        )
                                      ]),
                            ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: generateStar(_list[index].noStar),
                                    )
                                  ],
                                )),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
          )),
    );
  }
  List<Details> _list = [
    Details(name: 'EASY', primary: Colors.green, secondary: Colors.green[300], noStar: 1, goto: FlipCardGame(Level.EASY)),
    Details(name: 'MEDIUM', primary: Colors.orange, secondary: Colors.orange[300], noStar: 2, goto: FlipCardGame(Level.MEDIUM)),
    Details(name: 'HARD', primary: Colors.red, secondary: Colors.red[300], noStar: 3, goto: FlipCardGame(Level.HARD)),
  ];

  List<Widget> generateStar(int no){
    List<Widget> _icons = [];
    for(int i = 0; i < no ; i++){
      _icons.insert(i, Icon(Icons.star, color: Colors.yellow,));
    }
    return _icons;
  }
}

class Details {
  final String name;
  final Color primary;
  final Color? secondary;
  Widget goto;
  final int noStar;

  Details({required this.name, required this.primary, required this.secondary, required this.noStar, required this.goto,});
}
