import 'package:flutter/material.dart';
import 'package:mybooks/ui/widgets/header.dart';
import 'package:mybooks/ui/widgets/home_last_process_lable.dart';
import 'package:mybooks/ui/widgets/transaction_lists.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({Key? key}) : super(key: key);

  @override
  _HomeBodyState createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  @override
  Widget build(BuildContext context) {
    bool _showButtomSheet = false;
    void updateBottomSheetState() {
      setState(() {
        _showButtomSheet = !_showButtomSheet;
      });
    }

    return Container(
      child: Column(
        children: [
          Header(
            onMenueIconPressed: updateBottomSheetState,
          ),
          SizedBox(
            height: 20,
          ),
          LastProcessLable(),
          SizedBox(
            height: 15,
          ),

          //   TransactionListHomeMiniTrancationsShimmer()
          TransactionList()
        ],
      ),
    );
  }
}
