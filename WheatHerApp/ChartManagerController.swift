//
//  ChartManagerController.swift
//  WheatHerApp
//
//  Created by Student on 1/29/17.
//  Copyright © 2017 Student. All rights reserved.
//

import Foundation
import Charts

class ChartManagerController : ViewController {
    private let chartDataSource = (JSONCustomPaser.getInstance().parsedJSON as! WeatherModel).forecast
    private var  chartData = [ChartDataEntry]()
    private var  chartDataSetArrayAvlues = [String]()

    private var chartDataSet : LineChartDataSet?
    
    
    @IBOutlet weak var lineChart: LineChartView!
    
    override func viewWillAppear(_ animate: Bool) {
        super.viewWillAppear(animate)
        for (index, day) in self.chartDataSource!.enumerated() {
            chartData.append(ChartDataEntry(x: Double(index), y: Double(day.maxTemp)!))
            self.chartDataSetArrayAvlues.append(day.day)
        }
        self.chartDataSet = LineChartDataSet(values: chartData, label: "Temperature")
        self.lineChart.data = LineChartData(dataSet: self.chartDataSet)
    }

}
