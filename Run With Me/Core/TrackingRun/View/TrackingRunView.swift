//
//  TrackingRunView.swift
//  Run With Me
//
//  Created by Phạm Minh Khuê on 14/03/2023.
//

import SwiftUI
import CoreLocation

struct TrackingRunView : View {
    @Environment(\.scenePhase) var scenePhase
    @StateObject var vm = ViewModel()
    @AppStorage("launchedBefore") var launchedBefore = false
    @State var welcome = false
    
    var body: some View {
        ZStack(alignment: .bottom) {
            MapView()
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                Blur()
                    .ignoresSafeArea()
                Spacer()
                    .layoutPriority(1)
            }
            
            VStack(spacing: 10) {
                Spacer()
                if let workout = vm.selectedWorkout {
                    WorkoutBar(workout: workout, new: false)
                }
                FloatingButtons()
                if vm.recording {
                    WorkoutBar(workout: vm.newWorkout, new: true)
                }
            }
            .padding(10)
        }
        .animation(.default, value: vm.recording)
        .animation(.default, value: vm.selectedWorkout)
        .alert(vm.error.rawValue, isPresented: $vm.showErrorAlert) {} message: {
            Text(vm.error.message)
        }
        .onAppear {
            if !launchedBefore {
                launchedBefore = true
                welcome = true
            }
        }
        .fullScreenCover(isPresented: $vm.healthUnavailable) {
            ErrorView(systemName: "heart.slash", title: "Health Unavailable", message: "\(NAME) needs access to the Health App to store and load workouts. Unfortunately, this device does not have these capabilities so the app will not work.")
        }
        .sheet(isPresented: $vm.showPermissionsView) {
            PermissionsView()
        }
        .onChange(of: scenePhase) { newPhase in
            if newPhase == .active {
                vm.updateHealthStatus()
            }
        }
        .environmentObject(vm)
    }
}
