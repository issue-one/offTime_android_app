import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:offTime/blocs/Analytics/analytics_bloc.dart';
import 'package:offTime/blocs/AnalyticsOnline/analytics_online_bloc.dart';
import 'package:offTime/blocs/blocs.dart';

class CrudButtons extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Center(
      child: BlocBuilder<AnalyticsBloc, AnalyticsState>(
        builder: (context, state) {

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ListTile(
                  leading: Icon(Icons.add),
                  title: Text('Upload my data(Create)'),
                  onTap: () {
                    if (state is AnalyticsLoaded) {
                     // BlocProvider.of<AnalyticsOnlineBloc>(context)
                       //   .add(CreateOnlineAnalysisTapped(state.appUsages));
                      BlocProvider.of<AnalyticsOnlineBloc>(context).add(CreateOnlineAnalysisTapped());
                    }
                  },
                ),
                ListTile(
                  leading: Icon(Icons.wysiwyg),
                  title: Text('Load History(Read)'),
                  onTap: ()=>BlocProvider.of<AnalyticsOnlineBloc>(context).add(ReadOnlineAnalysisTapped()),
                ),
                ListTile(
                  leading: Icon(Icons.refresh),
                  title: Text('Refresh(Update)'),
                  //onTap: ()=>,
                ),
                ListTile(
                  leading: Icon(Icons.delete),
                  title: Text('Delete my data'),
                  onTap: ()=>BlocProvider.of<AnalyticsOnlineBloc>(context).add(DeleteOnlineAnalysisTapped()),
                ),
                BlocBuilder<AnalyticsOnlineBloc,AnalyticsOnlineState>(
                  builder: (context,state){
                    if(state is CreateOnlineAnalysisLoaded){
                      return Flushbar(
                        title: 'CREATE SUCCESS!!',
                        message: 'yaayyyy',
                      );
                    } else if(state is CreateOnlineAnalysisLoading){
                      return Flushbar(
                        title: 'Create Online Analysis Loading',
                        message: 'Loading Started',
                      );
                    } else if(state is CreateOnlineAnalysisFailed){
                      return Text('Create Failed');
                    } else if(state is UpdateOnlineAnalysisLoading){
                      return Text('update loading');
                    } else if(state is UpdateOnlineAnalysisFailed){
                      return Text('update failed');
                    } else if(state is UpdateOnlineAnalysisLoaded){
                      return Flushbar(
                        title: 'SUCCESS',
                        message: 'Update worked!',
                      );
                    } else if(state is DeleteOnlineAnalysisLoading){
                      return Text('Delete is loadding');
                    } else if(state is DeleteOnlineAnalysisFailed){
                      return Text('Delete Failed');
                    } else if(state is DeleteOnlineAnalysisLoaded){
                      return Flushbar(
                        title: 'SUCCESS',
                        message: 'Delete Successful',
                      );
                    } else if(state is GetOnlineAnalysisLoading){
                      return Text('Read loading....');
                    } else if(state is GetOnlineAnalysisFailed){
                      return Text('Read failed');
                    } else if(state is GetOnlineAnalysisLoaded){
                      return Text('Read Success');
                    }

                    else{
                      return SizedBox(width: 1,);
                    }
                  },
                )
              ],
            );


        },
      ),
    );
  }
}
