using System.IO;
using System;

class Program {
  static void Main() {
    string studentFirstName;
    string studentLastName;
    DateTime studentBirthdate;
    string studentAddress1;
    string studentAddress2;
    string studentCity;
    string studentState;
    string studentZip;
    string studentCountry;
    string professorName;
    string degreeName;
    string degreeType;
    int degreeCredits;
    string programName;
    string programDegreesOffered;
    string departmentHead;
    string courseName;
    int courseCredits;
    int courseAssignments;
    studentFirstName = "Bob";
    studentLastName = "Smith";
    studentBirthdate = new DateTime(2000, 1, 18);
    studentAddress1 = "1 The Street";
    studentAddress2 = "Main Road";
    studentCity = "Boston";
    studentState = "Massachussetts";
    studentZip = "123456";
    studentCountry = "US";
    professorName = "Professor Clever";
    degreeName = "Bachelor of Science in Information Technology";
    degreeType = "Bachelor";
    degreeCredits = 360;
    programName = "Computer Science";
    programDegreesOffered = "Bachelor";
    departmentHead = "Mr Burns";
    courseName = "C#";
    courseCredits = 30;
    courseAssignments = 4;
    Console.WriteLine("A student called " + studentFirstName + " " + studentLastName + ", born on " + studentBirthdate.ToShortDateString() +
     " and living at " + studentAddress1 + ", " + studentAddress2 + ", " + studentCity + ", " + studentState + 
     ", " + studentZip + ", " + studentCountry + " is studying under " + professorName + " for a " + degreeName + " which is a " +
     degreeType + " degree with " + degreeCredits + " credits. The degree is part of the " + programName + " program which offers " +
     programDegreesOffered + " degrees and is headed by " + departmentHead + ".");
     
     Console.WriteLine(studentFirstName + "'s current course is '" + courseName + "', which is worth " + courseCredits + 
     " and has " + courseAssignments + " assignments.");
  }
}

