import 'package:avantrade_webview_generator/common/case.dart';
import 'package:avantrade_webview_generator/presentation/webview/controller/webview_controller.dart';
import 'package:avantrade_webview_generator/presentation/webview/service/response/webview_authcode_response.dart';
import 'package:avantrade_webview_generator/presentation/webview/service/response/webview_b2b2c_response.dart';
import 'package:avantrade_webview_generator/presentation/webview/service/response/webview_b2b_response.dart';
import 'package:avantrade_webview_generator/presentation/webview/service/response/webview_generate_view_response.dart';
import 'package:avantrade_webview_generator/presentation/webview/service/response/webview_validate_token_response.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class WebviewPage extends GetView<WebviewController> {
  const WebviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("TEST"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () {
                controller.model.showDialog(
                  value: controller.model.privateKeySignature,
                  context: context,
                );
              },
              child: Container(
                color: Colors.amber,
                padding: const EdgeInsets.all(8),
                child: const Text("Private Key Generator"),
              ),
            ),
            const SizedBox(height: 30),
            Obx(() {
              final b2bState = controller.model.b2bCase.value;
              return InkWell(
                onTap: () {
                  if (b2bState is LoadedCase) {
                    controller.model.showDialog(
                      value: controller.model.secretKeySignature,
                      context: context,
                    );
                  } else {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return const AlertDialog(
                          title: Text("Error"),
                          content: Text("Need B2B Access Token"),
                        );
                      },
                    );
                  }
                },
                child: Container(
                  color: b2bState is LoadedCase ? Colors.amber : Colors.grey,
                  padding: const EdgeInsets.all(8),
                  child: const Text("Secret Key Generator"),
                ),
              );
            }),
            const SizedBox(height: 30),
            Obx(() {
              final b2bState = controller.model.b2bCase.value;
              return InkWell(
                onTap: () {
                  if (b2bState is LoadedCase) {
                    controller.model.showDialog(
                      value: controller.model.localSecretKeySignature,
                      context: context,
                    );
                  } else {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return const AlertDialog(
                          title: Text("Error"),
                          content: Text("Need B2B Access Token"),
                        );
                      },
                    );
                  }
                },
                child: Container(
                  color: b2bState is LoadedCase ? Colors.amber : Colors.grey,
                  padding: const EdgeInsets.all(8),
                  child: const Text("Local Secret Key Generator"),
                ),
              );
            }),
            const SizedBox(height: 30),
            InkWell(
              onTap: () => controller.getB2b(),
              child: Container(
                color: Colors.blueAccent,
                padding: const EdgeInsets.all(8),
                child: const Text("Start"),
              ),
            ),
            _Body(controller: controller),
          ],
        ),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  final WebviewController controller;
  const _Body({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 5),
        const Divider(),
        const SizedBox(height: 5),
        Obx(() {
          final state = controller.model.b2bCase.value;
          final data = state.data ?? WebviewB2bResponse();
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(children: [
                const Text("B2B Access Token"),
                const SizedBox(width: 5),
                Builder(builder: (context) {
                  if (state is LoadingCase) {
                    return const CircularProgressIndicator();
                  } else {
                    return InkWell(
                      onTap: () {
                        if (state is LoadedCase) {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text("B2B Response"),
                                content: SelectableText(
                                  data
                                      .toMap()
                                      .entries
                                      .map((e) {
                                        return "${e.key} : ${e.value}";
                                      })
                                      .toList()
                                      .join("\n"),
                                ),
                              );
                            },
                          );
                        }
                      },
                      child: Container(
                        color: state is LoadedCase ? Colors.amber : Colors.grey,
                        padding: const EdgeInsets.all(8),
                        child: const Text("Complete Response"),
                      ),
                    );
                  }
                }),
              ]),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                color: Colors.grey,
                child: Builder(builder: (context) {
                  if (state is LoadedCase) {
                    return SelectableText(data.accessToken);
                  } else if (state is ErrorCase) {
                    return Text(state.failure.error);
                  } else {
                    return const Text("No Data");
                  }
                }),
              ),
            ],
          );
        }),
        const SizedBox(height: 15),
        Obx(() {
          final state = controller.model.authCodeCase.value;
          final data = state.data ?? WebviewAuthcodeResponse();
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(children: [
                const Text("Auth Code"),
                const SizedBox(width: 5),
                Builder(builder: (context) {
                  if (state is LoadingCase) {
                    return const CircularProgressIndicator();
                  } else {
                    return InkWell(
                      onTap: () {
                        if (state is LoadedCase) {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text("Auth Code Response"),
                                content: SelectableText(
                                  data
                                      .toMap()
                                      .entries
                                      .map((e) {
                                        return "${e.key} : ${e.value}";
                                      })
                                      .toList()
                                      .join("\n"),
                                ),
                              );
                            },
                          );
                        }
                      },
                      child: Container(
                        color: state is LoadedCase ? Colors.amber : Colors.grey,
                        padding: const EdgeInsets.all(8),
                        child: const Text("Complete Response"),
                      ),
                    );
                  }
                }),
              ]),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                color: Colors.grey,
                child: Builder(builder: (context) {
                  if (state is LoadedCase) {
                    return SelectableText(data.authCode);
                  } else if (state is ErrorCase) {
                    return Text(state.failure.error);
                  } else {
                    return const Text("No Data");
                  }
                }),
              ),
            ],
          );
        }),
        const SizedBox(height: 15),
        Obx(() {
          final state = controller.model.b2b2cCase.value;
          final data = state.data ?? WebviewB2b2cResponse();
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(children: [
                const Text("B2B2C Access Token"),
                const SizedBox(width: 5),
                Builder(builder: (context) {
                  if (state is LoadingCase) {
                    return const CircularProgressIndicator();
                  } else {
                    return InkWell(
                      onTap: () {
                        if (state is LoadedCase) {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text("B2B2C Response"),
                                content: SelectableText(
                                  data
                                      .toMap()
                                      .entries
                                      .map((e) {
                                        return "${e.key} : ${e.value}";
                                      })
                                      .toList()
                                      .join("\n"),
                                ),
                              );
                            },
                          );
                        }
                      },
                      child: Container(
                        color: state is LoadedCase ? Colors.amber : Colors.grey,
                        padding: const EdgeInsets.all(8),
                        child: const Text("Complete Response"),
                      ),
                    );
                  }
                }),
              ]),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                color: Colors.grey,
                child: Builder(builder: (context) {
                  if (state is LoadedCase) {
                    return SelectableText(data.accessToken);
                  } else if (state is ErrorCase) {
                    return Text(state.failure.error);
                  } else {
                    return const Text("No Data");
                  }
                }),
              ),
            ],
          );
        }),
        const SizedBox(height: 15),
        Obx(() {
          final state = controller.model.webViewCase.value;
          final data = state.data ?? WebviewGenerateViewResponse();
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(children: [
                const Text("Webview URL"),
                const SizedBox(width: 5),
                Builder(builder: (context) {
                  if (state is LoadingCase) {
                    return const CircularProgressIndicator();
                  } else {
                    return InkWell(
                      onTap: () {
                        if (state is LoadedCase) {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text("Webview Generate Response"),
                                content: SelectableText(
                                  data
                                      .toMap()
                                      .entries
                                      .map((e) {
                                        return "${e.key} : ${e.value}";
                                      })
                                      .toList()
                                      .join("\n"),
                                ),
                              );
                            },
                          );
                        }
                      },
                      child: Container(
                        color: state is LoadedCase ? Colors.amber : Colors.grey,
                        padding: const EdgeInsets.all(8),
                        child: const Text("Complete Response"),
                      ),
                    );
                  }
                }),
              ]),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                color: Colors.grey,
                child: Builder(builder: (context) {
                  if (state is LoadedCase) {
                    return SelectableText(data.webviewUrl);
                  } else if (state is ErrorCase) {
                    return Text(state.failure.error);
                  } else {
                    return const Text("No Data");
                  }
                }),
              ),
            ],
          );
        }),
        const SizedBox(height: 15),
        Obx(() {
          final state = controller.model.tokenCase.value;
          final data = state.data ?? WebviewValidateTokenResponse();
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(children: [
                const Text("Validate Token Email Response"),
                const SizedBox(width: 5),
                Builder(builder: (context) {
                  if (state is LoadingCase) {
                    return const CircularProgressIndicator();
                  } else {
                    return InkWell(
                      onTap: () {
                        if (state is LoadedCase) {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text("Validate Token Response"),
                                content: SelectableText(
                                  data.data
                                      .toMap()
                                      .entries
                                      .map((e) {
                                        return "${e.key} : ${e.value}";
                                      })
                                      .toList()
                                      .join("\n"),
                                ),
                              );
                            },
                          );
                        }
                      },
                      child: Container(
                        color: state is LoadedCase ? Colors.amber : Colors.grey,
                        padding: const EdgeInsets.all(8),
                        child: const Text("Complete Response"),
                      ),
                    );
                  }
                }),
              ]),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                color: Colors.grey,
                child: Builder(builder: (context) {
                  if (state is LoadedCase) {
                    return SelectableText(data.data.email);
                  } else if (state is ErrorCase) {
                    return Text(state.failure.error);
                  } else {
                    return const Text("No Data");
                  }
                }),
              ),
            ],
          );
        }),
        const SizedBox(height: 15),
      ],
    );
  }
}
