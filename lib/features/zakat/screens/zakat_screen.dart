import 'package:flutter/material.dart';
import 'package:flutter_template/features/ads/screens/native_ads.dart';
import 'package:flutter_template/utils/app_color.dart';


class ZakatCalculatorPage extends StatefulWidget {
  @override
  _ZakatCalculatorPageState createState() => _ZakatCalculatorPageState();
}

class _ZakatCalculatorPageState extends State<ZakatCalculatorPage> {
  final TextEditingController goldController = TextEditingController();
  final TextEditingController silverController = TextEditingController();
  final TextEditingController cashOnHandController = TextEditingController();
  final TextEditingController realEstateController = TextEditingController();
  final TextEditingController liabilitiesController = TextEditingController();
  final TextEditingController cashInBankController = TextEditingController();

  double payableZakat = 0.0;

  void calculateZakat() {
    double gold = double.tryParse(goldController.text) ?? 0;
    double silver = double.tryParse(silverController.text) ?? 0;
    double cashOnHand = double.tryParse(cashOnHandController.text) ?? 0;
    double realEstate = double.tryParse(realEstateController.text) ?? 0;
    double liabilities = double.tryParse(liabilitiesController.text) ?? 0;
    double cashInBank = double.tryParse(cashInBankController.text) ?? 0;

    double totalAssets = gold + silver + cashOnHand + realEstate + cashInBank;
    double netWorth = totalAssets - liabilities;

    // Zakat is 2.5% of net worth if it meets nisab threshold
    setState(() {
      payableZakat = netWorth > 0 ? netWorth * 0.025 : 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.primaryColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Zakat Calculator',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  _buildInputField('Total Gold Value', goldController),
                  const SizedBox(height: 5),
                  _buildInputField('Total Silver Value', silverController),
                  const SizedBox(height: 5),
                  _buildInputField('Cash on Hand', cashOnHandController),
                  const SizedBox(height: 5),
                  _buildInputField('Real Estate', realEstateController),
                  const SizedBox(height: 5),
                  _buildInputField('Liabilities', liabilitiesController),
                  const SizedBox(height: 5),
                  _buildInputField('Cash in Bank', cashInBankController),
                  const SizedBox(height: 5),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                    decoration: BoxDecoration(
                      color: AppColor.primaryColor, // Slightly darker teal
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Payable zakat amount :',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          payableZakat.toStringAsFixed(2),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 2),

                  NativeAdWidget()
                ],
              ),
            ),


          ],
        ),
      ),
    );
  }

  Widget _buildInputField(String label, TextEditingController controller) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.only(topRight: Radius.circular(5),bottomRight: Radius.circular(5)),
        border: Border.all(
          color: AppColor.primaryColor,
          width: 2,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 5,
            height: 50,
            color: AppColor.primaryColor,
          ),
          SizedBox(width: 10,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Expanded(
              flex: 2,
              child: Text(
                label,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: TextField(
              controller: controller,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              textAlign: TextAlign.right,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Enter Amount',
                hintStyle: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
              ),
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
              onChanged: (value) {
                calculateZakat(); // Auto-calculate on input change
              },
            ),
          ),
          SizedBox(width: 10,),
        ],
      ),
    );
  }
}
