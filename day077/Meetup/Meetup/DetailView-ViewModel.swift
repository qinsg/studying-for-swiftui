//
//  DetailView-ViewModel.swift
//  Meetup
//
//  Created by James Qin on 2024/3/22.
//

import Foundation
import Observation

extension DetailView {
    @Observable
    class ViewModel {
        let meetup: Meetup
        
        init(meetup: Meetup) {
            self.meetup = meetup
        }
    }
}
