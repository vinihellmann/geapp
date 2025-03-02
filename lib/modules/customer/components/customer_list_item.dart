import 'package:flutter/material.dart';
import 'package:geapp/modules/customer/models/customer_model.dart';
import 'package:geapp/modules/customer/providers/customer_form_provider.dart';
import 'package:geapp/modules/customer/providers/customer_list_provider.dart';
import 'package:geapp/routes/routes.dart';
import 'package:geapp/themes/color.dart';
import 'package:geapp/themes/text.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class CustomerListItem extends StatefulWidget {
  const CustomerListItem({super.key, required this.item, this.onClick});

  final CustomerModel item;
  final void Function(CustomerModel c)? onClick;

  @override
  State<CustomerListItem> createState() => _CustomerListItemState();
}

class _CustomerListItemState extends State<CustomerListItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _sizeAnimation;

  bool isExpanded = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _sizeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
  }

  void toggleExpansion() {
    setState(() {
      isExpanded = !isExpanded;
      isExpanded ? _controller.forward() : _controller.reverse();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.read<CustomerListProvider>();
    return InkWell(
      onTap: () async {
        if (widget.onClick != null) {
          widget.onClick!(widget.item);
          context.pop();
          return;
        }

        await context.read<CustomerFormProvider>().setEdit(widget.item);
        if (context.mounted) {
          final needUpdate = await context.push(Routes.customerForm);
          if (needUpdate == true) provider.getData();
        }
      },
      child: Container(
        decoration: BoxDecoration(color: TColor.background.light),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              iconColor: TColor.primary.light,
              contentPadding: const EdgeInsets.fromLTRB(20, 5, 10, 5),
              title: Text(
                widget.item.name?.toUpperCase() ?? "",
                style: TText.ml,
                overflow: TextOverflow.ellipsis,
              ),
              subtitle: Text(
                widget.item.cnpj ?? widget.item.cpf ?? "",
                style: TText.xs,
              ),
              trailing: IconButton(
                onPressed: toggleExpansion,
                icon: Icon(
                  isExpanded
                      ? Icons.expand_less_outlined
                      : Icons.expand_more_outlined,
                  color: TColor.primary.light,
                ),
              ),
            ),
            ClipRect(
              child: AnimatedBuilder(
                animation: _sizeAnimation,
                builder: (context, child) {
                  return Align(
                    heightFactor: _sizeAnimation.value,
                    alignment: Alignment.topLeft,
                    child: child,
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (widget.item.addressName != null)
                        Text(
                          "Endereço: ${widget.item.addressName}",
                          style: TText.sm,
                        ),
                      if (widget.item.addressNeighborhood != null)
                        Text(
                          "Bairro: ${widget.item.addressNeighborhood}",
                          style: TText.sm,
                        ),
                      if (widget.item.addressNumber != null)
                        Text(
                          "Número: ${widget.item.addressNumber}",
                          style: TText.sm,
                        ),
                      Text(
                        "Cidade: ${widget.item.addressCity}/${widget.item.addressUF}",
                        style: TText.sm,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
