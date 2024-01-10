import 'package:silver_super_app/custom_toon/custom_toon.dart';

import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'installing_view_model.dart';
export 'installing_view_model.dart';

class InstallingViewWidget extends StatefulWidget {
  const InstallingViewWidget({
    Key? key,
    required this.url,
    required this.appName,
  }) : super(key: key);

  final String? url;
  final String? appName;

  @override
  _InstallingViewWidgetState createState() => _InstallingViewWidgetState();
}

class _InstallingViewWidgetState extends State<InstallingViewWidget> {
  late InstallingViewModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => InstallingViewModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      //await Future.delayed(const Duration(milliseconds: 3000));
      var path = await checkPermission(widget.url);
      setState(() {
        FFAppState().addToInstalledList(path);
      });
      setState(() {
        _model.msg = 'Finished!';
      });
    });
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Align(
      alignment: AlignmentDirectional(0.0, 0.0),
      child: Container(
        width: MediaQuery.sizeOf(context).width * 0.7,
        height: 200.0,
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).secondaryBackground,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.downloading_rounded,
                color: FlutterFlowTheme.of(context).secondaryText,
                size: 56.0,
              ),
              Text(
                _model.msg,
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                      fontFamily: 'Space Grotesk',
                      fontSize: 24.0,
                    ),
              ),
              if (_model.msg == 'Finished!')
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 0.0),
                  child: FFButtonWidget(
                    onPressed: () async {
                      //context.goNamed('HomePage');
                      context.pushReplacementNamed('HomePage');
                    },
                    text: 'Success',
                    options: FFButtonOptions(
                      height: 40.0,
                      padding:
                          EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                      iconPadding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                      color: FlutterFlowTheme.of(context).success,
                      textStyle:
                          FlutterFlowTheme.of(context).titleSmall.override(
                                fontFamily: 'Space Grotesk',
                                color: Colors.white,
                              ),
                      elevation: 3.0,
                      borderSide: BorderSide(
                        color: Colors.transparent,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
