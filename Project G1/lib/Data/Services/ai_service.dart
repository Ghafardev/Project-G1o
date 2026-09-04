

class AIService {
  // 1. Inisialisasi instance fllama
  get fllama => fllama(); 

  Future<String> generateResponse(String prompt) async {
    try {
      // 2. Pastikan model sudah dimuat (Load Model)
      // Sesuaikan path dengan lokasi wget kamu sebelumnya
      final result = await fllama(
        InferenceParams(
        modelPath: 'assets/models/tinyllama-1.1b-chat-v1.0.q4_k_m.gguf',
        contextSize: 512,
        ),
      );

      // 3. Generate teks menggunakan method yang benar
      final = await fllama.generateText(
        prompt: "Human: $prompt\nAI:",
        maxTokens: 128,
        temperature: 0.7,
      );

      return result;
    } catch (e) {
      return "Maaf, RagaBhumi sedang mengalami kendala teknis: $e";
    }
  }
  
  InferenceParams({required String modelPath, required int contextSize}) {}
}