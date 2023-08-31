//
//  OutDoorMainView.swift
//  BabayProtectProgram
//
//  Created by 韦小新 on 2023/8/12.
//

import SwiftUI
import MapKit

struct CustomTabsView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            Text("Custom Tab View")
            Button("Back") {
                presentationMode.wrappedValue.dismiss()
            }
        }
    }
}

//先用自己的手机的Location 先进行测试一下
struct OutDoorMainView: View {
//    var locationModel =  LocationManager()
    @Environment(\.presentationMode) var presentationMode
    
    @State var back = false
    
    @StateObject  var locationVM = LocationCloudStroe()
    @StateObject  var lastLocation = LastLocation()
    @StateObject var streeName = StreeName()
    @StateObject var mapVieWrappr = MapViewWrapper()
    @State private var selectedPlace: MKPointAnnotation?
    @State private var showSettings = false
    @State private var isNill = false
    
    @State var zoomState = false
    @State var zoomChild = false
    
    @State var walking = false
    @State var byCar = false
    @State var byBus = false
    
    @State var showNavBar = false
    @State var jumptotheLocation = false
    @State var selected = 0
    //it's test data
    var locations = [
        Location(name: "Location 1", coordinate: CLLocationCoordinate2D(latitude: 31.145506764721492, longitude: 121.31609839130479)),
        Location(name: "Location 2", coordinate: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4294)),
        // Add more locations...
    ]
    
    var body: some View {
        
        ZStack{
            LocationMapView(streeName: streeName, childLocation: lastLocation, mapViewWrapper: mapVieWrappr, zoomState: $zoomState, zoomChild: $zoomChild, jumptotheLocation: $jumptotheLocation, selected: $selected)
                .edgesIgnoringSafeArea(.top)
            //                    .padding(.bottom,60)
            //                    .edgesIgnoringSafeArea(.leading)
            //                    .edgesIgnoringSafeArea(.trailing)
            
                .alert(isPresented: $isNill) {
                    Alert(title: Text("提示"), message: Text("请在Watch端打开“守护”App进行第一次数据同步"))
                }
            
            
          
            VStack{
                HStack(alignment:.center){
                    Button {
                        presentationMode.wrappedValue.dismiss()
                        print("点击了")
                    } label: {
                        Image("backBT")
                            .resizable()
                            .frame(maxWidth: 27, maxHeight: 27)
                            .fixedSize()
                    }
                    
                    LocationView(locationModel: lastLocation,locationCloudStroe: locationVM)
                }
                
                HStack{
                    Spacer()
                    OutDoorFunctionView(zoomLocation: $zoomState,zoomChild: $zoomChild,locatinoModel: locationVM,showNavBar: $showNavBar){
                        openMapsNavigation(destination: lastLocation.lastCoordinate.center)
                    }
                    .padding(.top,28)
                }
                .padding(.trailing)
                
                Spacer()
                
            }
            //MARK: 地图导航界面
            .sheet(isPresented: $showNavBar) {
                DanagerousListView(jumptotheLocation: $jumptotheLocation, selectied: $selected)
                    .background(Color.white)
                    .transition(.move(edge: .bottom))
                    .presentationDetents([.height(300)])
                //                    .offset(y: showNavBar ? 1000 : 400)
            }
            
//            Text("Iam enter  === \(String(locationModel.reginLocation.isEnter))")
            
        }
        .task {
            do {
                try await locationVM.fetchRecord()
                print("locationVM.locationRecord.count\(locationVM.locationRecord.count)")
                
                if locationVM.locationRecord.count < 1 {
                    isNill = true
                }else{
                    lastLocation.lastCoordinate = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: Double(locationVM.locationRecord[0].object(forKey: "latitude") as! String) ?? 0.0, longitude: Double(locationVM.locationRecord[0].object(forKey: "longitude") as! String) ?? 0.0), latitudinalMeters: 0.5, longitudinalMeters: 0.5)
                    print( "lastLocation.lastCoordinate\(lastLocation.lastCoordinate)")
                    print("loading successful")
                }
                
            } catch {
                print("loading false")
            }
        }
        .onAppear(perform: {
            locationVM.fetchPolling()

        })
        .navigationBarBackButtonHidden(true)
        
    }
    
    func openMapsNavigation(destination coordinate: CLLocationCoordinate2D) {
        let destinationPlacemark = MKPlacemark(coordinate: coordinate)
        let destinationItem = MKMapItem(placemark: destinationPlacemark)
        destinationItem.name = "您孩子的位置"
    
        let options = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
        MKMapItem.openMaps(with: [destinationItem], launchOptions: options)
    
    }
    
}

struct Location: Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
}


struct LocationMapView: UIViewControllerRepresentable {
    @StateObject var streeName: StreeName
    @StateObject var childLocation: LastLocation
    @StateObject var mapViewWrapper: MapViewWrapper
    @Binding var zoomState: Bool
    @Binding var zoomChild: Bool
    @Binding var jumptotheLocation: Bool
    
    
    @Binding var selected: Int
    
    let geofencations = [
        
//        GeoFencingViewModel(coordinate: CLLocationCoordinate2D(latitude:  31.23856, longitude: 121.50623), radius: 100, identifier: "lujiazui", note: "Enter", eventType: .onEnter),
//        
//        GeoFencingViewModel(coordinate: CLLocationCoordinate2D(latitude: 30.30713, longitude: 120.087473), radius: 40, identifier: "zheda", note: "Enter", eventType: .onEnter),
//        
//        GeoFencingViewModel(coordinate: CLLocationCoordinate2D(latitude: 30.305815, longitude: 120.087226), radius: 50, identifier: "zhe", note: "Enter", eventType: .onEnter),
        
        //最终位置！！！
        GeoFencingViewModel(coordinate: CLLocationCoordinate2D(latitude: 30.305991, longitude: 120.087237), radius: 65, identifier: "zhe", note: "Enter", eventType: .onEnter)
        
        
    ]

    let geos = [[CLLocationCoordinate2D(latitude: 30.30713, longitude: 120.087473)],
        [CLLocationCoordinate2D(latitude: 31.23827, longitude:  121.50628),
         CLLocationCoordinate2D(latitude: 31.23830, longitude:  121.50583),
         CLLocationCoordinate2D(latitude: 31.23817, longitude: 121.50550),
         CLLocationCoordinate2D(latitude: 31.23836, longitude: 121.50555),
         CLLocationCoordinate2D(latitude:  31.23846, longitude: 121.50573),
         CLLocationCoordinate2D(latitude:   31.23846, longitude: 121.50573),
         CLLocationCoordinate2D(latitude:  31.23866, longitude: 121.50578),
         CLLocationCoordinate2D(latitude:   31.23868, longitude: 121.50590),
         CLLocationCoordinate2D(latitude: 31.23924, longitude: 121.50599),
         CLLocationCoordinate2D(latitude:  31.23917, longitude: 121.50610),
         CLLocationCoordinate2D(latitude:     31.23817, longitude: 121.50695),
         CLLocationCoordinate2D(latitude:   31.23813, longitude: 121.50687)
        ],
        [CLLocationCoordinate2D(latitude:   30.302765, longitude: 120.086395),
         CLLocationCoordinate2D(latitude:   30.302918, longitude: 120.086159),
         CLLocationCoordinate2D(latitude:   30.303127, longitude: 120.085875),
         CLLocationCoordinate2D(latitude:   30.303326, longitude: 120.085574),
         CLLocationCoordinate2D(latitude:   30.303562, longitude: 120.085253),
         CLLocationCoordinate2D(latitude:    30.303933, longitude: 120.084963),
         CLLocationCoordinate2D(latitude:    30.304294, longitude:  120.08485),
//         CLLocationCoordinate2D(latitude:   30.308249, longitude: 120.087427),
         CLLocationCoordinate2D(latitude:  30.30478, longitude: 120.084915),
         CLLocationCoordinate2D(latitude:  30.305215, longitude: 120.085097),
         CLLocationCoordinate2D(latitude:  30.305364, longitude: 120.085161),
         CLLocationCoordinate2D(latitude:  30.30554, longitude: 120.085328),
         CLLocationCoordinate2D(latitude:  30.305632, longitude: 120.085467),
         CLLocationCoordinate2D(latitude:  30.305776, longitude: 120.085784),
         CLLocationCoordinate2D(latitude:  30.305817, longitude: 120.085896),
         CLLocationCoordinate2D(latitude:  30.305905, longitude: 120.086068),
         CLLocationCoordinate2D(latitude:30.305919,longitude:120.086143),
         CLLocationCoordinate2D(latitude:30.305961,longitude:120.086256),
         CLLocationCoordinate2D(latitude:30.306049,longitude:120.08654),
         CLLocationCoordinate2D(latitude:30.306114,longitude:120.086669),
         CLLocationCoordinate2D(latitude:30.306327,longitude:120.086953),
         CLLocationCoordinate2D(latitude:30.306563,longitude:120.087141),
         CLLocationCoordinate2D(latitude:30.306836,longitude:120.087211),
         CLLocationCoordinate2D(latitude:30.307355,longitude:120.087259),
         CLLocationCoordinate2D(latitude:30.307892,longitude:120.087522),
         CLLocationCoordinate2D(latitude:30.307767,longitude:120.087423),
         CLLocationCoordinate2D(latitude:30.308152,longitude:120.087583),
//         CLLocationCoordinate2D(latitude:30.308207,longitude:120.087921),
         CLLocationCoordinate2D(latitude:30.308105,longitude:120.087916),
         CLLocationCoordinate2D(latitude:30.307948,longitude:120.087943),
         CLLocationCoordinate2D(latitude:30.3078,longitude:120.087873),
         CLLocationCoordinate2D(latitude:30.307624,longitude:120.087771),
         CLLocationCoordinate2D(latitude:30.307494,longitude:120.087696),
         CLLocationCoordinate2D(latitude:30.307415,longitude:120.087653),
         CLLocationCoordinate2D(latitude:30.307323,longitude:120.087632),
         CLLocationCoordinate2D(latitude:30.307202,longitude:120.0876),
         CLLocationCoordinate2D(latitude:30.306748,longitude:120.0876),
         CLLocationCoordinate2D(latitude:30.306429,longitude:120.087642),
         CLLocationCoordinate2D(latitude:30.306031,longitude:120.087465),
         CLLocationCoordinate2D(latitude:30.305516,longitude:120.087675),
         CLLocationCoordinate2D(latitude:30.305206,longitude:120.088034),
         CLLocationCoordinate2D(latitude:30.3049,longitude:120.088259),
         CLLocationCoordinate2D(latitude:30.30466,longitude:120.08827),
         CLLocationCoordinate2D(latitude:30.304479,longitude:120.088168),
         CLLocationCoordinate2D(latitude:30.303942,longitude:120.087868),
         CLLocationCoordinate2D(latitude:30.303409,longitude:120.087814),
         CLLocationCoordinate2D(latitude:30.30327,longitude:120.08798),
         CLLocationCoordinate2D(latitude:30.303085,longitude:120.08819),
         CLLocationCoordinate2D(latitude:30.302877,longitude:120.088152),
         CLLocationCoordinate2D(latitude:30.302756,longitude:120.088018),
         CLLocationCoordinate2D(latitude:30.301714,longitude:120.088066),
         CLLocationCoordinate2D(latitude:30.30164,longitude:120.088469),
         CLLocationCoordinate2D(latitude:30.301626,longitude:120.088613),
         CLLocationCoordinate2D(latitude:30.30151,longitude:120.088608),
         CLLocationCoordinate2D(latitude:30.301381,longitude:120.088458),
         CLLocationCoordinate2D(latitude:30.301209,longitude:120.088415),
         CLLocationCoordinate2D(latitude:30.301103,longitude:120.088302),
         CLLocationCoordinate2D(latitude:30.301056,longitude:120.088115),
         CLLocationCoordinate2D(latitude:30.300996,longitude:120.087862),
         CLLocationCoordinate2D(latitude:30.300857,longitude:120.087803),
         CLLocationCoordinate2D(latitude:30.300695,longitude:120.087916),
         CLLocationCoordinate2D(latitude:30.300524,longitude:120.087862),
         CLLocationCoordinate2D(latitude:30.300306,longitude:120.087755),
         CLLocationCoordinate2D(latitude:30.300028,longitude:120.087696),
         CLLocationCoordinate2D(latitude:30.300079,longitude:120.087524),
         CLLocationCoordinate2D(latitude:30.300278,longitude:120.087482),
         CLLocationCoordinate2D(latitude:30.300454,longitude:120.08753),
         CLLocationCoordinate2D(latitude:30.300575,longitude:120.08761),
         CLLocationCoordinate2D(latitude:30.300816,longitude:120.087476),
         CLLocationCoordinate2D(latitude:30.300982,longitude:120.087331),
         CLLocationCoordinate2D(latitude:30.300853,longitude:120.087149),
         CLLocationCoordinate2D(latitude:30.300496,longitude:120.087208),
         CLLocationCoordinate2D(latitude:30.300204,longitude:120.087101),
         CLLocationCoordinate2D(latitude:30.300056,longitude:120.086999),
         CLLocationCoordinate2D(latitude:30.2995,longitude:120.087015),
         CLLocationCoordinate2D(latitude:30.299347,longitude:120.087186),
         CLLocationCoordinate2D(latitude:30.299176,longitude:120.087321),
         CLLocationCoordinate2D(latitude:30.299389,longitude:120.087707),
         CLLocationCoordinate2D(latitude:30.299319,longitude:120.087836),
         CLLocationCoordinate2D(latitude:30.298972,longitude:120.087916),
         CLLocationCoordinate2D(latitude:30.298833,longitude:120.087868),
         CLLocationCoordinate2D(latitude:30.298787,longitude:120.087814),
         CLLocationCoordinate2D(latitude:30.298653,longitude:120.087605),
         CLLocationCoordinate2D(latitude:30.298458,longitude:120.087605),
         CLLocationCoordinate2D(latitude:30.298287,longitude:120.087889),
         CLLocationCoordinate2D(latitude:30.298222,longitude:120.087991),
         CLLocationCoordinate2D(latitude:30.298037,longitude:120.087895),
         CLLocationCoordinate2D(latitude:30.29805,longitude:120.087771),
         CLLocationCoordinate2D(latitude:30.29825,longitude:120.087052),
         CLLocationCoordinate2D(latitude:30.298296,longitude:120.086934),
         CLLocationCoordinate2D(latitude:30.298389,longitude:120.086838),
         CLLocationCoordinate2D(latitude:30.298504,longitude:120.086811),
         CLLocationCoordinate2D(latitude:30.298574,longitude:120.086832),
         CLLocationCoordinate2D(latitude:30.298657,longitude:120.086854),
         CLLocationCoordinate2D(latitude:30.298875,longitude:120.087042),
         CLLocationCoordinate2D(latitude:30.299009,longitude:120.08702),
         CLLocationCoordinate2D(latitude:30.299134,longitude:120.086902),
         CLLocationCoordinate2D(latitude:30.299333,longitude:120.086575),
         CLLocationCoordinate2D(latitude:30.299407,longitude:120.086468),
         CLLocationCoordinate2D(latitude:30.299458,longitude:120.086435),
         CLLocationCoordinate2D(latitude:30.299505,longitude:120.086435),
         CLLocationCoordinate2D(latitude:30.299579,longitude:120.086441),
         CLLocationCoordinate2D(latitude:30.299695,longitude:120.086446),
         CLLocationCoordinate2D(latitude:30.299787,longitude:120.086484),
         CLLocationCoordinate2D(latitude:30.300005,longitude:120.086457),
         CLLocationCoordinate2D(latitude:30.300315,longitude:120.086301),
         CLLocationCoordinate2D(latitude:30.300593,longitude:120.086216),
         CLLocationCoordinate2D(latitude:30.300871,longitude:120.086269),
         CLLocationCoordinate2D(latitude:30.300941,longitude:120.086328),
         CLLocationCoordinate2D(latitude:30.300903,longitude:120.086291),
         CLLocationCoordinate2D(latitude:30.301279,longitude:120.086505),
         CLLocationCoordinate2D(latitude:30.301598,longitude:120.086655),
         CLLocationCoordinate2D(latitude:30.30189,longitude:120.086768),
         CLLocationCoordinate2D(latitude:30.302047,longitude:120.086832),
         CLLocationCoordinate2D(latitude:30.302168,longitude:120.086929),
         CLLocationCoordinate2D(latitude:30.302474,longitude:120.086881),
         CLLocationCoordinate2D(latitude:30.302663,longitude:120.086768),
         CLLocationCoordinate2D(latitude:30.302738,longitude:120.086452)
        ]
    ]
    
    
    
    func makeUIViewController(context: Context) -> some UIViewController {
        let view = UIViewController()
        
        context.coordinator.viewController = view
        context.coordinator.mapView = mapViewWrapper.mapVew
        context.coordinator.checkIfLocationServiesIsEnabled()
        context.coordinator.addChildAnnotaion(childLocation: childLocation.lastCoordinate.center)
        context.coordinator.addRadiusOverlay(forGeotification: geofencations)
        context.coordinator.addPolylineOverlay(forGeotification: geos)
        context.coordinator.checkLocationAuthorization()
        context.coordinator.loadUI()
        
        //        view.view.backgroundColor = .red
        return view
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
        //        context.coordinator.mapView.removeOverlays(context.coordinator.mapView.overlays )
        
        //和SwiftUI中的控件进行交互
        if zoomState {
            context.coordinator.zoomLocation()
        }
        
        if zoomChild {
            print("childLocation: \(childLocation.lastCoordinate.center)")
            context.coordinator.addChildAnnotaion(childLocation: childLocation.lastCoordinate.center)
            context.coordinator.zoomToChildLocation(lastLocation: childLocation)
        }
        
        //绘制路径图，每次重新绘制之前都要删除之前的绘制
        //        if byWalking {
        //            print("walking.....")
        //            let youLocation = context.coordinator.mapView.userLocation.coordinate
        //
        //            context.coordinator.navigationFunction(transportation: .walking,yourLocation: youLocation, childLocation: childLocation.lastCoordinate.center)
        //        }else{
        //            context.coordinator.mapView.removeOverlays(context.coordinator.mapView.overlays )
        //        }
        
        if jumptotheLocation {
            //            30.303794251752088, 120.08726121903197
            context.coordinator.addGeoAnnotation(geoLocaiton: geofencations[selected].coordinate)
            context.coordinator.zoomToDanagerousLocation(location: geofencations[selected])
            //            context.coordinator.addRadiusOverlay(forGeotification: geofencations)
            
            
        }
        
        //        if byBus {
        //            context.coordinator.navigationFunction(transportation: .transit, yourLocation: context.coordinator.mapView.userLocation.coordinate,childLocation: childLocation.lastCoordinate.center)
        //        }
        //
        //        if byCar {
        //            context.coordinator.navigationFunction(transportation: .automobile, yourLocation: context.coordinator.mapView.userLocation.coordinate,childLocation: childLocation.lastCoordinate.center)
        //        }
        
    }
    
    func makeCoordinator() -> MapViewCoordinator {
        MapViewCoordinator(geofencings: geofencations,streeName: streeName)
        
    }
}


struct OutDoorMainView_Previews: PreviewProvider {
    static var previews: some View {
        OutDoorMainView()
    }
}
