import 'package:delivery_app/models/customer_model.dart';
import 'package:delivery_app/screens/AddEditCustomerScreen/add_edit_customer_screen.dart';
import 'package:delivery_app/services/customer_service.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomerDropdown extends StatelessWidget {
  AppCustomer? selectedItem;
  void Function(AppCustomer?)? onChanged;
  CustomerDropdown({super.key, this.selectedItem, this.onChanged});

  final customerService = Get.find<CustomerService>();
  @override
  Widget build(BuildContext context) {
    return DropdownSearch<AppCustomer>(
      items: (f, cs) => customerService.customers,
      selectedItem: selectedItem,
      onChanged: onChanged,
      compareFn: (item1, item2) => item1.phone == item2.phone,
      // filterFn: (item, filter) => item.phone.contains(filter),
      popupProps: PopupProps.menu(
        showSearchBox: true,
        searchDelay: const Duration(milliseconds: 0),
        emptyBuilder: (context, searchEntry) => ListTile(
          title: Text("Add +91 $searchEntry"),
          onTap: () async {
            Get.back();
            final data =
                await Get.toNamed(AddEditCustomerScreen.routeName, arguments: {
              "phone": searchEntry,
              "isEdit": false,
            });

            if (data != null) {
              onChanged?.call(data);
            }
          },
        ),
        fit: FlexFit.loose,
        itemBuilder: (context, item, isDisabled, isSelected) => Column(
          children: [
            ListTile(
              title: Text("${item.name} (+91 ${item.phone})"),
              subtitle: Text(item.address),
            ),
            const Divider(),
          ],
        ),
      ),
      decoratorProps: const DropDownDecoratorProps(
        decoration: InputDecoration(
          label: Text("Select Customer"),
          border: OutlineInputBorder(),
        ),
      ),
      dropdownBuilder: (ctx, selectedItem) {
        if (selectedItem == null) {
          return Container(
            height: 28,
          );
        }
        return ListTile(
          title: Text("${selectedItem.name} (+91 ${selectedItem.phone})"),
          subtitle: Text(selectedItem.address),
        );
      },
    );
  }
}
