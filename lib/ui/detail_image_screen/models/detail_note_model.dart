import 'package:get/get.dart';
import 'detail_note_item_model.dart';

/// This class defines the variables used in the [detail_note_screen],
/// and is typically used to hold data that is passed between different parts of the application.
class DetailNoteModel {
  Rx<List<DetailNoteItemModel>> detailNoteItemList =
      Rx(List.generate(4, (index) => DetailNoteItemModel()));
}
