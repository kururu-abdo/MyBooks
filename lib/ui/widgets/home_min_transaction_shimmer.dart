import 'package:flutter/material.dart';
import 'package:mybooks/core/utils/sizes.dart';
import 'package:mybooks/ui/widgets/transaction.dart';
import 'package:shimmer/shimmer.dart';

class HomeMiniTrancationsShimmer extends StatefulWidget {
  const HomeMiniTrancationsShimmer({Key? key}) : super(key: key);

  @override
  _HomeMiniTrancationsShimmerState createState() =>
      _HomeMiniTrancationsShimmerState();
}

class _HomeMiniTrancationsShimmerState
    extends State<HomeMiniTrancationsShimmer> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        enabled: true,
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            Container(
              margin: EdgeInsets.all(15),
              height: 60,
              width: double.infinity,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(defaultRadius)),
                // boxShadow: [
                //   BoxShadow(
                //       // color: Colors!.green!.withOpacity(0.7)!, //New
                //       blurRadius: 25.0,
                //       offset: Offset(0, -10))
                // ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 100.0,
                        height: 20.0,
                        color: Colors.white,
                      ),
                      Container(
                        width: 20.0,
                        height: 48.0,
                        color: Colors.white,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: 48.0,
                    height: 48.0,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(15),
              height: 60,
              width: double.infinity,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(defaultRadius)),
                // boxShadow: [
                //   BoxShadow(
                //       // color: Colors!.green!.withOpacity(0.7)!, //New
                //       blurRadius: 25.0,
                //       offset: Offset(0, -10))
                // ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 100.0,
                        height: 20.0,
                        color: Colors.white,
                      ),
                      Container(
                        width: 20.0,
                        height: 48.0,
                        color: Colors.white,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: 48.0,
                    height: 48.0,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(15),
              height: 60,
              width: double.infinity,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(defaultRadius)),
                // boxShadow: [
                //   BoxShadow(
                //       // color: Colors!.green!.withOpacity(0.7)!, //New
                //       blurRadius: 25.0,
                //       offset: Offset(0, -10))
                // ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 100.0,
                        height: 20.0,
                        color: Colors.white,
                      ),
                      Container(
                        width: 20.0,
                        height: 48.0,
                        color: Colors.white,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: 48.0,
                    height: 10.0,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(15),
              height: 60,
              width: double.infinity,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(defaultRadius)),
                // boxShadow: [
                //   BoxShadow(
                //       // color: Colors!.green!.withOpacity(0.7)!, //New
                //       blurRadius: 25.0,
                //       offset: Offset(0, -10))
                // ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 100.0,
                        height: 20.0,
                        color: Colors.white,
                      ),
                      Container(
                        width: 20.0,
                        height: 20.0,
                        color: Colors.white,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: 48.0,
                    height: 10.0,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
