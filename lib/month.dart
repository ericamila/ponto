class Month {
  int month;
  String? monthString;
  late String short;
  late String long;

  Month(this.month) {
    switch (month) {
      case 1:
        short = "jan";
        long = "Janeiro";
        break;
      case 2:
        short = "fev";
        long = "Fevereiro";
        break;
      case 3:
        short = "mar";
        long = "Março";
        break;
      case 4:
        short = "abr";
        long = "Abril";
        break;
      case 5:
        short = "mai";
        long = "Maio";
        break;
      case 6:
        short = "jun";
        long = "Junho";
        break;
      case 7:
        short = "jul";
        long = "Julho";
        break;
      case 8:
        short = "ago";
        long = "Agosto";
        break;
      case 9:
        short = "set";
        long = "Setembro";
        break;
      case 10:
        short = "out";
        long = "Outubro";
        break;
      case 11:
        short = "nov";
        long = "Novembro";
        break;
      case 12:
        short = "dez";
        long = "Dezembro";
        break;
    }
  }

  Month.string({this.month = 99, required this.monthString}) {
    switch (monthString) {
      case "Janeiro":
        month = 1;
        break;
      case "Feveiro":
        month = 2;
        break;
      case "Março":
        month = 3;
        break;
      case "Abril":
        month = 4;
        break;
      case "Maio":
        month = 5;
        break;
      case "Junho":
        month = 6;
        break;
      case "Julho":
        month = 7;
        break;
      case "Agosto":
        month = 8;
        break;
      case "Setembro":
        month = 9;
        break;
      case "Outubro":
        month = 10;
        break;
      case "Novembro":
        month = 11;
        break;
      case "Dezembro":
        month = 12;
        break;
    }
  }

  @override
  String toString() {
    return long;
  }
}
