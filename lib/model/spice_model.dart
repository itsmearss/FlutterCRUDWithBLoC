class UserSpice {
  final String status;
  List<Spice> data;

  UserSpice({this.status = "no-status", this.data = const []});

  factory UserSpice.fromJson(Map<String, dynamic> json) => UserSpice(
      status: json["status"],
      data: List<Spice>.from(json["rempah"].map((e) => Spice.fromJson(e))));
}

class Spice {
  final int id;
  final String nama_rempah;
  final String nama_latin;
  final String image;
  final String deskripsi;

  Spice(
      {this.id = 0,
      this.nama_rempah = "no-name",
      this.nama_latin = "no-latin",
      this.image = "no-image",
      this.deskripsi = "no-deskripsi"});
  factory Spice.fromJson(Map<String, dynamic> json) => Spice(
      id: json["rempah_id"],
      nama_rempah: json["nama_rempah"],
      nama_latin: json["nama_latin"],
      image: json["image"],
      deskripsi: json["deskripsi"]);
}
