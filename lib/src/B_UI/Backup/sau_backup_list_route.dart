import 'package:flutter/material.dart';
import 'package:your_lucky/src/B_UI/Backup/sau_base_route.dart';

class SAUBackupListRoute extends SAUBaseRoute {
  const SAUBackupListRoute({super.key, super.title, required super.store});
  @override
  SAUBackupListRouteState createState() {
    return SAUBackupListRouteState();
  }
}
class SAUBackupListRouteState<T extends SAUBackupListRoute> extends SAUBaseRouteState<SAUBackupListRoute> {
  @override
  Widget buildBody() {
    return const Text('空kong');
  }
}
