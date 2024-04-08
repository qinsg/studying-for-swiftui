//
//  EditMeetupView-ViewModel.swift
//  Meetup
//
//  Created by James Qin on 2024/3/25.
//

import Foundation
import Observation

extension EditMeetupView {
    @Observable
    class ViewModel {
        private(set) var meetups: [Meetup]
        
        init(meetups: [Meetup]) {
            self.meetups = meetups
        }
    }
}
