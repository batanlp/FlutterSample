import 'package:doctor_check/models/global.dart';

class CalculateResult {
  int calculateGan(String opt1, String opt2, String opt3, String opt4) {
    // Grade 5
    if (opt4 ==  Global.gan_dropDown_opt4[0] && opt3 == Global.gan_dropDown_opt3[3] &&
        opt2 == Global.gan_dropDown_opt2[5]) {
      return 5;
    }
    // Grade 4
    if (opt4 ==  Global.gan_dropDown_opt4[0] && opt2 == Global.gan_dropDown_opt2[4] &&
        opt3 == Global.gan_dropDown_opt3[2]) {
      return 4;
    }

    // Grade 3
    if (opt3 == Global.gan_dropDown_opt3[1] &&
        opt2 == Global.gan_dropDown_opt2[3] &&
        (opt1 == Global.gan_dropDown_opt1[5] || opt1 == Global.gan_dropDown_opt1[6] || opt1 == Global.gan_dropDown_opt1[7])) {

      if (opt4 ==  Global.gan_dropDown_opt4[1]) {
        return 4;
      }
      return 3;
    }

    // Grade 2
    if (opt4 ==  Global.gan_dropDown_opt4[0] && opt2 == Global.gan_dropDown_opt2[2] &&
        (opt1 == Global.gan_dropDown_opt1[2] || opt1 == Global.gan_dropDown_opt1[3] || opt1 == Global.gan_dropDown_opt1[4])) {
      return 2;
    }

    // Grade 1
    if (opt4 ==  Global.gan_dropDown_opt4[0] &&
        opt2 == Global.gan_dropDown_opt2[1] &&
        opt1 == Global.gan_dropDown_opt1[1]) {
      return 1;
    }

    return 0;
  }

  int calculateThan(String opt1, String opt2, String opt3, String opt4) {
    // Grade 5
    if (opt4 == Global.than_dropDown_opt4[2] &&
        opt3 == Global.than_dropDown_opt3[4]) {
      return 5;
    }

    // Grade 4
    if (opt4 == Global.than_dropDown_opt4[1] &&
        opt3 == Global.than_dropDown_opt3[3]) {
      return 4;
    }

    // Grade 3
    if (opt3 == Global.than_dropDown_opt3[2]) {
      return 3;
    }

    // Grade 2
    if (opt3 == Global.than_dropDown_opt3[1] &&
        opt2 == Global.than_dropDown_opt2[2]) {
      return 2;
    }

    // Grade 1
    if (opt2 == Global.than_dropDown_opt2[1] &&
        opt1 == Global.than_dropDown_opt1[1]) {
      return 1;
    }

    return 0;
  }

  int calculateLach(String opt1, String opt2, String opt3) {
    // Grade 5
    if (opt3 == Global.lach_dropDown_opt3[1] &&
        opt2 == Global.lach_dropDown_opt2[5]) {
      return 5;
    }

    // Grade 4
    if (opt2 == Global.lach_dropDown_opt2[4]) {
      return 4;
    }

    // Grade 3
    if (opt2 == Global.lach_dropDown_opt2[3] &&
        opt1 == Global.lach_dropDown_opt1[3]) {
      return 3;
    }

    // Grade 2
    if (opt2 == Global.lach_dropDown_opt2[2] &&
        opt1 == Global.lach_dropDown_opt1[2]) {
      return 2;
    }

    // Grade 1
    if (opt2 == Global.lach_dropDown_opt2[1] &&
        opt1 == Global.lach_dropDown_opt1[1]) {
      return 1;
    }

    return 0;
  }
}
