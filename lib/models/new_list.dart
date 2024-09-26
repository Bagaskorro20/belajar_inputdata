class NewList {
  NewList({
      String? postOn, 
      String? judul, 
      String? deskripsi, 
      String? gambar, 
      String? id,}){
    _postOn = postOn;
    _judul = judul;
    _deskripsi = deskripsi;
    _gambar = gambar;
    _id = id;
}

  NewList.fromJson(dynamic json) {
    _postOn = json['post_on'];
    _judul = json['judul'];
    _deskripsi = json['deskripsi'];
    _gambar = json['gambar'];
    _id = json['id'];
  }
  String? _postOn;
  String? _judul;
  String? _deskripsi;
  String? _gambar;
  String? _id;

  String? get postOn => _postOn;
  String? get judul => _judul;
  String? get deskripsi => _deskripsi;
  String? get gambar => _gambar;
  String? get id => _id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['post_on'] = _postOn;
    map['judul'] = _judul;
    map['deskripsi'] = _deskripsi;
    map['gambar'] = _gambar;
    map['id'] = _id;
    return map;
  }

}