//
//  Builder.swift
//  Weather-Project
//
//  Created by Влад Артемкин on 19.09.21.
//

import Foundation
import UIKit

protocol Builder {
    static func createTodayVC(_ model: TodayResponse) -> UIViewController
}

class ModuleBuilder: Builder {
    static func createTodayVC(_ model: TodayResponse) -> UIViewController {
        let view = TodayViewController()
        let presenter = TodayPresenter(view: view, modelTodayResponse: model)
        view.presenter = presenter
        return view
    }
}
