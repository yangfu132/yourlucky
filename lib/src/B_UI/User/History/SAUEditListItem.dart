import 'package:flutter/material.dart';

typedef ClickDelete =Function(int position);//定义删除方法
typedef ClickChange =Function(int position);//定义修改方法

List<GlobalKey<SAUEditListItemState>> setEditListItemKey(int length){
  var list=<GlobalKey<SAUEditListItemState>>[];
  for (int i = 0; i < length; i++) {
    var key=GlobalKey<SAUEditListItemState>();
    list.add(key);
  }
  return list;
}

class SAUEditListItem extends StatefulWidget  {
  final GlobalKey<SAUEditListItemState> moveKey;
  final VoidCallback onStart;//开始滑动回调
  final ClickDelete delete;
  final ClickDelete change;

  final int position;//操作position

  final Widget child;//具体显示内容

  SAUEditListItem(this.position,this.child,{
    required this.moveKey,
    required this.onStart,
    required this.delete,
    required this.change}):super(key:moveKey);
  @override
  SAUEditListItemState createState() => SAUEditListItemState();
}

class SAUEditListItemState extends State<SAUEditListItem> with SingleTickerProviderStateMixin{


  // Animation<double> animation;
  late final AnimationController controller;

  double moveMaxLength=160;//滑动最大距离
  double start=0;

  bool isOpen=false;//是否是打开状态


  @override
  void initState() {
    super.initState();
//初始化动画，让item可以实现自动滑动
    controller = new AnimationController( lowerBound: 0,
        upperBound: moveMaxLength,duration: const Duration(milliseconds: 300), vsync: this)
      ..addListener((){
        start=controller.value;
        setState(() {});
      });

  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height:115,
        padding: EdgeInsets.only(left: 15,right: 15,top: 15),
        width:MediaQuery.of(context).size.width,
        child:GestureDetector(
          child:Stack(
            children: <Widget>[
              Positioned(
                right: -80+start,
                child:InkWell(
                  onTap: (){widget.change(widget.position); },
                  child:Container(
                    width: 80,
                    height:100,
                    alignment: Alignment.center,
                    color: Colors.grey,
                    child: Text("修改",style: TextStyle(color: Colors.white),),
                  ),
                ),
              ),
              Positioned(
                right: -160+start,
                child: InkWell(
                  onTap: (){widget.delete(widget.position); },
                  child: Container(
                    width: 80,
                    height:100,
                    alignment: Alignment.center,
                    color: Colors.red,
                    child: Text("删除",style: TextStyle(color: Colors.white)),
                  ),
                ),
              ),
              Positioned(
                  left: -start,
                  right:start,
                  child: widget.child
              ),
            ],
          ),
          onHorizontalDragDown: (DragDownDetails details){//滑动开始的时候关闭打开的item
            close();
            return widget.onStart();
          },
          onHorizontalDragUpdate: (DragUpdateDetails details){//滑动中更新滑动距离
            setState(() {
              start-=details.delta.dx;
              if (start<=0) {//限制最小滑动距离
                start=0;
              }

              if(start>=moveMaxLength){//限制最大滑动距离
                start=moveMaxLength;
              }
            });
          },
          onHorizontalDragEnd: (DragEndDetails details){
            controller.value=start;//滑动结束的时候给动画value赋值为当前值
            if (start==moveMaxLength) {
              isOpen = true; //滑动距离最大的时候即为打开状态
            } else if (start>moveMaxLength/2) {//滑动超过一般距离的时候，启动动画滑动到最大位置
              controller.animateTo(moveMaxLength);
              isOpen=true;
            }else if(start<=moveMaxLength/2){//往回滑动超过一般距离的时候，启动动画滑动到初始位置
              close();
            }
          },
        )
    );
  }
  void close(){
    controller.animateTo(0);
    isOpen=false;
  }
}