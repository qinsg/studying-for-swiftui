//
//  EditView-ViewModel.swift
//  BucketList
//
//  Created by James Qin on 2024/2/22.
//

import Foundation
import Observation

extension EditView {
    @Observable
    class ViewModel {
        enum LoadingState {
            case loading, loaded, failed
        }
        
        var loadingState = LoadingState.loading
        
        var name: String = ""
        var description: String = ""
        var pages = [Page]()
        
        
    }
}
