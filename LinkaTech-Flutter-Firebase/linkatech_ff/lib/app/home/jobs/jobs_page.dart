// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:linkatech_ff/app/home/job_entries/job_entries_page.dart';
import 'package:linkatech_ff/app/home/jobs/edit_job_page.dart';
import 'package:linkatech_ff/app/home/jobs/empty_content.dart';
import 'package:linkatech_ff/app/home/jobs/job_list_tile.dart';
import 'package:linkatech_ff/app/home/jobs/list_items_builder.dart';
import 'package:linkatech_ff/app/home/models/job.dart';
import 'package:linkatech_ff/common_widgets/platform_alert_dialog.dart';
import 'package:linkatech_ff/common_widgets/platform_exception_alert_dialog.dart';
import 'package:linkatech_ff/services/auth.dart';
import 'package:linkatech_ff/services/database.dart';
import 'package:provider/provider.dart';

class JobsPage extends StatelessWidget {
  Future<void> _signOutAnonimo(BuildContext context) async {
    try {
      final auth = Provider.of<AuthBase>(context);
      await auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _confirmSignOut(BuildContext context) async {
    final didRequestSignOut = await PlatformAlertDialog(
      title: 'Sair',
      content: 'Confirma logoff?',
      cancelActionText: 'Cancelar',
      defaultActionText: 'Sair',
    ).show(context);
    if (didRequestSignOut == true) {
      _signOutAnonimo(context);
    }
  }

  Future<void> _delete(BuildContext context, Job job) async {
    try {
      final database = Provider.of<Database>(context);
      await database.deleteJob(job);
    } on PlatformException catch (e) {
      PlatformExceptionAlertDialog(
        title: 'Erro',
        exception: e,
      ).show(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jobs'),
        actions: <Widget>[
          FlatButton(
            child: Text(
              'Sair',
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.white,
              ),
            ),
            onPressed: () => _confirmSignOut(context),
          ),
        ],
      ),
      body: _buildContents(context),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () =>
            EditJobPage.show(context, database: Provider.of<Database>(context)),
      ),
    );
  }

  Widget _buildContents(BuildContext context) {
    final database = Provider.of<Database>(context);
    return StreamBuilder<List<Job>>(
      stream: database.jobsStream(),
      builder: (context, snapshot) {
        return ListItemsBuilder<Job>(
          snapshot: snapshot,
          itemBuilder: (context, job) => Dismissible(
            key: Key('job-${job.id}'),
            background: Container(color: Colors.red),
            direction: DismissDirection.endToStart,
            onDismissed: (direction) => _delete(context, job),
            child: JobListTile(
              job: job,
              onTap: () => JobEntriesPage.show(context, job),
            ),
          ),
        );
      },
    );
  }
}
