// GENERATED CODE - DO NOT MODIFY BY HAND

// Currently loading model from "JSON" which always encodes with double quotes
// ignore_for_file: prefer_single_quotes

import 'dart:typed_data';

import 'package:objectbox/objectbox.dart';
import 'package:objectbox/flatbuffers/flat_buffers.dart' as fb;
export 'package:objectbox/objectbox.dart'; // so that callers only have to import this file
import 'package:objectbox/internal.dart';

import 'model/contact_model.dart'; // generated code can access "internal" functionality


ModelDefinition getObjectBoxModel() {
  final model = ModelInfo.fromMap({
    "entities": [
      {
        "id": "1:5610599817304566832",
        "lastPropertyId": "3:9073858309807067231",
        "name": "ContactModel",
        "properties": [
          {"id": "1:5687740588200089885", "name": "id", "type": 6, "flags": 1},
          {"id": "2:4619961722547692663", "name": "name", "type": 9},
          {"id": "3:9073858309807067231", "name": "email", "type": 9}
        ],
        "relations": [],
        "backlinks": []
      }
    ],
    "lastEntityId": "1:5610599817304566832",
    "lastIndexId": "0:0",
    "lastRelationId": "0:0",
    "lastSequenceId": "0:0",
    "modelVersion": 5
  }, check: false);

  final bindings = <Type, EntityDefinition>{};
  bindings[ContactModel] = EntityDefinition<ContactModel>(
      model: model.getEntityByUid(5610599817304566832),
      toOneRelations: (ContactModel object) => [],
      toManyRelations: (ContactModel object) => {},
      getId: (ContactModel object) => object.id,
      setId: (ContactModel object, int id) {
        object.id = id;
      },
      objectToFB: (ContactModel object, fb.Builder fbb) {
        final offsetname =
            object.name == null ? null : fbb.writeString(object.name);
        final offsetemail =
            object.email == null ? null : fbb.writeString(object.email);
        fbb.startTable();
        fbb.addInt64(0, object.id ?? 0);
        fbb.addOffset(1, offsetname);
        fbb.addOffset(2, offsetemail);
        fbb.finish(fbb.endTable());
        return object.id ?? 0;
      },
      objectFromFB: (Store store, Uint8List fbData) {
        final buffer = fb.BufferContext.fromBytes(fbData);
        final rootOffset = buffer.derefObject(0);

        final object = ContactModel();
        object.id = fb.Int64Reader().vTableGet(buffer, rootOffset, 4);
        object.name = fb.StringReader().vTableGet(buffer, rootOffset, 6);
        object.email = fb.StringReader().vTableGet(buffer, rootOffset, 8);
        return object;
      });

  return ModelDefinition(model, bindings);
}

// ignore: camel_case_types
class ContactModel_ {
  static final id =
      QueryIntegerProperty(entityId: 1, propertyId: 1, obxType: 6);
  static final name =
      QueryStringProperty(entityId: 1, propertyId: 2, obxType: 9);
  static final email =
      QueryStringProperty(entityId: 1, propertyId: 3, obxType: 9);
}
