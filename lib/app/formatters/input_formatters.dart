import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';

class InputFormatters {
  static final cpfMask = MaskTextInputFormatter(
    mask: '###.###.###-##',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );

  static final cnpjMask = MaskTextInputFormatter(
    mask: '##.###.###/####-##',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );

  static final phoneMask = MaskTextInputFormatter(
    mask: '(##) #####-####',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );

  static final emailMask = MaskTextInputFormatter(
    mask: '',
    filter: {"#": RegExp(r'[a-zA-Z0-9@._-]')},
  );

  static final cepMask = MaskTextInputFormatter(
    mask: '#####-###',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );

  static final ieMask = MaskTextInputFormatter(
    mask: '###.###.###.###',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );

  static final currencyMask = CurrencyInputFormatter(
    thousandSeparator: ThousandSeparator.Period,
    mantissaLength: 2,
  );
}
