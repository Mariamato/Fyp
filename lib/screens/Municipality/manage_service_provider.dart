import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:municipal_cms/screens/Municipality/provider_widget.dart';

import '../../controllers/service_provider_controller.dart';
import '../../models/service_provider_model.dart';
import 'create_service_provider.dart';

class ManageServiceProvider extends StatefulWidget {
  const ManageServiceProvider({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ManageServiceProviderState createState() => _ManageServiceProviderState();
}

class _ManageServiceProviderState extends State<ManageServiceProvider> {
  List<ServiceProvider> serviceProviders = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchServiceProvidersData();
  }

  void fetchServiceProvidersData() async {
    try {
      List<ServiceProvider> fetchedServiceProviders =
          await fetchServiceProviders();
      setState(() {
        serviceProviders = fetchedServiceProviders;
        isLoading = false;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(
            CupertinoIcons.chevron_back,
            size: 27,
            color: Colors.white,
          ),
        ),
        elevation: 0,
        centerTitle: true,
        title: const Text("Service Providers"),
      ),
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                border: const Border(
                    bottom: BorderSide(color: Colors.blue, width: 1)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Service providers list",
                    style: TextStyle(
                      color: Colors.black87,
                    ),
                  ),
                  Text(serviceProviders.length.toString()),
                ],
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Expanded(
              child: isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : ListView.builder(
                      itemCount: serviceProviders.length,
                      itemBuilder: (context, index) {
                        var serviceP = serviceProviders[index];
                        return ProviderWidget(
                          name: serviceP.name!,
                          email: serviceP.email!,
                          phone: serviceP.phoneNumber!,
                          address: serviceP.address!,
                          municipality: serviceP.municipality!,
                          speciality: 'Waste collection',
                          providerId: serviceP.id!,
                        );
                      },
                    ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () => {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CreateServiceProviderPage()),
            ),
          },
          backgroundColor: Colors.blue,
          child: Icon(
            CupertinoIcons.add,
            color: Colors.white,
          ),
        )
    );
  }
}
