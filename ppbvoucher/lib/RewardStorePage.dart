import 'package:flutter/material.dart';

class RewardStorePage extends StatefulWidget {
  const RewardStorePage({super.key});

  @override
  State<RewardStorePage> createState() => _RewardStorePageState();
}

class _RewardStorePageState extends State<RewardStorePage> {
  int points = 100000;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTopHeader(),
            const SizedBox(height: 18),
            _buildRewardContent(context),
          ],
        ),
      ),
    );
  }

  Widget _buildTopHeader() {
    return Column(
      children: [
        const SizedBox(height: 12),
        Center(
          child: Container(
            width: 88,
            height: 88,
            decoration: const BoxDecoration(
              color: Color(0xFFDCECDC),
              shape: BoxShape.circle,
            ),
            child: Padding(
              padding: EdgeInsets.all(18.0),
              child: Image.asset('assets/images/icon_gift.png'),
            ),
          ),
        ),
        const SizedBox(height: 20),
        const Text(
          'Reward Store',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }

  Widget _buildRewardContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 18),
        _buildPointsCard(),
        const SizedBox(height: 18),
        Row(
          children: [
            Expanded(child: _roundedButtonOutlineUang('Tukar Uang', onTap: () => _openExchangeMoney(context))),
            const SizedBox(width: 12),
            Expanded(child: _roundedButtonOutlineVoucher('Tukar voucher', onTap: () => _openVoucherPage(context))),
          ],
        ),
        const SizedBox(height: 20),
        const Text('Spesial Buat Kamu', style: TextStyle(fontWeight: FontWeight.w600)),
        const SizedBox(height: 12),
        _buildVoucherItem(
          title: 'Gift Voucher Ice Cream',
          cost: 100,
          imagePath: 'assets/images/voucher_icecream.png',
          onTap: () => _showVoucherConfirm(context, cost: 100),
        ),
        const SizedBox(height: 18),
        const Text('Voucher Belanja', style: TextStyle(fontWeight: FontWeight.w600)),
        const SizedBox(height: 12),
        Row(
          children: [
            _buildSmallVoucher('assets/images/voucher_fashion.png', 'Voucher Fashion', 100),
            const SizedBox(width: 12),
            _buildSmallVoucher('assets/images/voucher_fashion2.png', 'Voucher Fashion', 200),
          ],
        ),
        const SizedBox(height: 40),
      ],
    );
  }

  Widget _buildPointsCard() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFF4FC05E),
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(colors: [Color(0xFF6B8E5F), Color(0xFF6B8E5F)]),
      ),
      padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Icon(Icons.monetization_on, color: Colors.white),
              SizedBox(width: 8),
              Text('Poin Tersedia', style: TextStyle(color: Colors.white)),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            _formatPoints(points),
            style: const TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  String _formatPoints(int p) {
    final s = p.toString();
    if (s.length <= 3) return s;
    final buffer = StringBuffer();
    int rem = s.length % 3;
    if (rem > 0) {
      buffer.write(s.substring(0, rem));
      if (s.length > rem) buffer.write('.');
    }
    for (int i = rem; i < s.length; i += 3) {
      buffer.write(s.substring(i, i + 3));
      if (i + 3 < s.length) buffer.write('.');
    }
    return buffer.toString();
  }

  Widget _roundedButtonOutlineUang(String text, {required VoidCallback onTap}) {
    return OutlinedButton(
      onPressed: onTap,
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        side: const BorderSide(color: Color(0xFF2DAA45), width: 2),
        foregroundColor: Colors.black87,
      ),
      child: Text(text, style: const TextStyle(color: Colors.black54, fontWeight: FontWeight.w600)),
    );
  }

  Widget _roundedButtonOutlineVoucher(String text, {required VoidCallback onTap}) {
    return OutlinedButton(
      onPressed: onTap,
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        side: const BorderSide(color: Color(0xFF2DAA45), width: 2),
        foregroundColor: Colors.black87,
      ),
      child: Text(text, style: const TextStyle(color: Colors.black54, fontWeight: FontWeight.w600)),
    );
  }

  Widget _buildVoucherItem({required String title, required int cost, required String imagePath, required VoidCallback onTap}) {
  return Opacity(
    opacity: 0.5,
    child: IgnorePointer(
      child: Row(
        children: [
          ClipRRect(borderRadius: BorderRadius.circular(12), child: Image.asset(imagePath, width: 96, height: 96, fit: BoxFit.cover)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.monetization_on, size: 16, color: Colors.green),
                  const SizedBox(width: 6),
                  Text(cost.toString(), style: const TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ]),
          ),
        ],
      ),
    ),
  );
}


 Widget _buildSmallVoucher(String imagePath, String title, int cost) {
  return Expanded(
    child: Opacity(
      opacity: 0.5,
      child: IgnorePointer(
        child: Column(
          children: [
            ClipRRect(borderRadius: BorderRadius.circular(14), child: Image.asset(imagePath, height: 96, fit: BoxFit.cover)),
            const SizedBox(height: 8),
            Text(title, style: const TextStyle(fontSize: 12)),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Icon(Icons.monetization_on, size: 14, color: Colors.green),
              const SizedBox(width: 6),
              Text(cost.toString(), style: const TextStyle(fontSize: 12)),
            ])
          ],
        ),
      ),
    ),
  );
}

  void _openExchangeMoney(BuildContext ctx) {
    Navigator.of(ctx).push(MaterialPageRoute(builder: (_) => ExchangeMoneyPage(
      initialPoints: points,
      onExchangeSuccess: (deduct) {
        setState(() {
          points -= deduct;
        });
      },
    )));
  }

  void _openVoucherPage(BuildContext ctx) {
    Navigator.of(ctx).push(
      MaterialPageRoute(builder: (_) => VoucherListPage(onRedeem: (cost) {
        _showVoucherConfirm(ctx, cost: cost);
      })),
    );
  }

  void _showVoucherConfirm(BuildContext ctx, {required int cost}) {
    showDialog(
      context: ctx,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        content: Text('Kamu akan menukarkan $cost poin untuk voucher yang kamu pilih'),
        actions: [
           OutlinedButton(
          onPressed: () => Navigator.of(ctx).pop(),
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: Color(0xFF798645)),
            foregroundColor: const Color.fromARGB(255, 0, 0, 0), 
          ),
          child: const Text('Batal'),
        ),
        
          ElevatedButton(onPressed: () {
            Navigator.of(ctx).pop(); 
            _showSuccessDialog(ctx);
            setState(() {
              points -= cost;
            });
          }, 
           style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF798645),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          child: const Text('Tukar')),
        ],
      ),
    );
  }

  void _showSuccessDialog(BuildContext ctx) {
    showDialog(
      context: ctx,
      barrierDismissible: true,
      builder: (_) => Center(
        child: Material(
          color: Colors.transparent,
          child: Container(
            width: 180,
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Image.asset('assets/images/check_success.png', width: 66, height: 66),
              const SizedBox(height: 8),
              const Text('Poin Berhasil Ditukar!', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.w600))
            ]),
          ),
        ),
      ),
    );
  }
}


class ExchangeMoneyPage extends StatefulWidget {
  final int initialPoints;
  final void Function(int deduct) onExchangeSuccess;
  ExchangeMoneyPage({required this.initialPoints, required this.onExchangeSuccess});

  @override
  _ExchangeMoneyPageState createState() => _ExchangeMoneyPageState();
}

class _ExchangeMoneyPageState extends State<ExchangeMoneyPage> {
  String selectedMethod = 'gopay';
  final TextEditingController nominalController = TextEditingController(text: '10000');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tukar Uang'), backgroundColor: Colors.transparent, elevation: 0, foregroundColor: Colors.black87),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const SizedBox(height: 12),
          _buildPointsBox(),
          const SizedBox(height: 18),
          Row(children: [
            _paymentMethodTile('assets/images/gopay.png', 'gopay'),
            const SizedBox(width: 12),
            _paymentMethodTile('assets/images/dana.png', 'dana'),
            const SizedBox(width: 12),
            _paymentMethodTile('assets/images/ovo.png', 'ovo'),
          ]),
          const SizedBox(height: 18),
          const Text('Nominal', style: TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          TextField(
            controller: nominalController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              hintText: 'Rp 10.000',
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
            ),
          ),
          const Spacer(),
          Row(
            children: [
              Expanded(
                child: Text('Total Penukaran\nRp ${nominalController.text}', style: const TextStyle(fontWeight: FontWeight.w600)),
              ),
              ElevatedButton(
                onPressed: _onTapTukar,
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF6B8E5F), padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 22), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                child: const Text('Tukar'),
              )
            ],
          ),
          const SizedBox(height: 24),
        ]),
      ),
    );
  }

  Widget _buildPointsBox() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(color: const Color(0xFF6B8E5F), borderRadius: BorderRadius.circular(12)),
      child: Row(children: [
        const Icon(Icons.monetization_on, color: Colors.white),
        const SizedBox(width: 8),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('Poin Tersedia', style: TextStyle(color: Colors.white)),
          const SizedBox(height: 4),
          Text(widget.initialPoints.toString(), style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18))
        ]),
      ]),
    );
  }

  Widget _paymentMethodTile(String img, String key) {
    final bool selected = selectedMethod == key;
    return Expanded(
      child: InkWell(
        onTap: () => setState(() => selectedMethod = key),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: selected ? const Color(0xFFEFFDEA) : Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: selected ? const Color(0xFF2DAA45) : Colors.grey.shade200),
          ),
          child: Center(child: Image.asset(img, height: 28)),
        ),
      ),
    );
  }

  void _onTapTukar() {
    final nominal = int.tryParse(nominalController.text.replaceAll('.', '').replaceAll(',', '')) ?? 0;
    if (nominal <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Masukkan nominal valid')));
      return;
    }

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        content: const Text('Kamu akan menukarkan poin sejumlah nominal yang kamu pilih'),
        actions: [
          OutlinedButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Batal')),
          ElevatedButton(onPressed: () {
            Navigator.of(context).pop();
            widget.onExchangeSuccess(nominal);
            _showSuccess();
          }, child: const Text('Tukar')),
        ],
      ),
    );
  }

  void _showSuccess() {
    showDialog(
      context: context,
      builder: (_) => Center(
        child: Material(
          color: Colors.transparent,
          child: Container(
            width: 180,
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Image.asset('assets/images/check_success.png', width: 66, height: 66),
              const SizedBox(height: 8),
              const Text('Poin Berhasil Ditukar!', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.w600))
            ]),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    nominalController.dispose();
    super.dispose();
  }
}

class VoucherListPage extends StatelessWidget {
  final void Function(int cost) onRedeem;
  VoucherListPage({required this.onRedeem});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Voucher'), backgroundColor: Colors.transparent, elevation: 0, foregroundColor: Colors.black87),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(children: [
          const SizedBox(height: 12),
          _voucherTile(context, 'Gift Voucher Ice Cream', 'assets/images/voucher_icecream.png', 100),
          const SizedBox(height: 12),
          _voucherTile(context, 'Voucher Fashion', 'assets/images/voucher_fashion.png', 200),
        ]),
      ),
    );
  }

  Widget _voucherTile(BuildContext ctx, String title, String img, int cost) {
    return InkWell(
      onTap: () {
        showDialog(
          context: ctx,
          builder: (_) => AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            content: Text('Kamu akan menukarkan $cost poin untuk voucher yang kamu pilih'),
            actions: [
              OutlinedButton(onPressed: () => Navigator.of(ctx).pop(), child: const Text('Batal')),
              ElevatedButton(onPressed: () {
                Navigator.of(ctx).pop();
                onRedeem(cost);
              }, child: const Text('Tukar')),
            ],
          ),
        );
      },
      child: Row(children: [
        ClipRRect(borderRadius: BorderRadius.circular(12), child: Image.asset(img, width: 96, height: 96, fit: BoxFit.cover)),
        const SizedBox(width: 12),
        Expanded(child: Text(title, style: const TextStyle(fontWeight: FontWeight.w600))),
        Column(children: [
          const Icon(Icons.monetization_on, color: Colors.green),
          Text(cost.toString()),
        ])
      ]),
    );
  }
}
