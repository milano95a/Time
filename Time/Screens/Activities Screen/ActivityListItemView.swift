//
//  ActivityListItemView.swift
//  Time
//
//  Created by Workspace (Abdurakhmon Jamoliddinov) on 11/06/23.
//

import SwiftUI

struct ActivityListItemView: View {
    var activity: Activity
    
    var body: some View {
        GeometryReader { geometry in
            VStack (alignment: .leading) {
                if activity.hasEnded {
                    Text(formattedTime(activity.duration))
                        .padding(EdgeInsets(top: 8, leading: 8, bottom: 0, trailing: 0))
                } else {
                    Text(Date(milliseconds: activity.start), style: .timer)
                        .padding(EdgeInsets(top: 8, leading: 8, bottom: 0, trailing: 0))
                }
                Text(activity.name)
                    .font(.system(size: fontSize(activity.duration)))
                    .padding(EdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 0))
            }
            .frame(width: geometry.size.width, height: geometry.size.height, alignment: .topLeading)
            .background(backgroundColor(activity.name))
            .cornerRadius(16)
            .foregroundColor(.white)
            .fontWeight(.bold)
        }
        .frame(height: max(CGFloat(activity.duration) * 2, 80))
        .padding(EdgeInsets(top: 8, leading: 4, bottom: 4, trailing: 4))
    }
    
    private func fontSize(_ duration: Int64) -> CGFloat {
        let numberOfHours = CGFloat(duration) / 60
        let scale: CGFloat = 0.5
        let fontSizeMultiplier = min(numberOfHours, 4)
        return 20 * (1 + fontSizeMultiplier * scale)
    }
    
    private func backgroundColor(_ text: String) -> Color {
        if text.starts(with: "chore") {
            return Color.purple1
        } else if text.starts(with: "work") {
            return Color.green1
        } else if text.starts(with: "fun") {
            return Color.blue2
        } else {
            return Color.red1
        }
    }
}


































struct ActivityListItemView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityListItemView(activity: Activity())
    }
}
