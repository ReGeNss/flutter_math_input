abstract class MathConstruction {}

abstract class SimpleMathConstuction extends MathConstruction{
  List<String> get katexExp;
}

abstract class GroopMathConstruction extends MathConstruction{
  List<String> get katexExp;
  List<int> get fieldsLocation;
} 