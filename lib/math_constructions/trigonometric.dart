import 'math_construction.dart';

class CosConstruction extends SimpleMathConstuction {
  @override
  List<String> get katexExp => ['\\cos{', '}'];
}

class SinConstruction extends SimpleMathConstuction {
  @override
  List<String> get katexExp => ['\\sin{', '}'];
}

class TanConstruction extends SimpleMathConstuction {
  @override
  List<String> get katexExp => ['\\tan{', '}'];
}

class CotConstruction extends SimpleMathConstuction {
  @override
  List<String> get katexExp => ['\\cot{', '}'];
}

class ArccosConstruction extends SimpleMathConstuction {
  @override
  List<String> get katexExp => ['\\arccos{', '}'];
}

class ArcsinConstruction extends SimpleMathConstuction {
  @override
  List<String> get katexExp => ['\\arcsin{', '}'];
}

class ArctanConstruction extends SimpleMathConstuction {
  @override
  List<String> get katexExp => ['\\arctan{', '}'];
}

class ArccotConstruction extends SimpleMathConstuction {
  @override
  List<String> get katexExp => ['\\arccot{', '}'];
}

