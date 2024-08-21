import 'package:flutter/material.dart';
import 'package:your_lucky/src/A_Context/sac_context.dart';
import 'package:your_lucky/src/B_UI/Common/Route/Detail/sau_route_title_model.dart';


class SAUAppbarWidget extends StatefulWidget {
  final SAURouteTitleModel titleModel;
  const SAUAppbarWidget({super.key, required this.titleModel});

  @override
  SAUAppbarWidgetState createState() => SAUAppbarWidgetState();
}

class SAUAppbarWidgetState extends State<SAUAppbarWidget> {
  @override void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: backIconButton(context),
      title: Text(widget.titleModel.title),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            widget.titleModel.tapTitle(context,(){
              setState(() {});
            });
          },
          style: SACContext.textButtonStyle(),
          child: Text(widget.titleModel.actionTitle),
        ),
      ],
    );
  }

  IconButton backIconButton(BuildContext context) {
    return IconButton(
        icon: const Icon(Icons.arrow_back_ios),
        color: Colors.white,
        onPressed: () {
          Navigator.pop(context);
        });
  }
}

