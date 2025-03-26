import 'math_construction.dart';

class UndefinitIntegralConstruction extends GroopMathConstruction{
  @override
  List<String> get katexExp => ['\\int ',' d',''];
  @override
  List<int> get fieldsLocation => [1, 3];
}