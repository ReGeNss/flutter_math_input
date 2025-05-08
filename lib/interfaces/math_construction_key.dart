import 'package:flutter/material.dart';

abstract class MathConstructionKey {
  static MathConstructionKey getKey(ObjectKey key) {
    return key.value as MathConstructionKey;
  } 
  
  static ObjectKey setKey(MathConstructionKey construction){
    return ObjectKey(construction);
  }

  List<String> get katexExp;
}

abstract class SimpleMathConstructionKey extends MathConstructionKey{}

abstract class GroupMathConstructionKey extends MathConstructionKey{
  List<int> get fieldsLocation;
} 