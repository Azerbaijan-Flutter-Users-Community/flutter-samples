import 'package:learn_structure/core/models/user.dart';
import 'package:learn_structure/core/services/api.dart';
import 'package:learn_structure/core/services/authentication_service.dart';
import 'package:provider/provider.dart';

List<SingleChildCloneableWidget> providers = [
  ...independentServices,
  ...dependentServices,
  ...uiConsumableProviders,
];

List<SingleChildCloneableWidget> independentServices = [
  Provider.value(
    value: Api(),
  ),
];

List<SingleChildCloneableWidget> dependentServices = [
  ProxyProvider<Api, AuthenticationService>(
    builder: (context, api, service) => AuthenticationService(api: api),
  )
];

List<SingleChildCloneableWidget> uiConsumableProviders = [
  StreamProvider<User>(
    builder: (context) =>
        Provider.of<AuthenticationService>(context, listen: false).user,
  )
];
