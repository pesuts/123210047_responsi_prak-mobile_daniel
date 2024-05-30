import 'package:flutter/material.dart';
import 'package:responsi_123210047/view/DetailAgentView.dart';

import '../api/ApiRoute.dart';
import '../model/AgentModel.dart';
import 'ListMapView.dart';

class ListAgentView extends StatefulWidget {
  // const _({super.key});
  // CategoriesView({Key? key});
  ListAgentView({Key? key}) : super(key: key);

  @override
  State<ListAgentView> createState() => _ListAgentView();
}

class _ListAgentView extends State<ListAgentView> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Agents",
            style: TextStyle(
                color: Colors.white
            ),
          ),
          backgroundColor: Colors.redAccent[200],
        ),
        body: _buildCategories(),
    );
  }

  Widget _buildCategories(){
    return Container(
      child: FutureBuilder(
        future: ApiRoute.loadAgents(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return _buildLoading();
          }
          else if (snapshot.hasError){
            return _buildError();
          }
          else if (snapshot.hasData){
            if (snapshot.data == null) {
              return _buildError();
            }
            try{
              AgentModel agentModel = AgentModel.fromJson(snapshot.data);
              if (agentModel.data == null || agentModel.data!.isEmpty) {;
                print("null categories");
                return _buildError();
              }
              return _buildSuccess(agentModel);
            } catch (e) {
              return _buildError();
            }
          } else return _buildError();
        }
      ),
    );
  }

  Widget _buildSuccess(AgentModel agentModel){
    return ListView.builder(
      itemCount: agentModel!.data!.length,
      itemBuilder: (context, index) => AgentItem(agent: agentModel.data! [index]),
    );
  }

  Widget _buildError() {
    return Text("Error");
  }

  Widget _buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}

class AgentItem extends StatelessWidget {
  final Agents agent;

  AgentItem({Key? key, required this.agent});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.brown[200],
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: (){
          Navigator.push(context,
              MaterialPageRoute(
                  builder: (context) => DetailAgentView(uuid: agent.uuid ?? "", name: ("${agent.displayName} ${agent
              .developerName}")),
              )
          );
        },
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Row(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(5),
                child: Image.network(
                  agent.displayIcon ?? "",
                  height: 100,
                  width: 100,
                  // width: double.infinity * 0.8,
                  // fit: BoxFit.cover,
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Text(
                  "${agent.displayName} ${agent.developerName}"  ?? "",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              // Padding(
              //   padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              //   child: Text(category.strCategoryDescription ?? ""),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

