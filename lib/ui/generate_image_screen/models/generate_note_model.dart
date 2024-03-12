import 'package:get/get.dart';
import 'list_item_model.dart';
import 'listrectangleth_item_model.dart';
import 'generate_note_item_model.dart';

/// This class defines the variables used in the [generate_note_screen],
/// and is typically used to hold data that is passed between different parts of the application.
class GenerateNoteModel {
  Rx<List<ListItemModel>> listItemList =
      Rx(List.generate(5, (index) => ListItemModel()));

  Rx<List<ListrectanglethItemModel>> listrectanglethItemList =
      Rx(List.generate(3, (index) => ListrectanglethItemModel()));

  Rx<List<GenerateNoteItemModel>> generateNoteItemList =
      Rx(List.generate(6, (index) => GenerateNoteItemModel()));
}
