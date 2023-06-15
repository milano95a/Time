//
//  DailyAcitivityView.swift
//  Time
//
//  Created by Workspace (Abdurakhmon Jamoliddinov) on 09/06/23.
//

import SwiftUI


struct ListOfAcitivitiesView: View {
    @EnvironmentObject var vm: ListOfAcitivitiesViewModel
    
    var body: some View {
        ZStack {
            ZStack {
                list
                Color.clear
            }
            ZStack(alignment: .bottom) {
                createActivity
                Color.clear
            }
        }
        .background(.black)
    }
    
    @ViewBuilder
    var list: some View {
        if vm.activities.isEmpty {
            Color.clear
        } else {
            List(vm.activities.freeze()) { activity in
                ActivityListItemView(activity: activity)
                    .listRowSeparator(.hidden)
                    .listRowInsets(EdgeInsets())
                    .listRowBackground(Color.clear)
                    .swipeActions {
                        Button(action: {
                            vm.delete(activity)
                        }, label: {
                            Image(systemName: "trash")
                        }).tint(.clear)
                    }
            }
            .listStyle(.plain)
            .scrollIndicators(.hidden)
        }
    }
    
    let timer = Timer.publish(every: 0.5, on: .main, in: .common).autoconnect()
    @State private var placeholderText = ""
    
    @ViewBuilder
    var createActivity: some View {
        if vm.activities.first?.hasEnded ?? true {
            HStack {
                ZStack(alignment: .topLeading) {
                    if vm.newActivityName.isEmpty {
                        Text(placeholderText)
                            .onReceive(timer) { _ in
                                animatePlaceholder()
                            }
                            .foregroundColor(.gray)
                            .fontWeight(.bold)
                    }
                    TextField("", text: $vm.newActivityName)
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .textInputAutocapitalization(.never)

                }
                .padding()
                .background(.black)
                .cornerRadius(16)
                
                Button("start", action: {
                    vm.startActivity()
                })
                .padding()
                .background(Color.blue1)
                .cornerRadius(16)
                .foregroundColor(.white)
                .fontWeight(.bold)
            }
            .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
        } else {
            Button(action: {
                vm.stopActivity()
            }, label: {
                HStack {
                    Spacer()
                    Text("finish")
                    Spacer()
                }
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding()
                .background(Color.blue1)
                .cornerRadius(16)
            })
            .padding()
        }
    }
    
    private func animatePlaceholder() {
        
        // animation 2
        if placeholderText.count == 0 {
            placeholderText = "."
        } else if placeholderText.count == 1 {
            placeholderText = ".."
        } else if placeholderText.count == 2 {
            placeholderText = "..."
        } else {
            placeholderText = ""
        }
    }
}







































struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ListOfAcitivitiesView()
            .environmentObject(ListOfAcitivitiesViewModel())
    }
}
