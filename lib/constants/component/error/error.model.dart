// ignore_for_file: public_member_api_docs, sort_constructors_first
class ErrorModel {
  String? title;
  String? content;
  Function? handleOk;
  Function? handleCancel;
  ErrorModel({
    this.title,
    this.content,
    this.handleOk,
    this.handleCancel,
  });
}
