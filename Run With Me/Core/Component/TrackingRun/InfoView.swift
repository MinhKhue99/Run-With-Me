//
//  InfoView.swift
//  Run With Me
//
//  Created by Phạm Minh Khuê on 15/03/2023.
//

import SwiftUI

struct InfoView: View {
    @Environment(\.dismiss) var dismiss
    @State var showShareSheet = false
    
    let welcome: Bool
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 0) {
                VStack(spacing: 0) {
                    Image("logo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 70, height: 70)
                        .cornerRadius(15)
                        .padding(.bottom)
                    Text((welcome ? "Welcome to\n" : "") + NAME)
                        .font(.largeTitle.bold())
                        .multilineTextAlignment(.center)
                        .padding(.bottom, 5)
                    if !welcome {
                        Text("Version " + (Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""))
                            .foregroundColor(.secondary)
                    }
                }
                .horizontallyCentred()
                .padding(.bottom, 30)
                
                InfoRow(systemName: "map", title: "Browse all your Routes", description: "See all your routes stored in the Health App on one map.")
                InfoRow(systemName: "record.circle", title: "Record Workouts", description: "Record runs, walks and cycles and see your route update live.")
                InfoRow(systemName: "line.3.horizontal.decrease.circle", title: "Filter Workouts", description: "Filter the workouts shown on the map by date and type.")
                Spacer()
                
                if welcome {
                    Button {
                        dismiss()
                    } label: {
                        Text("Continue")
                            .bigButton()
                    }
                }
            }
            .padding()
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    if !welcome {
                        Button {
                            dismiss()
                        } label: {
                            DismissCross()
                        }
                        .buttonStyle(.plain)
                    }
                }
                ToolbarItem(placement: .principal) {
                    if welcome {
                        Text("")
                    } else {
                        DraggableBar()
                    }
                }
            }
        }
        .shareSheet(url: URL(string: "https://apps.apple.com/app/id1581278416")!, isPresented: $showShareSheet)
        .interactiveDismissDisabled(welcome)
    }
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        Text("")
            .sheet(isPresented: .constant(true)) {
                InfoView(welcome: true)
            }
    }
}

struct InfoRow: View {
    let systemName: String
    let title: String
    let description: String
    
    var body: some View {
        HStack {
            Image(systemName: systemName)
                .font(.title)
                .foregroundColor(.accentColor)
                .frame(width: 50, height: 50)
            VStack(alignment: .leading) {
                Text(title)
                    .font(.headline)
                Text(description)
                    .foregroundColor(.secondary)
            }
        }
        .padding(.vertical)
    }
}
