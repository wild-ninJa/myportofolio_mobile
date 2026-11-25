import 'package:flutter/material.dart';
import 'package:myportofolio_mobile/screens/menu.dart';
import 'package:myportofolio_mobile/services/api_client.dart';
import 'package:myportofolio_mobile/services/auth_state.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp(apiClient: ApiClient()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  final ApiClient apiClient;

  @override
  Widget build(BuildContext context) {
    // MultiProvider wraps the app and injects a collection of Provider objects.
    // We usually use Provider object to pass one or more frequently reused objects such as API client or authentication state to the widgets in the tree.
    return MultiProvider(
      providers: [
        Provider.value(value: apiClient),
        // TODO: Register ChangeNotifierProvider creating AuthState(apiClient)
        ChangeNotifierProvider(create: (_) => AuthState(apiClient)),
      ],
      child: MaterialApp(
        title: 'Myportfolio',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.indigo,
            secondary: Colors.amber[700],
          ),
          useMaterial3: true,
        ),
        home: MyHomePage(),
      ),
    );
  }
}
