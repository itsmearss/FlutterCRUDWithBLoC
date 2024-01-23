import 'package:crud_bloc_api/constants/snack_bar.dart';
import 'package:crud_bloc_api/logic/logic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddSpiceView extends StatefulWidget {
  const AddSpiceView({super.key});

  @override
  State<AddSpiceView> createState() => _AddSpiceViewState();
}

class _AddSpiceViewState extends State<AddSpiceView> {
  final TextEditingController _namaRempah = TextEditingController();
  final TextEditingController _namaLatin = TextEditingController();
  final TextEditingController _image = TextEditingController();
  final TextEditingController _deskripsi = TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    _namaRempah.dispose();
    _namaLatin.dispose();
    _image.dispose();
    _deskripsi.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Add Spice"),
      ),
      body: Container(
        padding: EdgeInsets.all(30),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          TextFormField(
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
              helperText: "Masukkan nama rempah",
            ),
            onChanged: (value) {},
          ),
          TextFormField(
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
              helperText: "Masukkan nama latin rempah",
            ),
          ),
          TextFormField(
            controller: _image,
            decoration: const InputDecoration(
              labelText: 'Link Image',
              labelStyle: TextStyle(
                color: Colors.blueGrey,
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.blueGrey,
                ),
              ),
              helperText: "Masukkan link image",
            ),
          ),
          TextFormField(
            controller: _deskripsi,
            maxLines: null,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Deskripsi',
              labelStyle: TextStyle(
                color: Colors.blueGrey,
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.blueGrey,
                ),
              ),
              helperText: "Masukkan deskripsi",
            ),
          ),
          ElevatedButton(
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
                context.read<LogicalService>().add(AddSpiceEvent(
                    nama_rempah: _namaRempah.text,
                    nama_latin: _namaLatin.text,
                    image: _image.text,
                    deskripsi: _deskripsi.text,
                    context: context));
              }
              Future.delayed(const Duration(milliseconds: 500), () {
                context.read<LogicalService>().add(ReadSpiceEvent());
              });
            },
            child: BlocBuilder<LogicalService, LogicState>(
              builder: (context, state) {
                if (state is AddSpiceLoading) {
                  bool isLoading = state.isLoading;
                  return isLoading
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : const Text("Add Spice");
                } else {
                  return const Text("Add Spice");
                }
              },
            ),
          ),
        ]),
      ),
    );
  }
}
