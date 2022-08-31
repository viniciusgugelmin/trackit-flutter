import 'package:flutter/material.dart';
import 'package:trackit_flutter/layouts/Logged/index.dart';
import 'package:trackit_flutter/utils/Colors/index.dart';
import 'package:trackit_flutter/widgets/Title/index.dart';

class HistoricPage extends StatelessWidget {
  const HistoricPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LoggedLayout(
      page: 'Historic',
      body: Column(
        children: [
          const TitleApp('Historic'),
          Container(
            padding: const EdgeInsets.only(top: 17),
            child: Row(
              children: const [
                Flexible(
                  child: Text(
                    "Soon you will be able to see the history of your habits here!",
                    style: TextStyle(
                      color: ColorsUtils.darkerGray,
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
