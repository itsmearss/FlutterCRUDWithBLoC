import 'package:crud_bloc_api/logic/logic.dart';
import 'package:crud_bloc_api/model/spice_model.dart';
import 'package:crud_bloc_api/view/add_spice_view.dart';
import 'package:crud_bloc_api/view/edit_spice_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    // TODO: implement initState
    context.read<LogicalService>().add(ReadSpiceEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[100],
        centerTitle: true,
        title: Text("List of Spice"),
      ),
      body: _buildBody,
      floatingActionButton: FloatingActionButton(
          child: const Text("Add"),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => AddSpiceView()));
            Future.delayed(const Duration(milliseconds: 500), () {
              context.read<LogicalService>().add(ReadSpiceEvent());
            });
          }),
    );
  }

  Widget get _buildBody {
    return BlocBuilder<LogicalService, LogicState>(builder: (context, state) {
      if (state is LogicInitializeState || state is LogicLoadingState) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else if (state is LogicErrorState) {
        String err = state.error;
        return Center(
          child: Text(err),
        );
      } else if (state is ReadSpiceState) {
        var data = state.spiceModel;
        return _buildListview(data);
      } else {
        return Container();
      }
    });
  }

  Widget _buildListview(UserSpice spiceModel) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<LogicalService>().add(ReadSpiceEvent());
      },
      child: ListView.builder(
          itemCount: spiceModel.data.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () async {
                await Navigator.push(context,
                    MaterialPageRoute(builder: (context) {
                  return UpdateSpiceView(
                      id: spiceModel.data[index].id,
                      nama_rempah: spiceModel.data[index].nama_rempah,
                      nama_latin: spiceModel.data[index].nama_latin,
                      deskripsi: spiceModel.data[index].deskripsi,
                      image: spiceModel.data[index].image);
                }));
              },
              child: ListTile(
                leading: Text(spiceModel.data[index].id.toString()),
                title:
                    Text("Nama Rempah: ${spiceModel.data[index].nama_rempah}"),
                subtitle:
                    Text("Nama Latin: ${spiceModel.data[index].nama_latin}"),
                trailing: IconButton(
                    onPressed: () {
                      context.read<LogicalService>().add(DeleteSpiceEvent(
                          id: spiceModel.data[index].id.toString()));
                      context.read<LogicalService>().add(ReadSpiceEvent());
                    },
                    icon: const Icon(Icons.delete_outline)),
              ),
            );
          }),
    );
  }
}
