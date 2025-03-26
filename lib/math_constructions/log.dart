import 'math_construction.dart';

class LogConstruction extends GroopMathConstruction{
  @override
  List<String> get katexExp => ['\\log_{','} ',''];
  @override
  List<int> get fieldsLocation => [1,2];
}

class NaturalLogConstruction extends SimpleMathConstuction{
  @override
  List<String> get katexExp => ['\\ln ',''];
}

class LogBase10Construction extends SimpleMathConstuction{
  @override
  List<String> get katexExp => ['\\lg ',''];
}

class LogBase2Construction extends SimpleMathConstuction{
  @override
  List<String> get katexExp => ['\\log_2 ',''];
}