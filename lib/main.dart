import 'package:flutter/material.dart';
import 'package:validators/validators.dart';

enum GenderList { male, female }

void main() => runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            title: Text('Flutter.su - Форма ввода'),
          ),
          body: MyForm(),
        ),
      ),
    );

class MyForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MyFormState();
}

class MyFormState extends State {
  final _formKey = GlobalKey<FormState>();
  final _labelStyle = TextStyle(fontSize: 20.0);
  GenderList _gender;
  bool _agreement = false;

  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            Text(
              'Имя пользователя',
              style: _labelStyle,
            ),
            TextFormField(
              validator: (value) {
                if (value.isEmpty) return 'Пожалуйста введите свое имя';
              },
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              'Контактный email',
              style: _labelStyle,
            ),
            TextFormField(
              validator: (value) {
                if (value.isEmpty) return 'Пожалуйста введите свой Email';

//                String p = "[a-zA-Z0-9+.\_\%-+]{1,256}@[a-zA-Z0-9][a-zA-Z0-9-]{0,64}(.[a-zA-Z0-9][a-zA-Z0-9-]{0,25})+";
//                RegExp regExp = new RegExp(p);
//
//                if (regExp.hasMatch(value)) return null;
                if (isEmail(value)) return null;
                return 'Это не Email';
              },
            ),
            SizedBox(
              height: 20.0,
            ),
            RadioListTile(
                title: const Text('Мужской'),
                value: GenderList.male,
                groupValue: _gender,
                onChanged: (GenderList value) {
                  setState(() {
                    _gender = value;
                  });
                }),
            RadioListTile(
                title: const Text('Женский'),
                value: GenderList.female,
                groupValue: _gender,
                onChanged: (GenderList value) {
                  setState(() {
                    _gender = value;
                  });
                }),
            SizedBox(
              height: 20.0,
            ),
            CheckboxListTile(
                title: Text('Я ознакомлен' +
                    (_gender == null
                        ? '(а)'
                        : _gender == GenderList.male ? '' : 'а') +
                    ' с документом "Согласие на обработку персональных данных" и даю согласие на обработку моих персональных данных в соответствии с требованиями "Федерального закона О персональных данных № 152-ФЗ".'),
                value: _agreement,
                onChanged: (bool value) {
                  setState(() {
                    _agreement = value;
                  });
                }),
            SizedBox(
              height: 20.0,
            ),
            RaisedButton(
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  Color color = Colors.red;
                  String text;

                  if (_gender == null)
                    text = 'Выберите свой пол';
                  else if (_agreement == false)
                    text = 'Необходимо принять условия соглашения';
                  else {
                    text = 'Форма успешно заполнена';
                    color = Colors.green;
                  }

                  Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text(text),
                    backgroundColor: color,
                  ));
                }
              },
              child: Text('Проверить'),
              color: Colors.blue,
              textColor: Colors.white,
            )
          ],
        ),
      ),
    );
  }
}
