class Validator {
  static String emailValidate(String value) {
    return value.isEmpty ? 'ກະລຸນາໃສ່ອີເມລຂອງທ່ານໃຫ້ຖືກຕ້ອງ' : null;
  }

  static String passwordValidate(String value) {
    return value.length < 6 ? 'ກະລຸນາໃສ່ລະຫັດຜ່ານຂອງທ່ານໃຫ້ຖືກຕ້ອງ' : null;
  }

  static String nameValidate(String value) {
    return value.isEmpty ? 'ກະລຸນາໃສ່ຊື່ຂອງທ່ານ' : null;
  }

  static String surnameValidate(String value) {
    return value.isEmpty ? 'ກະລຸນາໃສ່ນາມສະກຸນຂອງທ່ານ' : null;
  }
}
