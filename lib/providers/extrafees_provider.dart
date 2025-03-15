import 'package:flutter/material.dart';
import 'package:split_receipt/classes/classes.dart';


class ExtraFeesProvider extends ChangeNotifier {
  final ExtraFees _extraFees = ExtraFees(0.0, 0.0, 0.0, 0.0);
  bool taxesAmountLastUpdated = false;
  bool tipAmountLastUpdated = false;
  
  void updateMissingFields(double totalPreFeeCost) {
    if (taxesAmountLastUpdated) {
      updateTaxesAmount(totalPreFeeCost, _extraFees.taxesAmount);
      taxesAmountLastUpdated = true;
    } else {
      updateTaxesPercent(totalPreFeeCost, _extraFees.taxesPercent);
      taxesAmountLastUpdated = false;
    }

    if (tipAmountLastUpdated) {
      updateTipsAmount(totalPreFeeCost, _extraFees.tipAmount);
      tipAmountLastUpdated = true;
    } else {
      updateTipsPercent(totalPreFeeCost, _extraFees.tipPercent);
      tipAmountLastUpdated = false;
    }
  }

  void updateTaxesAmount(double totalPreFeeCost, double newTaxAmount) {
    _extraFees.taxesAmount = newTaxAmount;
    if (totalPreFeeCost != 0.00) {
      _extraFees.taxesPercent = 100.0*newTaxAmount/totalPreFeeCost;
    } else {
      _extraFees.taxesPercent = 0.00;
    }
    taxesAmountLastUpdated = true;
  }

  void updateTaxesPercent(double totalPreFeeCost, double newTaxPercent) {
    _extraFees.taxesPercent = newTaxPercent;
    _extraFees.taxesAmount = totalPreFeeCost*newTaxPercent/100.0;
    taxesAmountLastUpdated = false;
  }

  void updateTipsAmount(double totalPreFeeCost, double newTipAmount) {
    _extraFees.tipAmount = newTipAmount;
    if (totalPreFeeCost != 0.00) {
      _extraFees.tipPercent = 100.0*newTipAmount/totalPreFeeCost;
    } else {
      _extraFees.tipPercent = 0.00;
    }
    tipAmountLastUpdated = true;
  }

  void updateTipsPercent(double totalPreFeeCost, double newTipPercent) {
    _extraFees.tipPercent = newTipPercent;
    _extraFees.tipAmount = totalPreFeeCost*newTipPercent/100.0;
    tipAmountLastUpdated = false;
  }

  ExtraFees get getFees {
    return _extraFees;
  }
}