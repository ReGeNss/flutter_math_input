import '../index.dart';

class Cos extends NamedFunction{
  Cos(super.builder) : super(
    constructionKey: CosKey(),
    functionName: 'cos'
  );
}

class CosKey extends SimpleMathConstructionKey {
  @override
  List<String> get katexExp => ['\\cos{', '}'];
}


class Sin extends NamedFunction{
  Sin(super.builder) : super(
    constructionKey: SinKey(),
    functionName: 'sin'
  );
}

class SinKey extends SimpleMathConstructionKey {
  @override
  List<String> get katexExp => ['\\sin{', '}'];
}

class Tan extends NamedFunction{
  Tan(super.builder) : super(
    constructionKey: TanKey(),
    functionName: 'tan'
  );
}

class TanKey extends SimpleMathConstructionKey {
  @override
  List<String> get katexExp => ['\\tan{', '}'];
}

class Cot extends NamedFunction{
  Cot(super.builder) : super(
    constructionKey: CotKey(),
    functionName: 'cot'
  );
}

class CotKey extends SimpleMathConstructionKey {
  @override
  List<String> get katexExp => ['\\cot{', '}'];
}

class Arccos extends NamedFunction{
  Arccos(super.builder) : super(
    constructionKey: ArccosKey(),
    functionName: 'arccos'
  );
}

class ArccosKey extends SimpleMathConstructionKey {
  @override
  List<String> get katexExp => ['\\arccos{', '}'];
}

class Arcsin extends NamedFunction{
  Arcsin(super.builder) : super(
    constructionKey: ArcsinKey(),
    functionName: 'arcsin'
  );
}

class ArcsinKey extends SimpleMathConstructionKey {
  @override
  List<String> get katexExp => ['\\arcsin{', '}'];
}

class Arctan extends NamedFunction{
  Arctan(super.builder) : super(
    constructionKey: ArctanKey(),
    functionName: 'arctan'
  );
}

class ArctanKey extends SimpleMathConstructionKey {
  @override
  List<String> get katexExp => ['\\arctan{', '}'];
}

class Arccot extends NamedFunction{
  Arccot(super.builder) : super(
    constructionKey: ArccotKey(),
    functionName: 'arcctg'
  );
}

class ArccotKey extends SimpleMathConstructionKey {
  @override
  List<String> get katexExp => ['\\arccot{', '}'];
}

