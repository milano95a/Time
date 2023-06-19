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
        NavigationStack {
            ZStack {
                ZStack {
                    list
                    Color.clear
                }
                ZStack(alignment: .bottom) {
                    HStack(spacing: 0) {
                        moreButton
                        createActivity
                    }
                    Color.clear
                }
            }
            .background(.black)
        }
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
                .background(vm.newActivityName.isEmpty ? Color.gray : Color.green2)
                .cornerRadius(16)
                .foregroundColor(.white)
                .fontWeight(.bold)
                .disabled(vm.newActivityName.isEmpty)
            }
            .padding(EdgeInsets(top: .zero, leading: 8, bottom: 12, trailing: 12))
//            .background(.yellow)
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
                .background(Color.red2)
                .cornerRadius(16)
            })
            .padding(EdgeInsets(top: .zero, leading: 8, bottom: 12, trailing: 12))
        }
    }
    
    var moreButton: some View {
        ZStack {
            NavigationLink("more", destination: MoreView())
                .padding()
                .background(Color.blue1)
                .cornerRadius(16)
                .foregroundColor(.white)
                .fontWeight(.bold)
        }
        .padding(EdgeInsets(top: .zero, leading: 12, bottom: 12, trailing: .zero))
//        .background(.green)
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
