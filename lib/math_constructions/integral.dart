import 'math_construction.dart';

class IntegralConstruction extends GroopMathConstruction {
  @override
  List<String> get katexExp => ['\\int_{','}^{','} ',' d',''];

  @override
  List<int> get fieldsLocation => [1, 2, 3, 5];
}