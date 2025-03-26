import 'math_construction.dart';

class LimitConstruction extends GroopMathConstruction{
  @override
  List<String> get katexExp => ['\\lim_{','\\to ','} ',''];
  @override
  List<int> get fieldsLocation => [1, 3, 4];
}