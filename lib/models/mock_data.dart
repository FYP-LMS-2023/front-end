import 'package:front_end/models/assignment_model.dart';
import 'package:front_end/models/quiz_model.dart';

var assignmentJSON = {
  "uploadDate": DateTime(2023, 04, 04, 20, 22),
  "title": "Assignment 1",
  "dueDate": DateTime(2023, 04, 04, 20, 22),
  "resubmissionsAllowed": 1,
  "status": "Open",
  "resubmissionDeadline": DateTime(2023, 04, 04, 20, 22),
  "description": "This is an assignment",
  "teacherName": "Umair Azfar",
  "attachments": [
    {"name": "Assignment 1", "url": "https://www.google.com", "type": "pdf"}
  ],
  "marks": 100,
  "submissions": [
    {
      "studentName": "Shaheer Ahmed",
      "studentId": "18635",
      "submissionDate": DateTime(2023, 04, 04, 20, 22),
      "attachments": [
        {"name": "Assignment 1", "url": "https://www.google.com", "type": "pdf"}
      ],
      "marks": 100,
      "feedback": "Good work",
      "status": "Submitted"
    }
  ]
};
Assignment assignment = Assignment.fromJson(assignmentJSON);

var quizJSON = {
  "title": "Quiz 1",
  "description": "This is a quiz",
  "uploadDate": DateTime(2023, 04, 04, 20, 22),
  "dueDate": DateTime(2023, 04, 04, 20, 22),
  "startDate": DateTime(2023, 04, 04, 20, 22),
  "status": "Open",
  "resubmissionsAllowed": 1,
  "resubmissionDeadline": DateTime(2023, 04, 04, 20, 22),
  "marks": 100,
  "attachments": [
    {"name": "Quiz 1", "url": "https://www.google.com", "type": "pdf"}
  ],
  "submissions": [
    {
      "studentName": "Shaheer Ahmed",
      "studentId": "18635",
      "submissionDate": DateTime(2023, 04, 04, 20, 22),
      "attachments": [
        {"name": "Quiz 1", "url": "https://www.google.com", "type": "pdf"}
      ],
      "marks": 100,
      "feedback": "Good work",
      "status": "Submitted"
    }
  ],
  "questions": [
    {
      "question": "What is the capital of Pakistan?",
      "options": ["Islamabad", "Karachi", "Lahore", "Peshawar"],
      "correctAnswer": "Islamabad",
      "marks": 10
    },
  ]
};

Quiz quiz = Quiz.fromJson(quizJSON);
