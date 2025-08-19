import 'dart:io';

StudentList studentlist = StudentList();

void main() {
  int? choice;
  do {
    print('Vui lòng nhập lựa chọn của bạn:');
    print('1. Nhập thông tin sinh viên');
    print('2. Hiển thị thông tin sinh viên');
    print('3. Tìm sinh viên có số điểm trung bình cao nhất');
    print('4. Thoát');
    choice = int.tryParse(stdin.readLineSync()!);
    switch (choice) {
      case 1:
        addStudent();
        break;
      case 2:
        displayStudents();
        break;
      case 3:
        findTopStudent();
        break;
      case 4:
        print('Thoát chương trình.');
        return;
      default:
    }
  } while (choice != 4);
}

void addStudent() {
  print('Nhập tên sinh viên:');
  String name = stdin.readLineSync()!;
  print('Nhập điểm Toán:');
  double toan = double.parse(stdin.readLineSync()!);
  print('Nhập điểm Lý:');
  double ly = double.parse(stdin.readLineSync()!);
  print('Nhập điểm Hóa:');
  double hoa = double.parse(stdin.readLineSync()!);

  Student student = Student(name, toan, ly, hoa);
  studentlist.addStudent(student);
}

void displayStudents() {
  if (studentlist.stu.isEmpty) {
    print('Danh sách sinh viên trống.');
  } else {
    for (int i = 0; i < studentlist.stu.length; i++) {
      print('Thông tin sinh viên ${i + 1}:');
      studentlist.getStudent(i).displayInfo();
      print('-------------------');
    }
  }
}

void findTopStudent() {
  if (studentlist.stu.isEmpty) {
    print('Danh sách sinh viên trống.');
    return;
  }
  Student topStudent = studentlist.stu[0];
  for (Student student in studentlist.stu) {
    if (student.getAverage() > topStudent.getAverage()) {
      topStudent = student;
    }
  }
  print('Sinh viên có điểm trung bình cao nhất:');
  topStudent.displayInfo();
}

class Student {
  String name;
  double toan;
  double ly;
  double hoa;

  Student(this.name, this.toan, this.ly, this.hoa);

  double getAverage() {
    return (toan + ly + hoa) / 3;
  }

  void displayInfo() {
    print('Ten: $name');
    print('Toan: $toan');
    print('Ly: $ly');
    print('Hoa: $hoa');
    print('Average: ${getAverage()}');
    print('Xếp loại:');
    if (getAverage() > 9) {
      print('Xuất sắc');
    } else if (getAverage() > 7 && getAverage() <= 9) {
      print('Giỏi');
    } else if (getAverage() > 5 && getAverage() <= 7) {
      print('Khá');
    } else {
      print('Kém');
    }
  }
}

class StudentList {
  List<Student> stu = [];

  void addStudent(Student Student) {
    stu.add(Student);
  }

  Student getStudent(int index) {
    return stu[index];
  }
}
