// import 'package:front_end/entities/class_entity.dart';
// import 'package:front_end/models/announcement_model.dart';
// import 'package:front_end/models/assignment_model.dart';
// import 'package:front_end/models/class_model.dart';
// import 'package:front_end/models/quiz_model.dart';

// var assignmentJSON = {
//   "uploadDate": DateTime(2023, 04, 04, 20, 22),
//   "title": "Assignment 1",
//   "dueDate": DateTime(2023, 04, 04, 20, 22),
//   "resubmissionsAllowed": 1,
//   "status": "Open",
//   "resubmissionDeadline": DateTime(2023, 04, 04, 20, 22),
//   "description": "This is an assignment",
//   "teacherName": "Umair Azfar",
//   "attachments": [
//     {"name": "Assignment 1", "url": "https://www.google.com", "type": "pdf"}
//   ],
//   "marks": 100,
//   "submissions": [
//     {
//       "studentName": "Shaheer Ahmed",
//       "studentId": "18635",
//       "submissionDate": DateTime(2023, 04, 04, 20, 22),
//       "attachments": [
//         {"name": "Assignment 1", "url": "https://www.google.com", "type": "pdf"}
//       ],
//       "marks": 100,
//       "feedback": "Good work",
//       "status": "Submitted"
//     }
//   ]
// };

// AssignmentModel assignment = AssignmentModel.fromJson(assignmentJSON);

// ////////////////////////////////////////////////////////////////

// var quizJSON = {
//   "title": "Quiz 1",
//   "description": "This is a quiz",
//   "uploadDate": DateTime(2023, 04, 04, 20, 22),
//   "dueDate": DateTime(2023, 04, 04, 20, 22),
//   "startDate": DateTime(2023, 04, 04, 20, 22),
//   "status": "Open",
//   "resubmissionsAllowed": 1,
//   "resubmissionDeadline": DateTime(2023, 04, 04, 20, 22),
//   "marks": 100,
//   "attachments": [
//     {"name": "Quiz 1", "url": "https://www.google.com", "type": "pdf"}
//   ],
//   "submissions": [
//     {
//       "studentName": "Shaheer Ahmed",
//       "studentId": "18635",
//       "submissionDate": DateTime(2023, 04, 04, 20, 22),
//       "attachments": [
//         {"name": "Quiz 1", "url": "https://www.google.com", "type": "pdf"}
//       ],
//       "marks": 100,
//       "feedback": "Good work",
//       "status": "Submitted"
//     }
//   ],
//   "questions": [
//     {
//       "question": "What is the capital of Pakistan?",
//       "options": ["Islamabad", "Karachi", "Lahore", "Peshawar"],
//       "correctAnswer": "Islamabad",
//       "marks": 10
//     },
//   ]
// };

// QuizModel quiz = QuizModel.fromJson(quizJSON);

// ////////////////////////////////////////////////////////////////

// var announcementJSON = {
//   "title": "Announcement 1",
//   "description": "This is an announcement",
//   "uploadDate": DateTime(2023, 04, 04, 20, 22),
//   "postedBy": "Umair Azfar",
// };
// AnnouncementModel announcement = AnnouncementModel.fromJson(announcementJSON);

// ////////////////////////////////////////////////////////////////

// var classJSON = {
//   "semester": "Fall 2021",
//   "courseCode": "CS 201",
//   "courseName": "Data Structures",
//   "teacherName": "Umair Azfar",
//   "syllabus": "https://www.google.com",
//   "students": [
//     {
//       "name": "Shaheer Ahmed",
//       "id": "18635",
//     },
//   ],
//   "ta": [
//     {
//       "name": "Umair Azfar",
//       "id": "18635",
//     },
//   ],
//   "announcements": [
//     {
//       "title": "Announcement 1",
//       "description": "This is an announcement",
//       "uploadDate": DateTime(2023, 04, 04, 20, 22),
//       "postedBy": "Umair Azfar",
//     },
//   ],
//   "quizes": [
//     {
//       "title": "Quiz 1",
//       "description": "This is a quiz",
//       "uploadDate": DateTime(2023, 04, 04, 20, 22),
//       "dueDate": DateTime(2023, 04, 04, 20, 22),
//       "startDate": DateTime(2023, 04, 04, 20, 22),
//       "status": "Open",
//       "resubmissionsAllowed": 1,
//       "resubmissionDeadline": DateTime(2023, 04, 04, 20, 22),
//       "marks": 100,
//       "attachments": [
//         {"name": "Quiz 1", "url": "https://www.google.com", "type": "pdf"}
//       ],
//       "submissions": [
//         {
//           "studentName": "Shaheer Ahmed",
//           "studentId": "18635",
//           "submissionDate": DateTime(2023, 04, 04, 20, 22),
//           "attachments": [
//             {"name": "Quiz 1", "url": "https://www.google.com", "type": "pdf"}
//           ],
//           "marks": 100,
//           "feedback": "Good work",
//           "status": "Submitted"
//         }
//       ],
//       "questions": [
//         {
//           "question": "What is the capital of Pakistan?",
//           "options": ["Islamabad", "Karachi", "Lahore", "Peshawar"],
//           "correctAnswer": "Islamabad",
//           "marks": 10
//         },
//       ]
//     },
//   ],
//   "resources": [
//     {
//       "name": "Resource 1",
//       "url": "https://www.google.com",
//       "type": "pdf",
//       "uploadDate": DateTime(2023, 04, 04, 20, 22),
//       "uploadedBy": "Umair Azfar",
//     },
//   ],
//   "assignments": [
//     {
//       "title": "Assignment 1",
//       "dueDate": DateTime(2023, 04, 04, 20, 22),
//       "resubmissionsAllowed": 1,
//       "status": "Open",
//       "resubmissionDeadline": DateTime(2023, 04, 04, 20, 22),
//       "description": "This is an assignment",
//       "teacherName": "Umair Azfar",
//       "attachments": [
//         {"name": "Assignment 1", "url": "https://www.google.com", "type": "pdf"}
//       ],
//       "marks": 100,
//       "submissions": [
//         {
//           "studentName": "Shaheer Ahmed",
//           "studentId": "18635",
//           "submissionDate": DateTime(2023, 04, 04, 20, 22),
//           "attachments": [
//             {
//               "name": "Assignment 1",
//               "url": "https://www.google.com",
//               "type": "pdf"
//             }
//           ],
//           "marks": 100,
//           "feedback": "Good work",
//           "status": "Submitted"
//         }
//       ]
//     },
//   ],
//   "attendance": [
//     {
//       "studentName": "Shaheer Ahmed",
//       "studentId": "18635",
//       "attendance": [
//         {
//           "date": DateTime(2023, 04, 04, 20, 22),
//           "status": "Present",
//         },
//       ]
//     },
//   ]
// };

// // ClassModel mockClass = ClassModel.fromJson(classJSON);
// // ClassEntity myClassE = ClassEntity(
// //   semester: mockClass.semester,
// //   courseCode: mockClass.courseCode,
// //   courseName: mockClass.courseName,
// //   teacherName: mockClass.teacherName,
// //   syllabus: mockClass.syllabus,
// //   students: mockClass.students,
// //   ta: mockClass.ta,
// //   announcements: mockClass.announcements,
// //   quizes: mockClass.quizes,
// //   resources: mockClass.resources,
// //   assignments: mockClass.assignments,
// //   attendance: mockClass.attendance,
// // );
