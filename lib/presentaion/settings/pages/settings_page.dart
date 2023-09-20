import 'package:bloc_input_valueobject/domain/core/errors/failures.dart';
import 'package:bloc_input_valueobject/domain/settings/entities/color.dart'
    as e_color;
import 'package:bloc_input_valueobject/domain/settings/entities/interval.dart'
    as e_interval;
import 'package:bloc_input_valueobject/domain/settings/entities/token.dart'
    as e_token;
import 'package:bloc_input_valueobject/presentaion/settings/bloc/settings_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/styles/app_styles.dart';

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
    return BlocConsumer<SettingsBloc, SettingsState>(
        listener: (context, state) {
      switch (state) {
        case SettingsStateUpdate update:
          if (update.saveRequested) {
            context.read<SettingsBloc>().add(const SettingsEventSaveHandled());

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
    }, builder: (context, state) {
      return switch (state) {
        SettingsStateLoading() => Scaffold(
            appBar: AppBar(
              title: const Text('Settings'),
            ),
            body: const Center(child: CircularProgressIndicator())),
        SettingsStateUpdate(
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
                          context
                              .read<SettingsBloc>()
                              .add(SettingsEventTokenChanged(value: value));
                        },
                        validator: (value) => token.value.fold(
                            (l) => switch (l) {
                                  e_token.TokenFailureEmpty() => 'empty',
                                  e_token.TokenFailureMinimumMaximum() =>
                                    'length must be equal 36',
                                  Failure() => 'unknown failure',
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
                                SettingsEventIntervalChanged(value: value));
                          },
                          validator: (value) => interval.value.fold(
                              (l) => switch (l) {
                                    e_interval.IntervalFailureEmpty() =>
                                      'empty',
                                    e_interval.IntervalFailureParsing() =>
                                      'parsing failure',
                                    e_interval.IntervalFailureMinimum() =>
                                      'fallen below minimum of 1',
                                    e_interval.IntervalFailureMaximum() =>
                                      'maximum of 3600 exceeded',
                                    Failure() => 'unknown failure',
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
                                e_color.ColorFailureEmpty() => 'empty',
                                e_color.ColorFailureParsing() =>
                                  'parsing failure',
                                Failure() => 'unknow failure',
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
                          context
                              .read<SettingsBloc>()
                              .add(SettingsEventColorChanged(value: value));
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
                    context.read<SettingsBloc>().add(const SettingsEventSave());
                  }
                }),
          )
      };
    });
  }
}
