﻿import 'package:yourlucky/src/D_Business/Base/SABBaseModel.dart';

class SABEarthBranchModel extends SABBaseModel {
  //属性注释：地支名
  // String? _earthName;

  // //属性注释：地支的六合关系
  // late final Map _mySixPairData = getSixPairDescription();
  //
  // //属性注释：地址的六冲关系
  // late final Map _myConflictData = getSixConflict();

  //属性注释：长生十二神
  late final Map myTwelveGoldData = twelveGold();

  // late final Map _earthTimeDictionary = earthTimeDictionary();
  //
  // late final Map _earthElement = earthElement();
  //
  // late final Map _earthDirection = earthDirection();
  //
  // late final Map _myStrongData = getSeasonStrong();
  //
  // late final Map? _earthSixPair = earthSixPair();

  //方法注释：判断两个地支之间的六合关系
  String sixPairDescription(String basicEarth, String otherEarth) {
    String result = "";

    String strKey = '$basicEarth$otherEarth';
    result = getSixPairDescription()[strKey];
    strKey = '$otherEarth$basicEarth';
    result = getSixPairDescription()[strKey];

    return result;
  }

  Map earthTimeDictionary() {
    return {
      "子": "23:00~01:00",
      "丑": "01:00~03:00",
      "寅": "03:00~05:00",
      "卯": "05:00~07:00",
      "辰": "07:00~09:00",
      "巳": "09:00~11:00",
      "午": "11:00~13:00",
      "未": "13:00~15:00",
      "申": "15:00~17:00",
      "酉": "17:00~19:00",
      "戌": "19:00~21:00",
      "亥": "21:00~23:00",
    };
  }

  Map earthElement() {
    return {
      "子": "水",
      "丑": "土",
      "寅": "木",
      "卯": "木",
      "辰": "土",
      "巳": "火",
      "午": "火",
      "未": "土",
      "申": "金",
      "酉": "金",
      "戌": "土",
      "亥": "水",
    };
  }

  Map earthDirection() {
    return {
      "子": "正北方",
      "丑": "东北方",
      "寅": "东北方",
      "卯": "正东方",
      "辰": "东南方",
      "巳": "东南方",
      "午": "正南方",
      "未": "西南方",
      "申": "西南方",
      "酉": "正西方",
      "戌": "西北方",
      "亥": "西北方",
    };
  }

  Map getSeasonStrong() {
    var tempStrongData = Map();
    {
      Map data = {
        "子": "旺",
        "丑": "余气",
        "寅": "休",
        "卯": "休",
        "辰": "死",
        "巳": "囚",
        "午": "囚",
        "未": "死",
        "申": "相",
        "酉": "相",
        "戌": "死",
        "亥": "旺"
      };
      tempStrongData["亥"] = data;
      tempStrongData["子"] = data;
    }

    {
      Map data = {
        "子": "囚",
        "丑": "旺",
        "寅": "死",
        "卯": "死",
        "辰": "旺",
        "巳": "相",
        "午": "相",
        "未": "旺",
        "申": "休",
        "酉": "休",
        "戌": "死",
        "亥": "囚"
      };

      tempStrongData["辰"] = data;
    }

    {
      Map data = {
        "子": "囚",
        "丑": "旺",
        "寅": "死",
        "卯": "死",
        "辰": "死",
        "巳": "相",
        "午": "相",
        "未": "旺",
        "申": "休",
        "酉": "休",
        "戌": "旺",
        "亥": "囚"
      };

      tempStrongData["戌"] = data;
    }

    {
      Map data = {
        "子": "囚",
        "丑": "旺",
        "寅": "死",
        "卯": "死",
        "辰": "旺",
        "巳": "相",
        "午": "相",
        "未": "死",
        "申": "休",
        "酉": "休",
        "戌": "旺",
        "亥": "囚"
      };

      tempStrongData["丑"] = data;
    }

    {
      Map data = {
        "子": "囚",
        "丑": "死",
        "寅": "死",
        "卯": "死",
        "辰": "旺",
        "巳": "相",
        "午": "相",
        "未": "旺",
        "申": "休",
        "酉": "休",
        "戌": "旺",
        "亥": "囚"
      };
      tempStrongData["未"] = data;
    }

    {
      Map data = {
        "子": "相",
        "丑": "囚",
        "寅": "旺",
        "卯": "旺",
        "辰": "余气",
        "巳": "休",
        "午": "休",
        "未": "囚",
        "申": "死",
        "酉": "死",
        "戌": "囚",
        "亥": "相"
      };
      tempStrongData["寅"] = data;
      tempStrongData["卯"] = data;
    }

    {
      Map data = {
        "子": "死",
        "丑": "休",
        "寅": "相",
        "卯": "相",
        "辰": "休",
        "巳": "旺",
        "午": "旺",
        "未": "余气",
        "申": "囚",
        "酉": "囚",
        "戌": "休",
        "亥": "死"
      };
      tempStrongData["巳"] = data;
      tempStrongData["午"] = data;
    }

    {
      Map data = {
        "子": "休",
        "丑": "相",
        "寅": "囚",
        "卯": "囚",
        "辰": "相",
        "巳": "死",
        "午": "死",
        "未": "相",
        "申": "旺",
        "酉": "旺",
        "戌": "余气",
        "亥": "休"
      };
      tempStrongData["申"] = data;
      tempStrongData["酉"] = data;
    }

    return tempStrongData;
  }

  //方法注释：地址的六合关系
  Map getSixPairDescription() {
    return {
      "子丑": "子丑合化土",
      "寅亥": "寅亥合化木",
      "卯戌": "卯戌合化火",
      "辰酉": "辰酉合化金",
      "巳申": "巳申合化水",
      "午未": "午未合化土"
    };
  }

  Map earthSixPair() {
    return {
      "子": "丑",
      "丑": "子",
      "寅": "亥",
      "亥": "寅",
      "卯": "戌",
      "戌": "卯",
      "辰": "酉",
      "酉": "辰",
      "巳": "申",
      "申": "巳",
      "午": "未",
      "未": "午"
    };
  }

  //方法注释：地址的六冲关系
  Map getSixConflict() {
    return {
      "子": "午",
      "丑": "未",
      "寅": "申",
      "卯": "酉",
      "辰": "戌",
      "巳": "亥",
      "午": "子",
      "未": "丑",
      "申": "寅",
      "酉": "卯",
      "戌": "辰",
      "亥": "巳"
    };
  }

  //方法注释：长生十二神
  Map twelveGold() {
    var tempTwelveGoldData = Map();
    //else cont.

    {
      Map data = {
        "亥": "长生",
        "子": "沐浴",
        "丑": "冠带",
        "寅": "临官",
        "卯": "帝旺",
        "辰": "衰",
        "巳": "病",
        "午": "死",
        "未": "墓",
        "申": "绝",
        "酉": "胎",
        "戌": "养"
      };
      tempTwelveGoldData["寅"] = data;
    }

    {
      Map data = {
        "寅": "长生",
        "卯": "沐浴",
        "辰": "冠带",
        "巳": "临官",
        "午": "帝旺",
        "未": "衰",
        "申": "病",
        "酉": "死",
        "戌": "墓",
        "亥": "绝",
        "子": "胎",
        "丑": "养"
      };
      tempTwelveGoldData["午"] = data;
      tempTwelveGoldData["辰"] = data;
      tempTwelveGoldData["戌"] = data;
    }

    {
      Map data = {
        "巳": "长生",
        "午": "沐浴",
        "未": "冠带",
        "申": "临官",
        "酉": "帝旺",
        "戌": "衰",
        "亥": "病",
        "子": "死",
        "丑": "墓",
        "寅": "绝",
        "卯": "胎",
        "辰": "养"
      };
      tempTwelveGoldData["申"] = data;
    }

    {
      Map data = {
        "申": "长生",
        "酉": "沐浴",
        "戌": "冠带",
        "亥": "临官",
        "子": "帝旺",
        "丑": "衰",
        "寅": "病",
        "卯": "死",
        "辰": "墓",
        "巳": "绝",
        "午": "胎",
        "未": "养"
      };
      tempTwelveGoldData["子"] = data;
    }

    {
      Map data = {
        "午": "长生",
        "巳": "沐浴",
        "辰": "冠带",
        "卯": "临官",
        "寅": "帝旺",
        "丑": "衰",
        "子": "病",
        "亥": "死",
        "戌": "墓",
        "酉": "绝",
        "申": "胎",
        "未": "养"
      };
      tempTwelveGoldData["卯"] = data;
    }

    {
      Map data = {
        "酉": "长生",
        "申": "沐浴",
        "未": "冠带",
        "午": "临官",
        "巳": "帝旺",
        "辰": "衰",
        "卯": "病",
        "寅": "死",
        "丑": "墓",
        "子": "绝",
        "亥": "胎",
        "戌": "养"
      };
      tempTwelveGoldData["巳"] = data;
      tempTwelveGoldData["丑"] = data;
      tempTwelveGoldData["未"] = data;
    }

    {
      Map data = {
        "子": "长生",
        "亥": "沐浴",
        "戌": "冠带",
        "酉": "临官",
        "申": "帝旺",
        "未": "衰",
        "午": "病",
        "巳": "死",
        "辰": "墓",
        "卯": "绝",
        "寅": "胎",
        "丑": "养"
      };
      tempTwelveGoldData["酉"] = data;
    }

    {
      Map data = {
        "卯": "长生",
        "寅": "沐浴",
        "丑": "冠带",
        "子": "临官",
        "亥": "帝旺",
        "戌": "衰",
        "酉": "病",
        "申": "死",
        "未": "墓",
        "午": "绝",
        "巳": "胎",
        "辰": "养"
      };
      tempTwelveGoldData["亥"] = data;
    }

    return tempTwelveGoldData;
  }

  //方法注释：地支类象
  String likeDescription(String earthName) {
    if ("子" == earthName) {
      return '''子象：五行属阳水，位居北方。\r\n\
        场所：主池塘、沟河，与水有关场所；\r\n\
        人物：在人主妇女、盗贼；为喜神时类象为少男、军警、公务员等吉祥人物；为忌神时类象为盗贼、土匪、少年犯等不吉祥人物。\r\n\
        人物肖像：强时为高黑、长脸；弱时为矮胖、国字脸。\r\n\
        动植物：主燕子、蝙蝠、蜗牛、地瓜、水萝卜、浮萍，老鼠。；\r\n\
        事情：遇吉神为聪明吉祥，遇凶神主淫佚。\r\n\
        环境：为喜神时表示为清澈的江河、水井、水地、水缸等。为忌神时类象为污臭之水、如臭水沟、下水道、臭水塘等。\r\n\
        人体：不论喜忌均可类象为排泄系统、生殖系统、体液、膀胱、尿道、***、***、月经、耳朵等。\r\n\
        疾病：类象为高血压、肾结石、性病、早泄等。\r\n\
        吉凶：喜则表示聪明，吉祥；忌时表示***、血光之灾，污秽不吉之事。\r\n\
        子象：水、冰、河流、泉水、井、流动、流转、车船、贸易、江湖、文墨、玄学、圆润、聪明、技能、淫邪；于人体为肾、耳、膀胱、泌尿、血液、精、腰、喉咙、耳朵；动物为：蝠、鼠、燕。''';
    } else if ("丑" == earthName) {
      return '''丑象：五行属阴土，位居东北方。\r\n\
        场所：主桑园、桥梁、宫殿、礼堂、宅兆。\r\n\
        人物：在人主朱紫、尊长、神佛；为喜时类象为朱紫、师长、神佛、父；为忌时类象为老妇、丑妇、死尸等。\r\n\
        人物肖像：强时类象为脸大、皮肤好；弱时类象为矮丑、皮肤粗糙。\r\n\
        人体：不论喜忌均可类象为脾脏、肚腹、子宫、阴茎、嘴唇。\r\n\
        动物：蟹、牛、龟、驴、骡子；\r\n\
        静物主锁匙、首饰、珍宝、斛斗、鞋类。\r\n\
        在事上遇吉神吉格主喜庆、迁官晋职；遇凶神凶格，主刑狱、词讼、口舌是非、离乡背井或疾病。\r\n\
        环境：为喜神时类象为菜园、桑园、桥梁、宫殿、礼堂等；为忌时类象为阴湿之地、污浊之地、坟地。\r\n\
        疾病：类象为感冒伤风、糖尿病。\r\n\
        吉凶：喜则升官、得奖、走好运等吉庆之事。忌则表示口舌、疾病、被吓等不吉祥之事。\r\n\
        丑象：寒土、湿土、泥、沼泽、堤坝、地下室、下水道、厕所、黑暗、隐蔽、矿井、煤炭、坟墓、牢狱、黑社会、私情、淫乱、玄学、抽象、银行、军营、厂矿、田园；于人体为腹、脾胃、肾、子宫、肌肉、肿块；动物为：蟹、牛、龟。''';
    } else if ("寅" == earthName) {
      return '''寅象：五行属阳木，位居东北方。\r\n\
        场所：主山林、桥梁；\r\n\
        人物：在人主丈夫、女婿、朱紫、清官、公门人；\r\n\
        人物肖像：强时类象为个子高、长方脸、脸色青白、眉毛粗浓；弱时类象为个子中等、脸形较小、眉毛稀少。为喜时类象为丈夫、女婿、朱紫、家长宾客；为忌时类象为贪官贪吏、不速之客、恶鬼、贱人等。\r\n\
        人体：不论喜忌均可类象为胆、胸、尾椎、毛发等。\r\n\
        动物：老虎、豹子、猫。\r\n\
        在物主文书、单据、发票、香炉、织机、财物、棺材；动物主老虎、豹子、猫。\r\n\
        在事上遇吉神主文书、财帛、信息，遇凶神为失财、疾病、官非。\r\n\
        环境：为喜神时类象为树木、公园、果园、盆景；为忌时类象为断木桥，木做水涧，阴森森的丛林。\r\n\
        疾病：四肢伤残、肝病、胆病。\r\n\
        吉凶：喜则类象为得财、好信息；凶则类象为疾病、口舌、破财 \r\n\
        寅象：树木、花木、木材、家俱、神龛、堂庙、会所、楼宇、组织、政府机关、文化场所、高雅、寺庙、山林；于人体为头、手、肢体、肝胆、毛发、指甲、掌、经络、脉、筋、神经；动物为：虎、豹、猫。''';
    } else if ("卯" == earthName) {
      return '''卯象：五行属阴木，位居东方。\r\n\
        场所：主大街、道路；\r\n\
        人物：人上主兄弟、姑娘、妇女、盗贼、手产业者；为喜时类象为兄弟、姑母；为忌时类象为老姑婆、丈母娘、小偷。\r\n\
        人物类象：强时类象为身高中等、脸较园、双眼皮；弱时类象为个子不高、脸青黑、眉毛稀少、脸长。\r\n\
        人体：不论喜忌均可类象为肝、筋骨、肘、神经、体毛、十指、腋下。\r\n\
        物品主船只、车辆、门窗；\r\n\
        动物：兔子、蛐蛐。\r\n\
        在事上见吉神主车辆船只平安无事，遇凶神则官司口舌，或车船遇险。\r\n\
        环境：为喜时类象为道路、门窗、小船；为忌时类象为破船、被毁的树木、被弃的花木。\r\n\
        吉凶：喜则出行吉祥、车船平安；凶则车船遇险、犯电线杆、树木等煞。\r\n\
        疾病：肝腹水、腰椎突出、断腿。\r\n\
        卯象：树木、草木、花木、灌木、绳索、木棒、兵器、织物、木材、建材、建筑、车船、街道、门窗、床、篱笆、网络、机构；于人体为肝胆、四肢、手臂、手指、腰、筋、毛发；动物为：貉、兔、狐。''';
    } else if ("辰" == earthName) {
      return '''辰象：五行属阳土，位居东南方。\r\n\
        场所：主土堰、宅兆、麦地、寺观；\r\n\
        人物：在人主僧人、道人、妇女；\r\n\
        人物肖像：强时类象为个子较高、大眼、方脸、额部宽广、面部较满；弱时类象为脸形较小、个子中等。为喜时类象为长男、医生、护士；为忌时类象为尼姑、羽士、僧人。\r\n\
        人体：不论喜忌均可类象为骨、皮肤、脖子、喉咙。\r\n\
        物品：瓷器、缸瓮、灰盆、香纸、皮毛；\r\n\
        在事上见吉神主医生药物，见凶神主屠夫、争讼。\r\n\
        环境：为喜时类象为麦地、田园、土岭；为忌时类象为宅兆、破花盆、泥泞之道。\r\n\
        疾病：糖尿病、皮肤病、骨炎，声音沙哑。\r\n\
        动物：龙、大蛇、蚯蚓。\r\n\
        吉凶：喜则医术精明、健康、愉快；凶则表示怪声怪气、呻吟痛苦。\r\n\
        辰象：湿土、泥、水库、池塘、堤岸、水井、田园、土产、牢狱、建筑、车辆、机器、大机构、旧物、中药、思想、网络；于人体为膀胱、内分泌、肌肤、肩、胸、腹、胃、肋；动物为：蛟、鱼、龙。''';
    } else if ("巳" == earthName) {
      return '''巳象：五行属阴火，位居东南方。\r\n\
        人物：在人为妇人、少妇、少女、乞丐；\r\n\
        人物肖像：强时表现为个头中等、园脸、脸色白中带红、眉毛特别浓黑；弱时类象为个子不高、脸椭圆、脸部较无表情、呆板。\r\n\
        人体：不论喜忌均可类象为三焦、小肠、牙齿、口腔、眼睛。\r\n\
        动物为长虫、蚯蚓、蝉、萤火虫,蛇、泥鳅、黄鳝；\r\n\
        物品主字画、文字、花果、砖瓦、瓷器；\r\n\
        在事上见吉神主文书、票证，见凶神主疫病、梦魇。\r\n\
        环境：为喜时类象为烧烤店、电器行、电影院、舞厅；为忌时类象为火葬场、废弃的砖瓦房、浓烟滚滚的冶炼厂。\r\n\
        疾病：牙疼、口腔炎、近视眼、结肠炎。\r\n\
        吉凶：喜则表示爱情、热和、热烈；忌则表示为严冷、失意、怯场。\r\n\
        巳象：阴火、温暖、文化、文章、思想、幻想、务虚、变化、色彩、影像、道路、寺观、楼台、闹市、网络；于人体为心脏、三焦、咽喉、面、齿、眼目、神经、小肠、肛门；动物为：蛇、蚓、蟑。''';
    } else if ("午" == earthName) {
      return '''午象：五行属阳火，位居南方。\r\n\
        场所：主大厅、会议室、电影院、娱乐场所；\r\n\
        人物：在人为僧人、骑马人、女秘书、宫女、使者；为喜时类象为高贵女人、卖酒人、女秘书；为忌时类象为火葬场焚尸工、酒鬼、七窍流血之人。\r\n\
        人体：不论喜忌均可类象为舌头、额头、脸部、脐、神气。\r\n\
        物品主电视机、音响、电器、字画、衣服、旌旗；\r\n\
        在事上见吉神为信息、文章，见凶神为惊奇、口舌是非。\r\n\
        人物肖像：强时个子较高、苹果脸形、双眼皮、眼大而有神；弱时个子中等、脸不透血色、眼睛下陷。\r\n\
        环境：为喜时类象为娱乐场、会议室、游戏厅；为忌时类象为地下赌场、被火烧过的山岭、废弃的炉灶、门前的电压器。\r\n\
        动物：马。\r\n\
        疾病：红眼病、胸闷、热症、心肌梗塞。\r\n\
        吉凶：吉则表示衷情、感激；凶则表示口舌、惊奇、血光之灾。\r\n\
        午象：阳火、大热、火器、血光、光彩、电子、信息、广告、文学、语言、文章、热情、激动、冶炼、战场、厅堂、大厦、剧场、体育场；于人体为心、小肠、眼、舌、血液、神经、精力；动物为：獐、马、鹿。''';
    } else if ("未" == earthName) {
      return '''未象：五行属阴土，位居西南。\r\n\
        场所：主大院、墙堰、宅兆、田野；\r\n\
        人物：在人为老妇人、老男人、放羊人、寡妇、巫师；为喜时类象为放羊人、高贵的妇人；为忌时类象为尼姑、巫师、道人、牢狱之人。\r\n\
        人物肖像：强时脸长、个子瘦高、不漂亮；弱时类象为脸方、个子中等、长相一般。\r\n\
        人体：不论喜忌均可类象为胃部、皮肤、头屑、脾。\r\n\
        动物：羊、鹰、白头翁；在物为衣服、药品、食品、酒器；\r\n\
        在事上见吉神为酒食、宴会、喜美之事，见凶神凶格为疾病，孝服、官灾。\r\n\
        环境：为喜时类象为厨房、油库、茶房；为忌时类象为废弃的油库、野外烧烤用的炉灶、医院的消毒室。\r\n\
        疾病：便秘、皮肤红肿、急性胃炎。\r\n\
        吉凶：吉则安静、享受；忌则精神颓丧、表情模糊、吃苦。\r\n\
        未象：温土、田园、公园、庭院、墙堰、林场、休闲、陶冶、情趣、饰物、酒店、酒食、土产、建筑物、营造、医药、化工、热毒；于人体为脾胃、腕、腹、口腔、肌肤、脊梁；动物为犴、羊、鹰。''';
    } else if ("申" == earthName) {
      return '''申象：五行属阳金，位居西南方。\r\n\
        场所：神堂、佛堂，麦地；\r\n\
        人物：在人为行人、军徒、凶恶之人；为喜时类象为医生、军人、警察、珠宝商人；为忌时类象为暴徒、屠夫。\r\n\
        物品：自行车三轮车、摩托车、火车、汽车、刀剑、金银、铁器类；\r\n\
        动物：猿、猴、狮子；\r\n\
        在事上遇吉神主有佳音、喜美之事，遇凶神主道路损失、疾病、破财。\r\n\
        人物肖像：强时类象为个子高、皮肤白净、鼻梁高、没有耳垂；弱时类象为个子中等、皮肤白中带黑斑、山根下陷、耳朵反轮。\r\n\
        环境：喜时类象为冰山、河源、珠宝店、钢铁厂、汽车销售部；忌时类象为祠堂、废弃的钢铁厂、报废汽车。\r\n\
        人体：不论喜忌均可类象为：胸、肺、筋骨、大肠。\r\n\
        吉凶：为吉时神佛仳佑、逢凶化吉；为忌时则惹神撞鬼、出行不吉。\r\n\
        疾病：肺结核、急性肺炎、骨折、四肢不灵。\r\n\
        申象：铁器、硬物、刀、铲、车、兵戈、军队、司法、矿物、矿厂、机器、车辆、医院、西医、道路、城池、名都、祠堂、金融、数位；于人体为肺、大肠、骨、脊椎、气管、食道、牙齿、骨钙、经络；动物为：猴、猿、猱。''';
    } else if ("酉" == earthName) {
      return '''酉象：五行属阴金，位居西方。\r\n\
        人物：在人为妇女、少女、阴朱紫、卖酒人；为喜时类象为妾、女朱紫、酒廊女待生；为忌时类象为酒醉鬼、理发学徒、烹饪学徒。\r\n\
        物品：金银、首饰、珍宝、刀剑、皮毛、爪骨、瓜果、口罩、石柱；\r\n\
        动物：鸡、鸽，\r\n\
        在事上见吉神主清谈和会，见凶神主疾患、离别。\r\n\
        人物肖像：强时类象为椭圆形脸、明亮的杏眼、皮肤细白、个头适中；弱时类象为瓜子脸、个子矮小、皮肤粗糙。\r\n\
        环境：为喜时类象为机厂、停机坪、汽车站、修理厂、五金店、化装室；为忌时类象为停尸房、手术室、爆炸现场、打靶场。\r\n\
        酉象：金石、剑戟、铲锄、器皿、街道、碑碣、寺院、酒店、银行、钟表、信息、传媒、法律、技术、隐学、玄学、机巧、奸邪、妓；于人体为肺、肋、小肠、耳朵、牙齿、骨骼、臂膀、精血；动物为：雉、鸡、鸟。''';
    } else if ("戌" == earthName) {
      return '''戌象：五行属阳土，位居西北方。\r\n\
        场所：山岭、冈坡、寺观、宅兆、厕所、牢狱；\r\n\
        人物：在人为长者、善人、僧道之人；吉时为农民、清洁工、好人、佛教徒、风水先生；为忌时类象孤冷之人、盗墓者、狱吏、丑妇。\r\n\
        人体：不论喜忌均可类象为命门、膝、腕、鼻子、皮肤等。\r\n\
        人物肖像：强时类象为大脸、个子高、鼻梁直；弱时类象为个子不高、脸呈椭圆形、勾鼻。\r\n\
        动物：狗、驴、熊；植物为大豆、高梁、荞菜；\r\n\
        物品：砖瓦、瓷器、药物、尸骨、锁匙、鞋履；\r\n\
        在事上见吉神主办事顺利，见凶神为虚诈不实及争斗走失、牢狱之灾。\r\n\
        环境：为喜时类象为花果山、厨房、砖瓦厂、变电所；为忌时类象为：宅兆、弹药库、牢房、厕所。\r\n\
        疾病：胃出血、鼻炎、关节炎、皮肤搔痒。\r\n\
        吉凶：吉则办事顺利、心情愉快；凶则牢狱之灾、心情压抑。\r\n\
        戌象：燥土、窑冶、炉、枪弹、军火、牢狱、刑法、坟墓、岗岭、古物、庙宇、加油站、电站、学校、编辑部、影院、闹市、市场、歌舞、色情、互联网、建筑、高楼、建材、化工、数学；于人体为心、心包、命门、背、胃、鼻、肌肉、腿、踝足；动物为：狼、狗、豺。''';
    } else if ("亥" == earthName) {
      return '''亥象：五行属阴水，位居西北方。\r\n\
        场所主江河、湖海、仓库、寺院、楼台、厕所；\r\n\
        人物：在人主小儿，乞丐、掌鞋人、赶猪人、醉酒人、罪人、盗贼；吉时为少女、船工、自来水公司职员；忌时为乞丐、犯人、捕鱼人。\r\n\
        人体：不论喜忌均可类象为膀胱、阴道、肛门、分秘物、头颅。\r\n\
        人物肖像：强时类象为脸长、个子中等、脸黑、耳朵较长；弱时类象为个子矮小、脸白、耳朵较小。\r\n\
        动物：熊、鱼、虾、蟹、猪类；\r\n\
        物品：毛发、夏布、绸绢、笔墨；\r\n\
        在事上见吉神主婚姻、求索，见凶神主争斗、难产。\r\n\
        环境：为喜时为小溪、泉水、小湖泊、天池；为忌时为下水道、臭水沟、污水坑、厕所。\r\n\
        动物：血病、月经不调、早泄、遗精、盗汗、洛血、小便赤热。\r\n\
        吉凶：喜则婚姻美满；凶则家庭破裂、丧事不断。\r\n\
        亥象：池塘、灌溉、沟道、笔墨、酒、水产、毒药、沈溺、心志、科技、运算、数字、思想、网络；于人体为头、肾、膀胱、尿道、血脉、经血。''';
    }

    return '未知';
  }
}