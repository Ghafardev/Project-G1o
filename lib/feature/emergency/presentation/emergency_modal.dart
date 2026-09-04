import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../emergency/data/sos_service.dart';

class EmergencyModal {
  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const _EmergencyBottomSheet(),
    );
  }
}

class _EmergencyBottomSheet extends StatelessWidget {
  const _EmergencyBottomSheet();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF141829),
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[600],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 24),

          // Emergency Mode Title
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.red.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.warning, color: Colors.red, size: 24),
              ),
              const SizedBox(width: 12),
              Text(
                'MODE DARURAT',
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Warning Message
          Text(
            'Anda akan mengirim sinyal SOS dengan lokasi Anda saat ini ke layanan darurat.',
            style: GoogleFonts.poppins(
              color: Colors.grey[400],
              fontSize: 14,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),

          // Emergency Options Grid
          Row(
            children: [
              Expanded(
                child: _buildEmergencyOption(
                  icon: Icons.phone_in_talk,
                  label: 'Panggil 112',
                  color: Colors.red,
                  onTap: () {
                    Navigator.pop(context);
                    SosService().makeEmergencyCall();
                  },
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildEmergencyOption(
                  icon: Icons.location_on,
                  label: 'Bagikan Lokasi',
                  color: Colors.blue,
                  onTap: () {
                    Navigator.pop(context);
                    // Implement location sharing
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildEmergencyOption(
                  icon: Icons.message,
                  label: 'Kirim SMS',
                  color: Colors.green,
                  onTap: () {
                    Navigator.pop(context);
                    // Implement SMS sending
                  },
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildEmergencyOption(
                  icon: Icons.family_restroom,
                  label: 'Hubungi Keluarga',
                  color: Colors.orange,
                  onTap: () {
                    Navigator.pop(context);
                    // Implement family contact
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Cancel Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2C3E50),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Batal',
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildEmergencyOption({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withValues(alpha: 0.3), width: 1),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 28),
            ),
            const SizedBox(height: 12),
            Text(
              label,
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
