// ignore_for_file: public_member_api_docs

import '../index.dart';

class NaturalLog extends NamedFunction{
  NaturalLog(super.builder) : super(
    constructionKey: NaturalLogKey(),
    functionName: 'ln',
  );
}

class NaturalLogKey extends SimpleMathConstructionKey{
  @override
  List<String> get katexExp => [r'\ln ',''];
}

class LogBase10 extends NamedFunction{
  LogBase10(super.builder) : super(
    constructionKey: LogBase10Key(),
    functionName: 'lg',
  );
}

class LogBase10Key extends SimpleMathConstructionKey{
  @override
  List<String> get katexExp => [r'\lg ',''];
}

class LogBase2 extends NamedFunction{
  LogBase2(super.builder) : super(
    constructionKey: LogBase2Key(),
    functionName: 'log₂',
  );
}

class LogBase2Key extends SimpleMathConstructionKey{
  @override
  List<String> get katexExp => [r'\log_2 ',''];
}
