import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List _list = [];
  @override
  void initState() {
    for(int i = 1; i < 100; i++){
      _list.add("item $i");
    }
    setState(() {
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        //这个组件是用来下拉刷新使用的
        child: ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: _list.length,
            itemBuilder: (_,index){
              return AnimatedSwitcher(
                duration: Duration(seconds: 1),
                transitionBuilder: (child,animation){
                  return SlideTransition(
                    position: Tween<Offset>(
                        begin: Offset(index % 0.9 * 10,0.0),
                        end: Offset.zero
                    ).animate(animation),
                    child: child,
                  );
                },
                child: Dismissible(
                    key: UniqueKey(),
                    direction: DismissDirection.endToStart,
                    onDismissed: (direction){
                      _list.removeAt(index);
                      ScaffoldMessenger.of(context).
                      showSnackBar(SnackBar(content: Text(
                          "item $index dismissed remove!"
                      )));
                    },
                    resizeDuration: Duration(seconds: 1),
                    confirmDismiss: (direction) async{
                      await _alertDialog();
                      return delete;
                    },
                    child: AnimatedSwitcher(
                      duration: Duration(seconds: 1),
                      transitionBuilder: (child,animation){
                        return SlideTransition(
                          position: Tween<Offset>(
                              begin: Offset(0.25,0.0),
                              end: Offset.zero
                          ).animate(animation),
                          child: child,
                        );
                      },
                      child: Container(
                        key: UniqueKey(),
                        height: 50,
                        color: Colors.blue[index % 9 * 100],
                        child: ListTile(
                          title: Text(_list[index]),
                        ),
                      ),
                    )
                ),
              );
            }
        ),
      ),
    );
  }

  bool delete = false;
  Future<void> _alertDialog() async{
    await showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            title: Text("提醒"),
            content: Text("确定要删除吗"),
            actions: [
              ElevatedButton(onPressed: (){
                Navigator.of(context).pop();
                delete = true;
              }, child: Text("删除")),

              ElevatedButton(onPressed: (){
                Navigator.of(context).pop();
                delete = false;
              }, child: Text("取消"))
            ],
          );
        }
    );
  }
}