import '../index.dart';

class NaturalLog extends NamedFunction{
  NaturalLog(super.builder) : super(
    constructionKey: NaturalLogKey(),
    functionName: 'ln'
  );
}

class NaturalLogKey extends SimpleMathConstructionKey{
  @override
  List<String> get katexExp => ['\\ln ',''];
}

class LogBase10 extends NamedFunction{
  LogBase10(super.builder) : super(
    constructionKey: LogBase10Key(),
    functionName: 'lg'
  );
}

class LogBase10Key extends SimpleMathConstructionKey{
  @override
  List<String> get katexExp => ['\\lg ',''];
}

class LogBase2 extends NamedFunction{
  LogBase2(super.builder) : super(
    constructionKey: LogBase2Key(),
    functionName: 'log_2'
  );
}

class LogBase2Key extends SimpleMathConstructionKey{
  @override
  List<String> get katexExp => ['\\log_2 ',''];
}