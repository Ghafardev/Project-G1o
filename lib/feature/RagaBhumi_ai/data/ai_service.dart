import 'dart:async';

class AiService {
  Future<void> initModel() async {
    // Di versi Web, kita lewati pemuatan file .gguf.
    // Simulasi loading 1 detik agar terlihat natural.
    await Future.delayed(const Duration(seconds: 1));
  }

  Stream<String> getResponseStream(String prompt) async* {
    // 1. Fase "Berpikir"
    yield "Menganalisis situasi darurat...";
    await Future.delayed(const Duration(seconds: 1));

    String response;
    String input = prompt.toLowerCase();

    // 2. Deteksi Kata Kunci untuk Demo Hackathon
    if (input.contains("banjir") || input.contains("air naik")) {
      response = "Peringatan Dini: Segera amankan barang elektronik ke tempat tinggi. Matikan aliran listrik dari meteran utama. Siapkan tas siaga bencana (dokumen, P3K, senter) dan pantau terus jalur evakuasi terdekat.";
    } else if (input.contains("gempa")) {
      response = "Prosedur Gempa: Berlindunglah di bawah struktur yang kuat (seperti meja). Jauhi jendela, lemari, atau benda yang mudah jatuh. Jangan berlari keluar gedung saat guncangan masih terjadi.";
    } else if (input.contains("luka") || input.contains("darah")) {
      response = "Tindakan Medis Darurat: Tekan area yang berdarah dengan kain bersih untuk menghentikan pendarahan. Jangan pindahkan korban jika dicurigai ada cedera tulang belakang. Segera tekan tombol SOS darurat di menu utama.";
    } else {
      response = "RagaBhumi menerima laporan Anda. Harap tetap tenang. Silakan sebutkan secara spesifik jenis keadaan darurat (misal: banjir, gempa, kebakaran) agar saya dapat memberikan protokol keselamatan darurat yang tepat.";
    }

    // 3. Efek Streaming Teks (Typewriter) agar terlihat seperti AI asli
    String currentText = "";
    List<String> words = response.split(' ');
    
    for (var word in words) {
      currentText += "$word ";
      yield currentText;
      // Kecepatan mengetik AI: 80 milidetik per kata
      await Future.delayed(const Duration(milliseconds: 80)); 
    }
  }
}