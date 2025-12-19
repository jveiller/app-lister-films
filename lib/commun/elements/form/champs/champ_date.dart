import 'package:culture_app1/commun/composant_txt.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChampDate extends StatefulWidget {
  final String txt;
  final DateTime? date;
  final Function changeDate;
  final DateTime? premiereDate;
  final DateTime? derniereDate;
  final DateTime? dateInitiale;
  const ChampDate({
    super.key,
    required this.txt,
    required this.changeDate,
    required this.date,
    this.premiereDate,
    this.dateInitiale,
    this.derniereDate,
  });

  @override
  State<ChampDate> createState() => _ChampDateState();
}

class _ChampDateState extends State<ChampDate> {
  void fonctDate() {
    showDatePicker(
      context: context,
      locale: const Locale("fr", "FR"),
      firstDate: widget.premiereDate ?? DateTime(1910),
      lastDate: widget.derniereDate ?? DateTime.now(),
      initialDate: widget.date ?? widget.dateInitiale ?? DateTime.now(),
    ).then((value) {
      widget.changeDate(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ComposantTexte(texte: widget.txt, weight: FontWeight.bold),
        if (widget.date == null) ...[
          ElevatedButton(
            onPressed: fonctDate,
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(Colors.white),
            ),
            child: ComposantTexte(texte: 'Choisissez une date'),
          ),
        ] else ...[
          ElevatedButton(
            onPressed: fonctDate,
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(Colors.white),
              fixedSize: WidgetStateProperty.all(Size.fromWidth(160)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ComposantTexte(
                  texte: DateFormat("dd/MM/yyyy").format(widget.date!),
                ),
                Icon(Icons.calendar_month, color: Colors.black),
              ],
            ),
          ),
        ],
      ],
    );
  }
}
