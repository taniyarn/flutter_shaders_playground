import 'package:flutter/material.dart';
import 'package:flutter_shaders/flutter_shaders.dart';

class Sample1 extends StatefulWidget {
  const Sample1({Key? key}) : super(key: key);

  @override
  State<Sample1> createState() => _Sample1State();
}

class _Sample1State extends State<Sample1> {
  double _value = 2.0;

  void _onChanged(double newValue) {
    setState(() {
      _value = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SampledText(time: _value),
          Slider(value: _value, onChanged: _onChanged, min: 2, max: 200),
        ],
      ),
    );
  }
}

class SampledText extends StatelessWidget {
  const SampledText({super.key, required this.time});

  final double time;

  @override
  Widget build(BuildContext context) {
    return ShaderBuilder((context, shader, child) {
      return AnimatedSampler((image, size, canvas) {
        const double overdrawPx = 30;
        shader
          ..setFloat(0, size.width)
          ..setFloat(1, size.height)
          ..setFloat(2, time)
          ..setImageSampler(0, image);
        Rect rect = Rect.fromLTWH(-overdrawPx, -overdrawPx,
            size.width + overdrawPx, size.height + overdrawPx);
        canvas.drawRect(rect, Paint()..shader = shader);
      },
          child: const Text(
            'Hello World',
            style: TextStyle(fontSize: 50),
          ));
    }, assetKey: 'assets/shaders/sample1.frag');
  }
}
