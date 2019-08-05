class Global {
  static final String home = 'Home';
  static final String aastGan = 'Liver';
  static final String aastThan = 'Kidney';
  static final String aastLach = 'Spleen';

  static final String result = 'Result';

  static final String gan_opt1 = 'Hematoma:';
  static final String gan_opt2 = 'Laceration:';
  static final String gan_opt3 = 'Vascular:';
  static final String gan_opt4 = 'Multi injures:';

  static var gan_dropDown_opt1 = [none, 'subcapsular, <10% surface area (1)', 'subcapsular, 10-50% surface area (2)', 'intraparenchymal <10 cm diameter (3)', 'Both (2) & (3)', 'subcapsular, >50% surface area of ruptured subcapsular or parenchymal hematoma (4)', 'intraparenchymal >10 cm (5)', 'Both (4) & (5)', 'parenchymal disruption involving 25-75% hepatic lobe or involves 1-3 Couinaud segments (6)'];
  static var gan_dropDown_opt2 = [none, 'capsular tear, <1 cm  parenchymal depth', 'capsular tear 1-3 cm parenchymal depth, <10 cm length', 'capsular tear >3 cm parenchymal depth', 'parenchymal disruption involving 25-75% hepatic lobe or involves 1-3 Couinaud segments', 'parenchymal disruption involving >75% of hepatic lobe'];
  static var gan_dropDown_opt3 = [none, 'injury with active bleeding contained within liver parenchyma', 'injury with active bleeding breaching the liver parenchyma into the peritoneum', ' juxtahepatic venous injuries (retrohepatic vena cava / central major hepatic veins)'];
  static var gan_dropDown_opt4 = [none, 'YES'];

  static var incorrect_input = 'Input data not correct';
  static var none = 'none';
  static var gan_result = [incorrect_input, 'Grade 1', 'Grade 2', 'Grade 3', 'Grade 4', 'Grade 5'];

  static final String lach_opt1 = 'Hematoma:';
  static final String lach_opt2 = 'Laceration:';
  static final String lach_opt3 = 'Vascular:';

  static var lach_dropDown_opt1 = [none, '<10% surface area', '10% to 50% surface area', '>50% surface area or expanding; ruptured subcapsular'];
  static var lach_dropDown_opt2 = [none, '<1cm parenchymal depth', '1-3cm parenchymal depth that does not involve a trabecular vessel', '>3 cm parenchymal depth', 'Laceration involving segmental', 'Completely shattered spleen'];
  static var lach_dropDown_opt3 = [none, 'Hilar vascular injury with devascularizes spleen'];

  static var lach_result = [incorrect_input, 'Grade 1', 'Grade 2', 'Grade 3', 'Grade 4', 'Grade 5'];

  static final String than_opt1 = 'Contusion:';
  static final String than_opt2 = 'Hematoma:';
  static final String than_opt3 = 'Laceration:';
  static final String than_opt4 = 'Vascular:';

  static var than_dropDown_opt1 = [none, 'Microscopic or gross hematuria'];
  static var than_dropDown_opt2 = [none, 'nonexpanding without parenchymal laceration', 'Nonexpanding perirenal hematoma confirmed to renal retroperitoneum'];
  static var than_dropDown_opt3 = [none, '<1.0 cm parenchymal depth of renal cortex without urinary extravagation', '<1.0 cm parenchymal depth of renal cortex without collecting system rupture', 'Parenchymal laceration exteding through renal cortex, medulla, and collecting system', 'Completely shattered kidney'];
  static var than_dropDown_opt4 = [none, 'Main renal artery', 'Avulsion of renal hilum which devascularizes kidney'];

  static var than_result = [incorrect_input, 'Grade 1', 'Grade 2', 'Grade 3', 'Grade 4', 'Grade 5'];
}
