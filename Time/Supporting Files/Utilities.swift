//
//  Utilities.swift
//  Time
//
//  Created by Workspace (Abdurakhmon Jamoliddinov) on 15/06/23.
//

import Foundation

func formattedTime(_ duration: Int64) -> String {
    if duration < 60 {
        if duration < 2 {
            return "\(duration) minute"
        } else {
            return "\(duration) minutes"
        }
    }
    let hours = duration / 60
    let minutes = duration - hours * 60
    if hours < 2 {
        if minutes < 2 {
            return "\(hours) hour \(minutes) minute"
        } else {
            return "\(hours) hour \(minutes) minutes"
        }
    } else {
        if minutes < 2 {
            return "\(hours) hours \(minutes) minute"
        } else {
            return "\(hours) hours \(minutes) minutes"
        }
    }
}

func formattedTime(_ duration: Int) -> String {
    if duration < 60 {
        if duration < 2 {
            return "\(duration) minute"
        } else {
            return "\(duration) minutes"
        }
    }
    let hours = duration / 60
    let minutes = duration - hours * 60
    if hours < 2 {
        if minutes < 2 {
            return "\(hours) hour \(minutes) minute"
        } else {
            return "\(hours) hour \(minutes) minutes"
        }
    } else {
        if minutes < 2 {
            return "\(hours) hours \(minutes) minute"
        } else {
            return "\(hours) hours \(minutes) minutes"
        }
    }
}
