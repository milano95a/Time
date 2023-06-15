//
//  MoreView.swift
//  Time
//
//  Created by Workspace (Abdurakhmon Jamoliddinov) on 15/06/23.
//

import SwiftUI

struct MoreView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        List {
            NavigationLink("Weekly Stats", destination: ListOfWeeklyActivities())
                .padding(EdgeInsets(top: 16, leading: 12, bottom: 16, trailing: 12))
                .fontWeight(.bold)
                .listRowSeparator(.hidden)
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

struct MoreView_Previews: PreviewProvider {
    static var previews: some View {
        MoreView()
    }
}
