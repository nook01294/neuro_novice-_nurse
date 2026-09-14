import '../models/quiz_question.dart';

/// Question bank for the Quiz Test feature: Glasgow Coma Scale (GCS)
/// scoring scenarios. Source: Quiz Test 13.9.69.pdf.
class QuizData {
  QuizData._();

  static const String title = 'Quiz Test : Glasgow Coma Scale (GCS)';

  static const String instructions =
      'อ่านสถานการณ์ในแต่ละข้อ แล้วเลือกคำตอบที่บันทึกคะแนน Glasgow Coma Scale '
      'ทั้ง 3 ด้านได้ถูกต้องที่สุด ได้แก่ E (Eye Opening), V (Verbal Response) '
      'และ M (Motor Response) พร้อมคะแนนรวมและระดับความรุนแรง';

  static const String severityCriteria =
      'เกณฑ์ระดับความรุนแรงที่ใช้ในชุดนี้: Mild = GCS 13–15 | '
      'Moderate = GCS 9–12 | Severe = GCS 3–8';

  static final List<QuizQuestion> _all = [
    const QuizQuestion(
      scenario:
          'ผู้ป่วยชายอายุ 24 ปี ประสบอุบัติเหตุรถจักรยานยนต์ ผู้ป่วยลืมตาได้เอง '
          'สามารถบอกชื่อ สถานที่ และวันเวลาได้ถูกต้อง เมื่อพยาบาลสั่งให้ยกแขนขวา '
          'ผู้ป่วยสามารถทำตามคำสั่งได้',
      options: [
        QuizOption(
          choiceText: 'E4V5M6 = 15, Mild',
          isCorrect: true,
          explanation:
              'E4 เพราะลืมตาได้เอง, V5 เพราะรู้บุคคล สถานที่ และเวลา, '
              'M6 เพราะทำตามคำสั่งได้ จึงรวม 15 คะแนน = Mild',
        ),
        QuizOption(
          choiceText: 'E3V5M6 = 14, Mild',
          isCorrect: false,
          explanation:
              'E3 ต้องลืมตาเมื่อได้ยินเสียงเรียก แต่โจทย์ระบุว่าลืมตาได้เอง '
              'จึงต้องเป็น E4',
        ),
        QuizOption(
          choiceText: 'E4V4M6 = 14, Mild',
          isCorrect: false,
          explanation:
              'V4 ใช้เมื่อสนทนาได้แต่สับสน แต่ผู้ป่วยตอบชื่อ สถานที่ '
              'และวันเวลาได้ถูกต้อง จึงเป็น V5',
        ),
        QuizOption(
          choiceText: 'E4V5M5 = 14, Mild',
          isCorrect: false,
          explanation:
              'M5 คือการ Localising ต่อสิ่งกระตุ้น ส่วนผู้ป่วยรายนี้ทำตามคำสั่งได้ '
              'จึงเป็น M6',
        ),
      ],
    ),
    const QuizQuestion(
      scenario:
          'ผู้ป่วยหญิงหลังหกล้ม นอนหลับตาอยู่ เมื่อพยาบาลเรียกชื่อจึงลืมตา '
          'ผู้ป่วยพูดคุยเป็นประโยค แต่ตอบว่าวันนี้เป็นวันจันทร์ทั้งที่เป็นวันศุกร์ '
          'และเข้าใจผิดว่าตนเองอยู่ที่บ้าน เมื่อสั่งให้กำมือ ผู้ป่วยสามารถทำตามได้',
      options: [
        QuizOption(
          choiceText: 'E3V5M6 = 14, Mild',
          isCorrect: false,
          explanation: 'V5 ต้อง orientated ถูกต้อง แต่รายนี้สับสนเรื่องวันและสถานที่',
        ),
        QuizOption(
          choiceText: 'E4V4M6 = 14, Mild',
          isCorrect: false,
          explanation: 'E4 ต้องลืมตาได้เอง แต่รายนี้ลืมตาหลังเรียกชื่อ',
        ),
        QuizOption(
          choiceText: 'E3V4M6 = 13, Mild',
          isCorrect: true,
          explanation:
              'E3 ลืมตาต่อเสียง, V4 สนทนาเป็นประโยคได้แต่สับสนเรื่องเวลา/สถานที่, '
              'M6 ทำตามคำสั่ง รวม 13 = Mild',
        ),
        QuizOption(
          choiceText: 'E3V3M6 = 12, Moderate',
          isCorrect: false,
          explanation:
              'V3 คือพูดเป็นคำ ๆ แต่ไม่สามารถสนทนาเป็นประโยคได้ ขณะที่รายนี้สนทนาเป็นประโยคได้ '
              'จึงเป็น V4',
        ),
      ],
    ),
    const QuizQuestion(
      scenario:
          'ผู้ป่วย TBI ไม่ลืมตาเมื่อเรียก แต่ลืมตาเมื่อได้รับการกระตุ้นด้วยแรงกด '
          'ผู้ป่วยพูดว่า "บ้าน...รถ...ไป..." เป็นคำที่ฟังเข้าใจได้ แต่ไม่สามารถสนทนาเป็นประโยค '
          'เมื่อกระตุ้นด้วยแรงกด ผู้ป่วยใช้มือขึ้นมาหาตำแหน่งที่กระตุ้นและพยายามเอามือผู้ตรวจออก',
      options: [
        QuizOption(
          choiceText: 'E2V2M5 = 9, Moderate',
          isCorrect: false,
          explanation: 'V2 เป็นเพียงเสียงที่ไม่เป็นคำ แต่โจทย์มีคำพูดที่ฟังเข้าใจได้ จึงเป็น V3',
        ),
        QuizOption(
          choiceText: 'E2V3M5 = 10, Moderate',
          isCorrect: true,
          explanation:
              'E2 ลืมตาต่อแรงกด, V3 พูดเป็นคำที่เข้าใจได้, M5 Localising '
              'เพราะยกมือมาหาตำแหน่งกระตุ้น รวม 10 = Moderate',
        ),
        QuizOption(
          choiceText: 'E3V3M5 = 11, Moderate',
          isCorrect: false,
          explanation: 'E3 ต้องลืมตาต่อเสียง แต่ผู้ป่วยไม่ลืมตาเมื่อเรียก',
        ),
        QuizOption(
          choiceText: 'E2V3M4 = 9, Moderate',
          isCorrect: false,
          explanation:
              'M4 เป็นการดึงหนีจากสิ่งกระตุ้นเท่านั้น แต่รายนี้หาตำแหน่งและพยายามเอาสิ่งกระตุ้นออก '
              'จึงเป็น M5',
        ),
      ],
    ),
    const QuizQuestion(
      scenario:
          'ผู้ป่วยหลังอุบัติเหตุศีรษะไม่ลืมตาเมื่อเรียก แต่ลืมตาเมื่อกระตุ้นด้วยแรงกด '
          'ผู้ป่วยส่งเสียงคราง "อือ...อา..." แต่ไม่สามารถพูดเป็นคำได้ เมื่อกระตุ้น '
          'ผู้ป่วยดึงแขนออกจากสิ่งกระตุ้น โดยไม่ได้ยกมือมาหาตำแหน่งที่กระตุ้น',
      options: [
        QuizOption(
          choiceText: 'E2V2M4 = 8, Severe',
          isCorrect: true,
          explanation:
              'E2 ลืมตาต่อแรงกด, V2 มีเสียงแต่ไม่เป็นคำ, M4 ดึงหนี/Normal flexion '
              'รวม 8 = Severe',
        ),
        QuizOption(
          choiceText: 'E2V3M4 = 9, Moderate',
          isCorrect: false,
          explanation: 'V3 ต้องมีคำพูดที่ฟังเข้าใจได้ แต่รายนี้มีเพียงเสียงคราง',
        ),
        QuizOption(
          choiceText: 'E2V2M5 = 9, Moderate',
          isCorrect: false,
          explanation:
              'M5 ต้อง Localise โดยเคลื่อนมือเข้าหาตำแหน่งกระตุ้นเพื่อเอา stimulus ออก '
              'แต่รายนี้เพียงดึงหนี',
        ),
        QuizOption(
          choiceText: 'E3V2M4 = 9, Moderate',
          isCorrect: false,
          explanation: 'E3 ต้องลืมตาต่อเสียง แต่รายนี้ไม่ลืมตาเมื่อเรียก',
        ),
      ],
    ),
    const QuizQuestion(
      scenario:
          'ผู้ป่วยชายหลังได้รับบาดเจ็บที่ศีรษะ ไม่ลืมตาทั้งเมื่อเรียกและเมื่อกระตุ้นด้วยแรงกด '
          'ผู้ป่วยส่งเสียงครางแต่ไม่สามารถพูดเป็นคำ เมื่อกระตุ้น '
          'พบว่าแขนทั้งสองข้างงอเข้าหาลำตัวอย่างผิดปกติ',
      options: [
        QuizOption(
          choiceText: 'E1V3M3 = 7, Severe',
          isCorrect: false,
          explanation: 'V3 ต้องพูดเป็นคำที่เข้าใจได้ แต่รายนี้มีเพียงเสียงคราง จึงเป็น V2',
        ),
        QuizOption(
          choiceText: 'E1V2M4 = 7, Severe',
          isCorrect: false,
          explanation: 'M4 คือการดึงหนีแบบ Normal flexion แต่โจทย์เป็นการงอผิดปกติ จึงเป็น M3',
        ),
        QuizOption(
          choiceText: 'E2V2M3 = 7, Severe',
          isCorrect: false,
          explanation: 'E2 ต้องลืมตาต่อแรงกด แต่รายนี้ไม่ลืมตาแม้ได้รับการกระตุ้น',
        ),
        QuizOption(
          choiceText: 'E1V2M3 = 6, Severe',
          isCorrect: true,
          explanation: 'E1 ไม่ลืมตา, V2 มีเสียงแต่ไม่เป็นคำ, M3 Abnormal flexion รวม 6 = Severe',
        ),
      ],
    ),
    const QuizQuestion(
      scenario:
          'ผู้ป่วย TBI ไม่ลืมตาต่อเสียงหรือแรงกด ไม่มีเสียงพูดหรือเสียงคราง '
          'เมื่อกระตุ้นด้วยแรงกด พบว่าแขนทั้งสองข้างเหยียดออกผิดปกติ',
      options: [
        QuizOption(
          choiceText: 'E1V1M2 = 4, Severe',
          isCorrect: true,
          explanation: 'E1 ไม่ลืมตา, V1 ไม่มี Verbal response, M2 Extension response รวม 4 = Severe',
        ),
        QuizOption(
          choiceText: 'E1V1M3 = 5, Severe',
          isCorrect: false,
          explanation: 'M3 คือ Abnormal flexion แต่โจทย์เป็นการเหยียดผิดปกติ จึงเป็น M2',
        ),
        QuizOption(
          choiceText: 'E1V2M2 = 5, Severe',
          isCorrect: false,
          explanation: 'V2 ต้องมีเสียงตอบสนอง แต่โจทย์ระบุว่าไม่มีเสียงพูดหรือเสียงคราง',
        ),
        QuizOption(
          choiceText: 'E2V1M2 = 5, Severe',
          isCorrect: false,
          explanation: 'E2 ต้องลืมตาต่อแรงกด แต่ผู้ป่วยรายนี้ไม่ลืมตา',
        ),
      ],
    ),
    const QuizQuestion(
      scenario:
          'ผู้ป่วยหลังผ่าตัดสมอง ลืมตาได้เอง พูดคุยเป็นประโยค แต่ตอบว่าอยู่ที่บ้านทั้งที่อยู่โรงพยาบาล '
          'ผู้ป่วยไม่ทำตามคำสั่งให้ยกแขน เมื่อกระตุ้นด้วยแรงกด ผู้ป่วยเอามือมาปัดสิ่งกระตุ้นทันที',
      options: [
        QuizOption(
          choiceText: 'E4V5M4 = 13, Mild',
          isCorrect: false,
          explanation: 'V5 ต้องตอบ orientation ได้ถูกต้อง แต่ผู้ป่วยเข้าใจผิดเรื่องสถานที่ จึงเป็น V4',
        ),
        QuizOption(
          choiceText: 'E4V4M5 = 13, Mild',
          isCorrect: true,
          explanation: 'E4 ลืมตาเอง, V4 สนทนาได้แต่สับสน, M5 Localising ต่อ stimulus รวม 13 = Mild',
        ),
        QuizOption(
          choiceText: 'E4V4M4 = 12, Moderate',
          isCorrect: false,
          explanation:
              'ผู้ป่วยเอามือมาปัดสิ่งกระตุ้น แสดงถึงการ Localising pain = M5 ไม่ใช่ M4 '
              'ซึ่ง M4 เป็นเพียงการดึงแขนหนีจากสิ่งกระตุ้น',
        ),
        QuizOption(
          choiceText: 'E3V4M4 = 11, Moderate',
          isCorrect: false,
          explanation: 'E3 คือการลืมตาต่อเสียง แต่รายนี้ลืมตาได้เอง จึงเป็น E4',
        ),
      ],
    ),
    const QuizQuestion(
      scenario:
          'ผู้ป่วย TBI ลืมตาเมื่อเรียกชื่อ พูดเป็นคำที่ฟังเข้าใจได้เป็นบางคำแต่ไม่สามารถสนทนาเป็นประโยค '
          'เมื่อกระตุ้นด้วยแรงกด แขนขวายกขึ้นมาพยายามปัดมือผู้ตรวจออกจากตำแหน่งกระตุ้น '
          'ส่วนแขนซ้ายเพียงดึงหนี',
      options: [
        QuizOption(
          choiceText: 'E3V4M5 = 12, Moderate',
          isCorrect: false,
          explanation: 'V4 ต้องสามารถสนทนาเป็นประโยคได้แต่สับสน แต่รายนี้พูดได้เพียงเป็นคำ จึงเป็น V3',
        ),
        QuizOption(
          choiceText: 'E3V3M4 = 10, Moderate',
          isCorrect: false,
          explanation:
              'เลือก M4 จากแขนซ้าย ทั้งที่การให้คะแนน GCS ใช้ best motor response '
              'ซึ่งแขนขวาเป็น M5',
        ),
        QuizOption(
          choiceText: 'E3V3M5 = 11, Moderate',
          isCorrect: true,
          explanation:
              'E3 ลืมตาต่อเสียง, V3 พูดเป็นคำ, Motor ใช้ best motor response '
              'จึงเป็น M5 จากแขนขวาที่ Localising รวม 11 = Moderate',
        ),
        QuizOption(
          choiceText: 'E2V3M5 = 10, Moderate',
          isCorrect: false,
          explanation: 'E2 ต้องลืมตาต่อแรงกด แต่ผู้ป่วยลืมตาเมื่อเรียกชื่อ จึงเป็น E3',
        ),
      ],
    ),
    const QuizQuestion(
      scenario:
          'ผู้ป่วย intracranial hemorrhage ไม่ลืมตาเมื่อเรียก แต่ลืมตาเมื่อกระตุ้นด้วยแรงกด '
          'ผู้ป่วยพูดคุยเป็นประโยคแต่สับสนเรื่องวันและสถานที่ ไม่สามารถทำตามคำสั่ง '
          'เมื่อกระตุ้น ผู้ป่วยยกมือขึ้นมาหาตำแหน่งกระตุ้นและพยายามผลักมือผู้ตรวจออก',
      options: [
        QuizOption(
          choiceText: 'E2V4M4 = 10, Moderate',
          isCorrect: false,
          explanation: 'M4 คือดึงหนี แต่รายนี้หาตำแหน่ง stimulus และพยายามเอาออก จึงเป็น M5',
        ),
        QuizOption(
          choiceText: 'E2V3M5 = 10, Moderate',
          isCorrect: false,
          explanation: 'V3 ใช้เมื่อพูดเป็นคำแต่ไม่สนทนาเป็นประโยค ขณะที่รายนี้พูดเป็นประโยคได้ จึงเป็น V4',
        ),
        QuizOption(
          choiceText: 'E3V4M5 = 12, Moderate',
          isCorrect: false,
          explanation: 'E3 ต้องลืมตาต่อเสียง แต่รายนี้ไม่ลืมตาเมื่อเรียก',
        ),
        QuizOption(
          choiceText: 'E2V4M5 = 11, Moderate',
          isCorrect: true,
          explanation: 'E2 ลืมตาต่อแรงกด, V4 สนทนาเป็นประโยคแต่สับสน, M5 Localising รวม 11 = Moderate',
        ),
      ],
    ),
    const QuizQuestion(
      scenario:
          'ผู้ป่วยชาย 30 ปี Severe TBI ไม่ลืมตาต่อเสียงหรือแรงกด ไม่มีการพูดหรือส่งเสียง '
          'เมื่อกระตุ้นด้วยแรงกดอย่างเหมาะสม ไม่พบการเคลื่อนไหวของแขนหรือขา '
          'และไม่มี motor response ต่อ stimulus',
      options: [
        QuizOption(
          choiceText: 'E1V1M1 = 3, Severe',
          isCorrect: true,
          explanation:
              'ไม่มี Eye response = E1, ไม่มี Verbal response = V1, '
              'ไม่มี Motor response = M1 รวม 3 = Severe',
        ),
        QuizOption(
          choiceText: 'E1V1M2 = 4, Severe',
          isCorrect: false,
          explanation: 'M2 ต้องมี Extension response แต่รายนี้ไม่มีการเคลื่อนไหวตอบสนอง',
        ),
        QuizOption(
          choiceText: 'E1V2M1 = 4, Severe',
          isCorrect: false,
          explanation: 'V2 ต้องมีเสียงตอบสนอง แต่โจทย์ระบุว่าไม่มีเสียง',
        ),
        QuizOption(
          choiceText: 'E2V1M1 = 4, Severe',
          isCorrect: false,
          explanation: 'E2 ต้องลืมตาต่อแรงกด แต่รายนี้ไม่ลืมตา',
        ),
      ],
    ),
  ];

  /// Set 1: questions 1–5. Set 2: questions 6–10.
  static List<QuizQuestion> setOne() => _all.sublist(0, 5);
  static List<QuizQuestion> setTwo() => _all.sublist(5, 10);
}
