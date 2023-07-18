import 'package:bloc_input_valueobject/domain/value_objects/color/color.dart'
    as value_color;
import 'package:bloc_input_valueobject/domain/value_objects/interval/interval.dart'
    as value_interval;
import 'package:bloc_input_valueobject/domain/value_objects/token/token.dart'
    as value_token;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../config/app_styles.dart';
import '../../../globals.dart';
import '../../bloc/bloc/settings_bloc.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final _formKey = GlobalKey<FormState>();

  final _tokenController = TextEditingController();
  final _intervalController = TextEditingController();

  final _colorOptions = <int>[
    0xFF000000,
    0xFFFF0000,
    0xFF00FF00,
    0xFF0000FF,
  ];

  @override
  void dispose() {
    _tokenController.dispose();
    _intervalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SettingsBloc(
        loadSettingsUseCase: getIt(),
        saveSettingsUseCase: getIt(),
      )..add(const SettingsEvent.load()),
      child: BlocConsumer<SettingsBloc, SettingsState>(
        listener: (context, state) {
          switch (state) {
            case Update update:
              if (update.saveRequested) {
                context
                    .read<SettingsBloc>()
                    .add(const SettingsEvent.saveHandled());

                ScaffoldMessenger.of(context).clearSnackBars();
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(update.saveFailure.fold(
                  () => 'Save success!',
                  (f) => 'Unexpected failure. Please try again.',
                ))));
              }

              if (update.token.isValid()) {
                final value = update.token.getOrThrow();
                if (value != _tokenController.text) {
                  _tokenController.text = value;
                  _tokenController.selection =
                      TextSelection.collapsed(offset: value.length);
                }
              }
              if (update.interval.isValid()) {
                final value = update.interval.getOrThrow().toString();
                if (value != _intervalController.text) {
                  _intervalController.text = value;
                  _intervalController.selection =
                      TextSelection.collapsed(offset: value.length);
                }
              }

              break;
            default:
              break;
          }
        },
        builder: (context, state) {
          return switch (state) {
            Loading() => Scaffold(
                appBar: AppBar(
                  title: const Text('Settings'),
                ),
                body: const Center(child: CircularProgressIndicator())),
            Update(
              token: final token,
              interval: final interval,
              color: final color,
            ) =>
              Scaffold(
                appBar: AppBar(
                  title: const Text('Settings'),
                ),
                body: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Padding(
                          padding: AppStyles.edgeInsetsSmall,
                          child: TextFormField(
                            controller: _tokenController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Token',
                            ),
                            onChanged: (value) {
                              context.read<SettingsBloc>().add(
                                  SettingsEvent.tokenChanged(value: value));
                            },
                            validator: (value) => token.value.fold(
                                (l) => switch (l) {
                                      value_token.Empty() => 'Empty.',
                                      value_token.Length() =>
                                        'Length exceeded.',
                                    },
                                (r) => null),
                          ),
                        ),
                        Padding(
                          padding: AppStyles.edgeInsetsSmall,
                          child: TextFormField(
                              controller: _intervalController,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Interval',
                              ),
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              onChanged: (value) {
                                context.read<SettingsBloc>().add(
                                    SettingsEvent.intervalChanged(
                                        value: value));
                              },
                              validator: (value) => interval.value.fold(
                                  (l) => switch (l) {
                                        value_interval.Empty() => 'Empty.',
                                        value_interval.IsNotInt() =>
                                          'Not an integer.',
                                        value_interval.Min() =>
                                          'Minimum exceeded.',
                                        value_interval.Max() =>
                                          'Maximum exceeded.',
                                      },
                                  (r) => null)),
                        ),
                        DropdownButtonFormField<int>(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Color',
                          ),
                          padding: AppStyles.edgeInsetsSmall,
                          value: color.value.fold((l) => null, (r) => r),
                          validator: (value) => color.value.fold(
                              (l) => switch (l) {
                                    value_color.Empty() => 'Empty.',
                                    value_color.Format() => 'Invalid format.',
                                  },
                              (r) => null),
                          items: _colorOptions
                              .map((e) => DropdownMenuItem<int>(
                                  value: e,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      left: AppStyles.sizeSmall,
                                      right: AppStyles.sizeSmall,
                                    ),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          height: AppStyles.sizeMedium,
                                          width: AppStyles.sizeMedium,
                                          child: CircleAvatar(
                                            backgroundColor: Color(e),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: AppStyles.sizeMedium,
                                        ),
                                        Text(
                                            '0x${e.toRadixString(16).toUpperCase()}'),
                                      ],
                                    ),
                                  )))
                              .toList(),
                          onChanged: (int? value) {
                            if (value != null) {
                              context.read<SettingsBloc>().add(
                                  SettingsEvent.colorChanged(value: value));
                            }
                          },
                        )
                      ],
                    ),
                  ),
                ),
                floatingActionButton: FloatingActionButton(
                    child: const Icon(Icons.save),
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        context
                            .read<SettingsBloc>()
                            .add(const SettingsEvent.save());
                      }
                    }),
              )
          };
        },
      ),
    );
  }
}
