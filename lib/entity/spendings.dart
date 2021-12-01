import 'dart:core';

import 'entity.dart';

class Spendings extends Entity {
  @override
  Map<String, Object?> toJson() {
    throw UnimplementedError();
  }

  /*String description;
  DateTime date;
  Category category;
  double value;
  DateTime? datePayment;
  int? installment;
  int? totalInstallment;
  bool isPaid = false;

  Spendings(this.date, this.description, this.value, this.category,
      this.datePayment, this.installment, this.totalInstallment) {
    isPaid = datePayment != null ? true : false;
    table = 'spendings';
    //AppDatabase.instance.create(this);
  }

  Spendings.withInstallments(this.date, this.description, this.value,
      this.category, this.installment, this.totalInstallment);
  static int getTotalNumSpendings() {
    int totalSpendings = 0;
    for (int i = 0; i < Category.categories.length; i++) {
      totalSpendings += Category.categories.elementAt(i).spendings.length;
    }
    return totalSpendings;
  }

  @override
  Map<String, Object?> toJson() => {
        '_id': id,
        'description': description,
        'date': date,
        'category_id': category.id,
        'value': value,
        'date_payment': datePayment?.toIso8601String(),
        'n_installments': installment,
        'nt_installments': totalInstallment,
      };
}

class SpendingsPage extends StatefulWidget {
  const SpendingsPage({Key? key}) : super(key: key);
  @override
  _SpendingsPageState createState() => _SpendingsPageState();
}

class _SpendingsPageState extends State<SpendingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: Spendings.getTotalNumSpendings(),
          padding: const EdgeInsets.all(16.0),
          itemBuilder: (context, i) {
            List<Spendings> totalSpendings = <Spendings>[];
            for (int j = 0; j < Category.categories.length; j++) {
              totalSpendings.addAll(Category.categories.elementAt(j).spendings);
            }
            Spendings currentListItem = totalSpendings.elementAt(i);
            return ListTile(
              title: Text(currentListItem.description),
              onLongPress: () {},
            );
          }),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            if (Category.categories.isNotEmpty) {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const AddSpending();
              })).then((_) => setState(() {}));
            } else {
              Fluttertoast.showToast(msg: "Add a category first! ");
            }
          }),
    );
  }
}

class AddSpending extends StatefulWidget {
  const AddSpending({Key? key}) : super(key: key);

  @override
  State<AddSpending> createState() => _AddSpendingState();
}

class _AddSpendingState extends State<AddSpending> {
  DateTime date = DateTime.now();
  String? description;
  double? value;
  Category? category;
  DateTime? paymentDate;
  int? installments;
  int? totalInstallments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Spending")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: const InputDecoration(
                labelText: "Description",
                border: OutlineInputBorder(),
              ),
              onChanged: (desc) {
                description = desc;
              },
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: DropdownButton(
                      isExpanded: true,
                      hint: const Text("Category"),
                      value: category,
                      items: Category.categories.map((category) {
                        return DropdownMenuItem(
                          value: category,
                          child: Text(category.description),
                        );
                      }).toList(),
                      onChanged: (Category? newCategory) {
                        if (newCategory != null) {
                          setState(() {
                            category = newCategory;
                          });
                        }
                      }),
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    decoration: const InputDecoration(
                      labelText: "Value",
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: (val) {
                      value = double.parse(val);
                    },
                  ),
                ),
              ),
            ],
          ),
          Row(
            //mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: OutlinedButton(
                    child: Text(DateFormat.yMd().format(date)),
                    onPressed: () {
                      showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1970),
                        lastDate: DateTime(2041),
                      ).then((datePicked) {
                        if (datePicked != null) {
                          setState(() {
                            date = datePicked;
                          });
                        }
                      });
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: OutlinedButton(
                  child: Text(paymentDate == null
                      ? "Data Pagamento (Opcional)"
                      : DateFormat.yMd().format(paymentDate ?? date)),
                  onPressed: () {
                    showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1970),
                      lastDate: DateTime(2041),
                    ).then((datePicked) {
                      if (datePicked != null) {
                        setState(() {
                          paymentDate = datePicked;
                        });
                      }
                    });
                  },
                ),
              ),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    decoration: const InputDecoration(
                      labelText: "Installments (Optional)",
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: (ins) {
                      installments = int.parse(ins);
                    },
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    decoration: const InputDecoration(
                      labelText: "Total Installments (Optional)",
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: (ins) {
                      totalInstallments = int.parse(ins);
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FloatingActionButton(
              heroTag: "cancel",
              child: const Icon(Icons.cancel),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FloatingActionButton(
              heroTag: "accept",
              child: const Icon(Icons.check),
              onPressed: () {
                if (description != null && value != null) {
                  category?.addSpending(date, description ?? "", value ?? 0,
                      paymentDate, installments, totalInstallments);
                  Navigator.pop(context);
                } else {
                  Fluttertoast.showToast(msg: "Please fill all boxes");
                }
              },
            ),
          ),
        ],
      ),
    );
  }*/
}