import 'package:crud_bloc_api/constants/snack_bar.dart';
import 'package:crud_bloc_api/logic/logic.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdateSpiceView extends StatefulWidget {
  final int id;
  final String nama_rempah;
  final String nama_latin;
  final String deskripsi;
  final String image;
  const UpdateSpiceView(
      {super.key,
      required this.id,
      required this.nama_rempah,
      required this.nama_latin,
      required this.deskripsi,
      required this.image});

  @override
  State<UpdateSpiceView> createState() => _UpdateSpiceViewState();
}

class _UpdateSpiceViewState extends State<UpdateSpiceView> {
  late final TextEditingController _namaRempah;
  late final TextEditingController _namaLatin;
  late final TextEditingController _image;
  late final TextEditingController _deskripsi;

  @override
  void initState() {
    // TODO: implement initState
    _namaRempah = TextEditingController(text: widget.nama_rempah);
    _namaLatin = TextEditingController(text: widget.nama_latin);
    _image = TextEditingController(text: widget.image);
    _deskripsi = TextEditingController(text: widget.deskripsi);
    super.initState();
  }

  @override
  void dispose() {
    _namaRempah.dispose();
    _namaLatin.dispose();
    _image.dispose();
    _deskripsi.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Update Spice")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: TextFormField(
              controller: _namaRempah,
              decoration: const InputDecoration(
                labelText: 'Nama Rempah',
                labelStyle: TextStyle(
                  color: Colors.blueGrey,
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.blueGrey,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: TextFormField(
              controller: _namaLatin,
              decoration: const InputDecoration(
                labelText: 'Nama Latin',
                labelStyle: TextStyle(
                  color: Colors.blueGrey,
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.blueGrey,
                  ),
                ),
                helperText: "What's your name?",
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: TextFormField(
              controller: _image,
              decoration: const InputDecoration(
                labelText: 'Image',
                labelStyle: TextStyle(
                  color: Colors.blueGrey,
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.blueGrey,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: TextFormField(
              maxLines: null,
              controller: _deskripsi,
              decoration: const InputDecoration(
                labelText: 'Deskripsi',
                labelStyle: TextStyle(
                  color: Colors.blueGrey,
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.blueGrey,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueGrey,
              ),
              onPressed: () {
                if (_namaRempah.text.isEmpty) {
                  snackBar(context, "Lengkapi nama rempah");
                } else if (_namaLatin.text.isEmpty) {
                  snackBar(context, "Lengkapi nama latin");
                } else if (_image.text.isEmpty) {
                  snackBar(context, "Lengkapi image");
                } else if (_deskripsi.text.isEmpty) {
                  snackBar(context, "Lengkapi deskripsi");
                } else {
                  context.read<LogicalService>().add(UpdateSpiceEvent(
                        context,
                        rempah_id: widget.id.toString(),
                        nama_rempah: _namaRempah.text,
                        nama_latin: _namaLatin.text,
                        image: _image.text,
                        deskripsi: _deskripsi.text,
                      ));
                }
                context.read<LogicalService>().add(ReadSpiceEvent());
              },
              child: BlocBuilder<LogicalService, LogicState>(
                builder: (context, state) {
                  if (state is UpdateSpiceLoading) {
                    bool isLoading = state.isLoading;
                    return isLoading
                        ? const CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : const Text("Update Spice");
                  } else {
                    return const Text("Update Spice");
                  }
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
