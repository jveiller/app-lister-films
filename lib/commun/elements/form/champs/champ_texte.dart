import 'package:culture_app1/commun/composant_txt.dart';
import 'package:flutter/material.dart';

class ChampTexte extends StatelessWidget {
  final String txt;
  final TextEditingController champController;
  final bool necessaire;
  final int? maxSize;
  final bool plusieursLignes;
  final Future<List<String>> Function()? suggestionsFonction;
  final focusNode = FocusNode();
  ChampTexte({
    super.key,
    required this.txt,
    required this.champController,
    this.necessaire = false,
    this.maxSize,
    this.plusieursLignes = false,
    this.suggestionsFonction,
  });

  String? _validator(String? value) {
    if (necessaire == true && (value == null || value.isEmpty)) {
      return 'Tu dois compléter ce texte';
    }
    return null;
  }

  InputDecoration get _decoration => const InputDecoration(
    fillColor: Colors.white,
    filled: true,
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.black, width: 2),
    ),
    border: OutlineInputBorder(),
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ComposantTexte(texte: txt, weight: FontWeight.bold),
        if (suggestionsFonction == null)
          TextFormField(
            cursorColor: Colors.black,
            decoration: _decoration,
            maxLines: plusieursLignes ? null : 1,
            minLines: 1,
            textCapitalization: TextCapitalization.sentences,
            keyboardType: TextInputType.multiline,
            validator: _validator,
            controller: champController,
          )
        else
          FutureBuilder<List<String>>(
            future: suggestionsFonction!(),
            builder: (context, snapshot) {
              final suggestions = snapshot.data ?? [];
              return RawAutocomplete<String>(
                textEditingController: champController,
                focusNode: focusNode,
                onSelected: (String selection) {
                  champController.text = selection;
                },
                optionsBuilder: (TextEditingValue value) {
                  if (value.text.isEmpty) {
                    return const Iterable<String>.empty();
                  }
                  return suggestions.where(
                    (s) => s.toLowerCase().contains(value.text.toLowerCase()),
                  );
                },
                fieldViewBuilder: (context, controller, focusNode, onFieldSubmitted) {
                  return TextFormField(
                    controller: controller,
                    focusNode: focusNode,
                    cursorColor: Colors.black,
                    decoration: _decoration,
                    maxLines: 1,
                    minLines: 1,
                    textCapitalization: TextCapitalization.sentences,
                    validator: _validator,
                  );
                },
                optionsViewBuilder: (context, onSelected, options) {
                  return Align(
                    alignment: Alignment.topLeft,
                    child: Material(
                      elevation: 4,
                      child: ConstrainedBox(
                        constraints: BoxConstraints(maxHeight: 200, maxWidth: 260),
                        child: ListView(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          children: [
                            for (String option in options)
                              ListTile(
                                title: ComposantTexte(texte: option),
                                onTap: () => onSelected(option),
                              ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
      ],
    );
  }
}
