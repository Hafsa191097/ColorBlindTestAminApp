import 'package:flutter/material.dart';

class OptionTile extends StatefulWidget {
  // ignore: non_constant_identifier_names
  final String option, correctAns, selectedAns, description;
  const OptionTile({
    super.key,
    required this.option,
    required this.correctAns,
    required this.selectedAns,
    required this.description,
  });

  @override
  State<OptionTile> createState() => _OptionTileState();
}

class _OptionTileState extends State<OptionTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Container(
            width: 22,
            height: 22,
            decoration: BoxDecoration(
              border: Border.all(
                  color: widget.description == widget.selectedAns
                      ? widget.selectedAns == widget.correctAns
                          ? Colors.green
                          : Colors.red
                      : Colors.grey,
                  width: 1.5),
              borderRadius: BorderRadius.circular(30),
            ),
            alignment: Alignment.center,
            child: Text(
              widget.option,
              style: TextStyle(
                color: widget.selectedAns == widget.description
                    ? widget.correctAns == widget.selectedAns
                        ? Colors.green
                        : Colors.red
                    : Colors.grey,
              ),
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          Text(
            widget.description,
            style: const TextStyle(
              color: Colors.black54,
              fontSize: 17,
            ),
          ),
        ],
      ),
    );
  }
}

class NoOfQuestionTile extends StatefulWidget {
  final String text;
  final int number;

  const NoOfQuestionTile({super.key, required this.text, required this.number});

  @override
  _NoOfQuestionTileState createState() => _NoOfQuestionTileState();
}

class _NoOfQuestionTileState extends State<NoOfQuestionTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 3),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
            decoration:const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(14),
                    bottomLeft: Radius.circular(14)),
                color: Colors.redAccent),
            child: Text(
              "${widget.number}",
              style:const TextStyle(color: Colors.black54),
            ),
          ),
          Container(
            padding:const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
            decoration:const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(14),
                  bottomRight: Radius.circular(14),
                ),
                color: Colors.black54),
            child: Text(
              widget.text,
              style:const TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}
