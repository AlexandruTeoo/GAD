import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main()
{
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: CurrencyConvertor()
    );
  }
}


class CurrencyConvertor extends StatefulWidget {
  const CurrencyConvertor({Key? key}) : super(key: key);

  @override
  State<CurrencyConvertor> createState() => _CurrencyConvertorState();
}

class _CurrencyConvertorState extends State<CurrencyConvertor> {
  TextEditingController controllerMoney = TextEditingController();


  double? _amountMoney = 1, _amountMoneyConverted = 0;
  convertMoney ()
  {
    setState(() {
      _amountMoney = double.parse(controllerMoney.text);
      _amountMoneyConverted = _amountMoney! * 4.5;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar (
          backgroundColor: Colors.blue,
          centerTitle: true,
          title: Text ('Currency Convertor'),
        ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/img.png'), // nu imi afiseaza imaginea, am incercat mai multe variante, nu stiu ce trebuie facut
                  fit: BoxFit.fitWidth,                   // la inceput imi afisa imaginea, acum nu mai pot vedea chiar daca imi fac un alt proiect
                  alignment: Alignment.topCenter,         // am fost atent la spatierea bucatii de cod de la assets din folderul pubspec.yaml
                )
              ),
            ),
            TextFormField(
              controller: controllerMoney,
              decoration: InputDecoration(
                labelText: "Enter the amount in EUR",
                labelStyle: TextStyle(fontSize: 15),
              ),
              //validator: (value),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]+[,.]{0,1}[0-9]*')),
                TextInputFormatter.withFunction((oldValue, newValue) => newValue.copyWith(
                  text: newValue.text.replaceAll(',', '.'),
                ))
              ],
            ),
            ElevatedButton(
                onPressed: (){
                  convertMoney();
                  controllerMoney.clear();
                },
                child: Text('CONVERT!')
            ),
            Text('Result: $_amountMoneyConverted',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight:  FontWeight.bold
              ),
            ),
          ],
        ),
      )
    );
  }
}

String? validateNumber(String value) {
  if (value[0] == '0')
    return 'enter a valid number';
  return null;
}
