//
//  ViewController.swift
//  weatherAppChallange
//
//  Created by Goncalo Alves on 12/02/2021.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        var o = openWeatherDataModel()
        o.fetch5dayWeatherForecast(completionHandler: {
            print("We have the data model now we must instantiate the ViewModel")
            var fiveDayForecastViewModel = FiveDayForecastViewModel(dataModel: o.fiveDayfor!)
        })
    }


}

