import 'package:flutter/material.dart';

class Parent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomPaint(
        size: Size(
            375,
            (375 * 0.13202933985330073)
                .toDouble()), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
        painter: RPSCustomPainter(),
      ),
    );
  }
}

class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {

    Path path_0 = Path();
    path_0.moveTo(size.width*0.7335428,size.height*6.166667);
    path_0.lineTo(size.width*0.6716675,size.height*6.166667);
    path_0.cubicTo(size.width*0.6668460,size.height*6.165000,size.width*0.6621247,size.height*6.155519,size.width*0.6578264,size.height*6.138889);
    path_0.cubicTo(size.width*0.6495232,size.height*6.106019,size.width*0.6430196,size.height*6.052000,size.width*0.6394645,size.height*5.986333);
    path_0.cubicTo(size.width*0.6211149,size.height*5.536741,size.width*0.5453888,size.height*5.406204,size.width*0.5031589,size.height*5.751352);
    path_0.cubicTo(size.width*0.4951418,size.height*5.816870,size.width*0.4891198,size.height*5.894889,size.width*0.4855134,size.height*5.979926);
    path_0.cubicTo(size.width*0.4785550,size.height*6.082907,size.width*0.4652885,size.height*6.152907,size.width*0.4501222,size.height*6.166667);
    path_0.lineTo(size.width*0.3887531,size.height*6.166667);
    path_0.lineTo(size.width*0.3887531,size.height*5.500000);
    path_0.lineTo(size.width*0.7335452,size.height*5.493944);
    path_0.lineTo(size.width*0.7335428,size.height*6.166667);
    path_0.close();

    Paint paint_0_fill = Paint()..style=PaintingStyle.fill;
    paint_0_fill.color = Color(0xffff3434).withOpacity(1.0);
    canvas.drawShadow(path_0, Colors.black, 3, true);
    canvas.drawPath(path_0,paint_0_fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}