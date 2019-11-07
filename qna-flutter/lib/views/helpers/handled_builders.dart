import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'alert.dart';

typedef Widget AsyncSnapshotWidgetBuilder<T>(BuildContext context, T data);

class HandledFutureBuilder<T> extends StatelessWidget {
  final Future<T> future;
  final AsyncSnapshotWidgetBuilder<T> builder;
  final Widget loadingWidget;

  const HandledFutureBuilder({
    Key key,
    @required this.future,
    @required this.builder,
    this.loadingWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<T>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return builder(context, snapshot.data);
        } else if (snapshot.hasError) {
          return HandledBuilderErrorWidget(snapshot.error);
        } else {
          return loadingWidget ?? HandledBuilderProgressWidget();
        }
      },
    );
  }
}

class HandledStreamBuilder<T> extends StatelessWidget {
  final Stream<T> stream;
  final AsyncSnapshotWidgetBuilder<T> builder;
  final Widget loadingWidget;

  const HandledStreamBuilder({
    Key key,
    @required this.stream,
    @required this.builder,
    this.loadingWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<T>(
      stream: stream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return builder(context, snapshot.data);
        } else if (snapshot.hasError) {
          return HandledBuilderErrorWidget(snapshot.error);
        } else {
          return loadingWidget ?? HandledBuilderProgressWidget();
        }
      },
    );
  }
}

class HandledBuilderProgressWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 24),
        child: SpinKitWave(
          size: 16,
          color: Theme.of(context).accentColor,
        ),
      ),
    );
  }
}

class HandledBuilderErrorWidget extends StatelessWidget {
  final Object error;

  const HandledBuilderErrorWidget(this.error);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: IconButton(
          iconSize: 56,
          onPressed: () {
            Alert.showAlertBox(context, error.toString());
          },
          icon: Icon(
            MdiIcons.bugOutline,
          ),
        ),
      ),
    );
  }
}
