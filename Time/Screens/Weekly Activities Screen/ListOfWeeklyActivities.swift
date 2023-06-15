//
//  ListOfWeeklyActivities.swift
//  Time
//
//  Created by Workspace (Abdurakhmon Jamoliddinov) on 15/06/23.
//

import SwiftUI

struct ListOfWeeklyActivities: View {
    @EnvironmentObject var vm: ListOfWeeklyActivitiesViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        List(vm.items) { item in
            Section("Week \(item.date)", content: {
                ForEach(ActivityType.allCases, id: \.self, content: { type in
                    HStack {
                        Text(type.rawValue)
                        Spacer()
                        Text(formattedTime(item.activityDurationByType[type]!))
                    }
                    .listRowSeparator(.hidden)
                    .fontWeight(.bold)
                })
            })
            .padding()
            .background(Color.black1)
            .cornerRadius(16)
        }
        .listStyle(.plain)
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    dismiss()
                }, label: {
                    HStack {
                        Image(systemName: "chevron.backward")
                        Text("Back")
                    }
                    .fontWeight(.bold)
                    .foregroundColor(.white)

                })
            }
        }
    }
}























































struct ListOfWeeklyActivities_Previews: PreviewProvider {
    static var previews: some View {
        ListOfWeeklyActivities()
            .environmentObject(ListOfWeeklyActivitiesViewModel())
    }
}
