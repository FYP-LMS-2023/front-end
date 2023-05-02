class AnswerModel {
  String id;
  String answerDescription;

  AnswerModel({
    this.id = "<!id>",
    this.answerDescription = "<!answerDescription>",
  });

  AnswerModel copyWith({
    String? id,
    String? answerDescription,
  }) =>
      AnswerModel(
        id: id ?? this.id,
        answerDescription: answerDescription ?? this.answerDescription,
      );

  factory AnswerModel.fromJson(Map<String, dynamic> json) => AnswerModel(
        id: json["_id"] ?? "<!id>",
        answerDescription: json["answerDescription"] ?? "<!answerDescription>",
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "answerDescription": answerDescription,
        // "answerDescription": answerDescription,
      };
}
