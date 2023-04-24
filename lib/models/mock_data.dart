import 'package:front_end/models/announcement_model.dart';
import 'package:front_end/models/assignment_model.dart';
import 'package:front_end/models/class_model.dart';
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

// AssignmentModel assignment = AssignmentModel.fromJson(assignmentJSON);

////////////////////////////////////////////////////////////////

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

// QuizModel quiz = QuizModel.fromJson(quizJSON);

////////////////////////////////////////////////////////////////

var announcementJSON = {
  "title": "Announcement 1",
  "description": "This is an announcement",
  "uploadDate": DateTime(2023, 04, 04, 20, 22),
  "postedBy": "Umair Azfar",
};
// AnnouncementModel announcement = AnnouncementModel.fromJson(announcementJSON);

////////////////////////////////////////////////////////////////
var classesJSON = [
  {
    "semester": {
      "semesterName": "Fall 2023",
      "startDate": DateTime(2023, 04, 04, 20, 22),
      "endDate": DateTime(2023, 04, 04, 20, 22),
    },
    "course": {
      "courseName": "Data Structures",
      "courseCode": "CS 201",
      "creditHours": 4,
      "courseDescription": "This is a course about data structures"
    },
    "teacher": {
      "fullName": "Umair Azfar",
      "email": "u.azfar@iba.edu.pk",
      "profilePicture": "example.com",
    },
    "syllabus": "This class is going to kill you",
    "student_list": [
      {
        "fullName": "Shaheer Ahmed",
        "ERP": "18635",
        "email": "s.ahmed_18635@khi.iba.edu.pk",
        "profilePicture": "example.com"
      },
      {
        "fullName": "Moosa Hashim",
        "ERP": "18642",
        "email": "m.hashim_18642@khi.iba.edu.pk",
        "profilePicture": "example.com"
      }
    ],
    "ta": [
      {
        "fullName": "Ebrahim Rakhman Gul",
        "ERP": "18651",
        "email": "e.gul_18651@khi.iba.edu.pk",
        "profilePicture": "example.com"
      },
    ],
    "channel": {
      "channel_id": "channel001",
      "threads": [
        {
          "thread_id": "thread001",
          "title": "Help with Assignment 001",
          "description": "I am stuck on problem 001 and 002",
          "datePosted": DateTime.now(),
          "postedBy": {
            "fullName": "Shaheer Ahmed",
            "ERP": "18635",
            "email": "s.ahmed_18635@khi.iba.edu.pk",
            "profilePicture": "example.com"
          }
        },
        {
          "thread_id": "thread002",
          "title": "Help with Reading 001",
          "description": "I can't understand the reading",
          "datePosted": DateTime.now(),
          "postedBy": {
            "fullName": "Moosa Hashim",
            "ERP": "18642",
            "email": "m.hashim_18642@khi.iba.edu.pk",
            "profilePicture": "example.com"
          }
        },
      ],
      "tags": ["General", "Question"],
      "upvotes": 12,
    },
    "announcements": [
      {
        "announcement_id": "announcement001",
        "title": "Announcement 1",
        "description": "This is an announcement",
        "datePosted": DateTime(2023, 04, 04, 20, 22),
        "postedBy": {
          "fullName": "Umair Azfar",
          "email": "u.azfar@iba.edu.pk",
          "profilePicture": "example.com",
        },
      },
      {
        "announcement_id": "announcement002",
        "title": "Announcement 2",
        "description": "This is an announcement",
        "datePosted": DateTime(2023, 04, 04, 20, 22),
        "postedBy": {
          "fullName": "Umair Azfar",
          "email": "u.azfar@iba.edu.pk",
          "profilePicture": "example.com",
        },
      },
    ],
    "quizzes": [
      {
        "quiz_id": "quiz001",
        "title": "Quiz 1",
        "description": "This is a quiz",
        "uploadDate": DateTime(2023, 04, 04, 20, 22),
        "dueDate": DateTime(2023, 04, 04, 20, 22),
        "startDate": DateTime(2023, 04, 04, 20, 22),
        "status": "open",
        "marks": 25,
        "questions": [
          {
            "questionDescription": "What is the capital of Pakistan?",
          },
          {
            "questionDescription": "What year was Pakistan founded?",
          }
        ]
      },
    ],
    "resources": [
      {
        "resource_id": "resource001",
        "fileName": "Resource 1",
        "fileType": "pdf",
        "dateUploaded": DateTime(2023, 04, 04, 20, 22),
        "fileSize": "1.2 MB",
      },
      {
        "resource_id": "resource002",
        "fileName": "Resource 2",
        "fileType": "png",
        "dateUploaded": DateTime(2023, 04, 04, 20, 22),
        "fileSize": "1.2 MB",
      },
    ],
    "assignments": [
      {
        "assignment_id": "assignment001",
        "title": "Assignment 1",
        "description": "This is an assignment",
        "uploadDate": DateTime(2023, 04, 04, 20, 22),
        "dueDate": DateTime(2023, 04, 04, 20, 22),
        "status": "open",
        "marks": 25,
      },
      {
        "assignment_id": "assignment002",
        "title": "Assignment 2",
        "description": "This is an assignment",
        "uploadDate": DateTime(2023, 04, 04, 20, 22),
        "dueDate": DateTime(2023, 04, 04, 20, 22),
        "status": "open",
        "marks": 25,
      },
    ]
  },
];
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

// ClassModel mockClass = ClassModel.fromJson(classJSON);

////////////////////////////////////////////////////////////////

var courseJSON = {
  "courseCode": "CS 201",
  "courseName": "Data Structures",
  "creditHours": 3,
  "courseDescription": "This is a course",
  "classes": []
};

var userJSON = {
  "fullName": "Shaheer Ahmed",
  "ERP": "18635",
  "email": "shaheer.ahmed12@gmail.com",
  "profilePic": "https://www.google.com",
  "phoneNumber": "03001234567",
  "CGPA": 3.16,
  "program": "BS CS",
};

var activeClasses = [
  {
    "semester": {
      "semesterName": "Fall 2023",
      "startDate": DateTime(2023, 04, 04, 20, 22),
      "endDate": DateTime(2023, 04, 04, 20, 22),
    },
    "course": {
      "courseName": "Data Structures",
      "courseCode": "CS 201",
      "creditHours": 4,
      "courseDescription": "This is a course about data structures"
    },
    "teacher": {
      "fullName": "Umair Azfar",
      "email": "u.azfar@iba.edu.pk",
      "profilePicture": "example.com",
    },
    "syllabus": "This class is going to kill you",
    "student_list": [
      {
        "fullName": "Shaheer Ahmed",
        "ERP": "18635",
        "email": "s.ahmed_18635@khi.iba.edu.pk",
        "profilePicture": "example.com"
      },
      {
        "fullName": "Moosa Hashim",
        "ERP": "18642",
        "email": "m.hashim_18642@khi.iba.edu.pk",
        "profilePicture": "example.com"
      }
    ],
    "ta": [
      {
        "fullName": "Ebrahim Rakhman Gul",
        "ERP": "18651",
        "email": "e.gul_18651@khi.iba.edu.pk",
        "profilePicture": "example.com"
      },
    ],
    "channel": {
      "channel_id": "channel001",
      "threads": [
        {
          "thread_id": "thread001",
          "title": "Help with Assignment 001",
          "description": "I am stuck on problem 001 and 002",
          "datePosted": DateTime.now(),
          "postedBy": {
            "fullName": "Shaheer Ahmed",
            "ERP": "18635",
            "email": "s.ahmed_18635@khi.iba.edu.pk",
            "profilePicture": "example.com"
          }
        },
        {
          "thread_id": "thread002",
          "title": "Help with Reading 001",
          "description": "I can't understand the reading",
          "datePosted": DateTime.now(),
          "postedBy": {
            "fullName": "Moosa Hashim",
            "ERP": "18642",
            "email": "m.hashim_18642@khi.iba.edu.pk",
            "profilePicture": "example.com"
          }
        },
      ],
      "tags": ["General", "Question"],
      "upvotes": 12,
    },
    "announcements": [
      {
        "announcement_id": "announcement001",
        "title": "Announcement 1",
        "description": "This is an announcement",
        "datePosted": DateTime(2023, 04, 04, 20, 22),
        "postedBy": {
          "fullName": "Umair Azfar",
          "email": "u.azfar@iba.edu.pk",
          "profilePicture": "example.com",
        },
      },
      {
        "announcement_id": "announcement002",
        "title": "Announcement 2",
        "description": "This is an announcement",
        "datePosted": DateTime(2023, 04, 04, 20, 22),
        "postedBy": {
          "fullName": "Umair Azfar",
          "email": "u.azfar@iba.edu.pk",
          "profilePicture": "example.com",
        },
      },
    ],
    "quizzes": [
      {
        "quiz_id": "quiz001",
        "title": "Quiz 1",
        "description": "This is a quiz",
        "uploadDate": DateTime(2023, 04, 04, 20, 22),
        "dueDate": DateTime(2023, 04, 04, 20, 22),
        "startDate": DateTime(2023, 04, 04, 20, 22),
        "status": "open",
        "marks": 25,
        "questions": [
          {
            "questionDescription": "What is the capital of Pakistan?",
          },
          {
            "questionDescription": "What year was Pakistan founded?",
          }
        ]
      },
    ],
    "resources": [
      {
        "resource_id": "resource001",
        "fileName": "Resource 1",
        "fileType": "pdf",
        "dateUploaded": DateTime(2023, 04, 04, 20, 22),
        "fileSize": "1.2 MB",
      },
      {
        "resource_id": "resource002",
        "fileName": "Resource 2",
        "fileType": "png",
        "dateUploaded": DateTime(2023, 04, 04, 20, 22),
        "fileSize": "1.2 MB",
      },
    ],
    "assignments": [
      {
        "assignment_id": "assignment001",
        "title": "Assignment 1",
        "description": "This is an assignment",
        "uploadDate": DateTime(2023, 04, 04, 20, 22),
        "dueDate": DateTime(2023, 04, 04, 20, 22),
        "status": "open",
        "marks": 25,
      },
      {
        "assignment_id": "assignment002",
        "title": "Assignment 2",
        "description": "This is an assignment",
        "uploadDate": DateTime(2023, 04, 04, 20, 22),
        "dueDate": DateTime(2023, 04, 04, 20, 22),
        "status": "open",
        "marks": 25,
      },
    ]
  },
  {
    "semester": {
      "semesterName": "Fall 2023",
      "startDate": DateTime(2023, 04, 04, 20, 22),
      "endDate": DateTime(2023, 04, 04, 20, 22),
    },
    "course": {
      "courseName": "Final Year Project",
      "courseCode": "CS 201",
      "creditHours": 4,
      "courseDescription": "This is a course about final year project"
    },
    "teacher": {
      "fullName": "Umair Azfar",
      "email": "u.azfar@iba.edu.pk",
      "profilePicture": "example.com",
    },
    "syllabus": "This class is going to kill you",
    "student_list": [
      {
        "fullName": "Shaheer Ahmed",
        "ERP": "18635",
        "email": "s.ahmed_18635@khi.iba.edu.pk",
        "profilePicture": "example.com"
      },
      {
        "fullName": "Moosa Hashim",
        "ERP": "18642",
        "email": "m.hashim_18642@khi.iba.edu.pk",
        "profilePicture": "example.com"
      }
    ],
    "ta": [
      {
        "fullName": "Saad Karim",
        "ERP": "18651",
        "email": "e.gul_18651@khi.iba.edu.pk",
        "profilePicture": "example.com"
      },
    ],
    "channel": {
      "channel_id": "channel001",
      "threads": [
        {
          "thread_id": "thread002",
          "title": "Help with Reading 001",
          "description": "I can't understand the reading",
          "datePosted": DateTime.now(),
          "postedBy": {
            "fullName": "Moosa Hashim",
            "ERP": "18642",
            "email": "m.hashim_18642@khi.iba.edu.pk",
            "profilePicture": "example.com"
          }
        },
      ],
      "tags": ["General", "Question"],
      "upvotes": 12,
    },
    "announcements": [
      {
        "announcement_id": "announcement001",
        "title": "Announcement 1",
        "description": "This is an announcement",
        "datePosted": DateTime(2023, 04, 04, 20, 22),
        "postedBy": {
          "fullName": "Umair Azfar",
          "email": "u.azfar@iba.edu.pk",
          "profilePicture": "example.com",
        },
      },
    ],
    "quizzes": [
      {
        "quiz_id": "quiz001",
        "title": "Quiz 1",
        "description": "This is a quiz",
        "uploadDate": DateTime(2023, 04, 04, 20, 22),
        "dueDate": DateTime(2023, 04, 04, 20, 22),
        "startDate": DateTime(2023, 04, 04, 20, 22),
        "status": "open",
        "marks": 25,
        "questions": [
          {
            "questionDescription": "What is the capital of Pakistan?",
          },
          {
            "questionDescription": "What year was Pakistan founded?",
          }
        ]
      },
    ],
    "resources": [
      {
        "resource_id": "resource002",
        "fileName": "Resource 2",
        "fileType": "png",
        "dateUploaded": DateTime(2023, 04, 04, 20, 22),
        "fileSize": "1.2 MB",
      },
    ],
    "assignments": [
      {
        "assignment_id": "assignment001",
        "title": "Assignment 1",
        "description": "This is an assignment",
        "uploadDate": DateTime(2023, 04, 04, 20, 22),
        "dueDate": DateTime(2023, 04, 04, 20, 22),
        "status": "open",
        "marks": 25,
      },
      {
        "assignment_id": "assignment002",
        "title": "Assignment 2",
        "description": "This is an assignment",
        "uploadDate": DateTime(2023, 04, 04, 20, 22),
        "dueDate": DateTime(2023, 04, 04, 20, 22),
        "status": "open",
        "marks": 25,
      },
    ]
  },
];
