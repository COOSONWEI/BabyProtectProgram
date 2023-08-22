//
//  OutDoorMainView.swift
//  BabayProtectProgram
//
//  Created by 韦小新 on 2023/8/12.
//

import SwiftUI
import MapKit


//先用自己的手机的Location 先进行测试一下
struct OutDoorMainView: View {
    
    @State var back = false
//    @StateObject private var locationModel = LocationModel()
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
    
    @State var showNavBar = true
    
    
    //it's test data
    var locations = [
            Location(name: "Location 1", coordinate: CLLocationCoordinate2D(latitude: 31.145506764721492, longitude: 121.31609839130479)),
            Location(name: "Location 2", coordinate: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4294)),
            // Add more locations...
        ]
    
    var body: some View {
        ZStack{

            LocationMapView(streeName: streeName, childLocation: lastLocation, mapViewWrapper: mapVieWrappr, zoomState: $zoomState, zoomChild: $zoomChild,byWalking: $walking,byCar: $byCar,byBus: $byBus)
            .ignoresSafeArea()
            .alert(isPresented: $isNill) {
                Alert(title: Text("提示"), message: Text("请在Watch端打开“守护”App进行第一次数据同步"))
            }
        
        
            VStack{
                HStack(alignment:.center){
                    Button {
                        back.toggle()
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
                    OutDoorFunctionView(zoomLocation: $zoomState,zoomChild: $zoomChild,locatinoModel: locationVM)
                        .padding(.top,28)
                }
                .padding(.trailing)
                
                Spacer()
            }
            
            //MARK: 地图导航界面
//            VStack{
//                Spacer()
//                if showNavBar {
//                    OutDoorFunctionsView(mapView: mapVieWrappr, childLocation: lastLocation, walking: $walking, bus: $byBus, car: $byCar)
//                    .frame(height: 200)
//                    .background(Color.white)
//                    .transition(.move(edge: .bottom))
//                }
//            }
//            .gesture(
//                DragGesture()
//                    .onChanged { value in
//                        if value.translation.height < -50 {
//                            withAnimation {
//                                showNavBar = true
//                            }
//                        } else if value.translation.height > 50 {
//                            withAnimation {
//                                showNavBar = false
//                            }
//                        }
//                    }
//            )
           
    
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
        .fullScreenCover(isPresented: $back) {
            CustomTabView()
        }
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
    
    @Binding var byWalking: Bool
    @Binding var byCar: Bool
    @Binding var byBus: Bool
    
  
    
    let geofencations = [
        GeoFencingViewModel(coordinate: CLLocationCoordinate2D(latitude: 37.3349285, longitude: -122.011033), radius: 1000, identifier: "Apple", note: "Enter", eventType: .onEnter)
    ]
    
    func makeUIViewController(context: Context) -> some UIViewController {
        let view = UIViewController()
       
        context.coordinator.viewController = view
        context.coordinator.mapView = mapViewWrapper.mapVew
        context.coordinator.checkIfLocationServiesIsEnabled()
        context.coordinator.addRadiusOverlay(forGeotification: geofencations)
        
        context.coordinator.checkLocationAuthorization()
        context.coordinator.loadUI()
        context.coordinator.addChildAnnotaion(childLocation: childLocation.lastCoordinate.center)
      
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
        
        if byBus {
            context.coordinator.navigationFunction(transportation: .transit, yourLocation: context.coordinator.mapView.userLocation.coordinate,childLocation: childLocation.lastCoordinate.center)
        }else{
            context.coordinator.mapView.removeOverlays(context.coordinator.mapView.overlays )
        }
        
        if byCar {
            context.coordinator.navigationFunction(transportation: .automobile, yourLocation: context.coordinator.mapView.userLocation.coordinate,childLocation: childLocation.lastCoordinate.center)
        }else {
            context.coordinator.mapView.removeOverlays(context.coordinator.mapView.overlays )
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
