///SelectionPopupModel is common model
///used for setting data into dropdowns
class SelectionPopupModel {
  int? id;
  String? title;
  dynamic value;
  bool isSelected;

  SelectionPopupModel({
    this.id,
    this.title,
    this.value,
    this.isSelected = false,
  });
}
