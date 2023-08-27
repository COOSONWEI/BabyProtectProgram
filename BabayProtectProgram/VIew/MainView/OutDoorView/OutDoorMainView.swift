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
    
    //it's test data
    var locations = [
            Location(name: "Location 1", coordinate: CLLocationCoordinate2D(latitude: 31.145506764721492, longitude: 121.31609839130479)),
            Location(name: "Location 2", coordinate: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4294)),
            // Add more locations...
        ]
    
    var body: some View {
       
            ZStack{
                LocationMapView(streeName: streeName, childLocation: lastLocation, mapViewWrapper: mapVieWrappr, zoomState: $zoomState, zoomChild: $zoomChild, jumptotheLocation: $jumptotheLocation,byWalking: $walking,byCar: $byCar,byBus: $byBus)
                    .edgesIgnoringSafeArea(.top)
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
                        OutDoorFunctionView(zoomLocation: $zoomState,zoomChild: $zoomChild,locatinoModel: locationVM){
                            openMapsNavigation(destination: lastLocation.lastCoordinate.center)
                        }
                            .padding(.top,28)
                    }
                    .padding(.trailing)
                    
                    HStack{
                        Spacer()
                        Button {
                            showNavBar.toggle()
                        } label: {
                            ZStack{
                                
                                Capsule()
                                    .foregroundColor(.white)
                                    .shadow(radius: 5)
                                    .frame(maxWidth: 40,maxHeight: 40)
                               
                                Image(systemName: showNavBar ? "arrow.down.right.and.arrow.up.left" : "arrow.up.left.and.arrow.down.right")
                                    .resizable()
                                    .fixedSize()
                                    .foregroundColor(Color(red: 108/255, green: 108/255, blue: 108/255))
                            }
                           
                            
                        }
                    }
                    .padding(.trailing)
                   

                
                    Spacer()
                    
                    
                  

                }
                
                //MARK: 地图导航界面
              
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
    //            locationVM.fetchPolling()
            })
        
            .sheet(isPresented: $showNavBar, content: {
                DanagerousListView(jumptotheLocation: $jumptotheLocation)
                .background(Color.white)
                .transition(.move(edge: .bottom))
                .presentationDetents([.height(300)])
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
    @Binding var byWalking: Bool
    @Binding var byCar: Bool
    @Binding var byBus: Bool
    
    let geofencations = [
      
        GeoFencingViewModel(coordinate: CLLocationCoordinate2D(latitude:  31.23856, longitude: 121.50623), radius: 100, identifier: "lujiazui", note: "Enter", eventType: .onEnter)
    ]
    


    
    let geos = [
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
    
        ]
    ]
    
    func makeUIViewController(context: Context) -> some UIViewController {
        let view = UIViewController()
       
        context.coordinator.viewController = view
        context.coordinator.mapView = mapViewWrapper.mapVew
        context.coordinator.checkIfLocationServiesIsEnabled()
        context.coordinator.addChildAnnotaion(childLocation: childLocation.lastCoordinate.center)
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
            context.coordinator.addGeoAnnotation(geoLocaiton: geofencations[0].coordinate)
            context.coordinator.zoomToDanagerousLocation(location: geofencations[0])
//            context.coordinator.addRadiusOverlay(forGeotification: geofencations)
            
            
        }
        
        if byBus {
            context.coordinator.navigationFunction(transportation: .transit, yourLocation: context.coordinator.mapView.userLocation.coordinate,childLocation: childLocation.lastCoordinate.center)
        }
        
        if byCar {
            context.coordinator.navigationFunction(transportation: .automobile, yourLocation: context.coordinator.mapView.userLocation.coordinate,childLocation: childLocation.lastCoordinate.center)
        }
        
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
