import 'package:connectivity_test/internet_controller.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  late InternetController _internetController;

  @override
  void initState() {
    super.initState();
    _internetController = InternetController.instance;

    _internetController.init();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Connectivity Test',
      theme: ThemeData(
        primarySwatch: Colors.green,
        primaryColor: Colors.green,
        brightness: Brightness.dark,
      ),
      home: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: StreamBuilder<bool>(
                stream: _internetController.connectionStatusStream,
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data!) {
                    return const SizedBox();
                  } else {
                    return const SafeArea(
                      bottom: false,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('No internet connection'),
                          SizedBox(width: 10),
                          CircularProgressIndicator.adaptive(),
                        ],
                      ),
                    );
                  }
                },
              ),
            ),
            const SliverAppBar(
              title: Text('Connectivity Test'),
              floating: true,
              pinned: true,
              snap: true,
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return ListTile(
                    title: Text('Item $index'),
                  );
                },
                childCount: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
