import 'math_construction.dart';

class FracConstuction extends GroopMathConstruction{
  @override
  List<int> get fieldsLocation => [0, 2];
  
  @override
  List<String> get katexExp => ['\\frac{', '}{', '}'];
}