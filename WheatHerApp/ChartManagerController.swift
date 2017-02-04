//
//  ChartManagerController.swift
//  WheatHerApp
//
//  Created by Student on 1/29/17.
//  Copyright © 2017 Student. All rights reserved.
//

import Foundation
import Charts
import UIKit

class ChartManagerController : ViewController {
    private let chartDataSource = (JSONCustomPaser.getInstance().parsedJSON as! WeatherModel).dailyforecast
    private var  chartData = [ChartDataEntry]()
    private var  chartDataSetArrayAvlues = [String]()

    private var chartDataSet : LineChartDataSet?
    
    private var embedController: DetailedController?
    @IBOutlet weak var lineChart: LineChartView!
    
    override func viewWillAppear(_ animate: Bool) {
        super.viewWillAppear(animate)
        let xAxis=XAxis()
        let chartFormmater=ChartFormatter()
        
        for i in 0..<self.chartDataSource!.count{
            chartFormmater.stringForValue(Double(i), axis: xAxis)
        }
        
        xAxis.valueFormatter=chartFormmater
        self.lineChart.xAxis.valueFormatter=xAxis.valueFormatter
        for (index, day) in self.chartDataSource!.enumerated() {
            chartData.append(ChartDataEntry(x: Double(index), y: Double(day.apparentTemp!)!))
            self.chartDataSetArrayAvlues.append(day.day!)
        }
        self.chartDataSet = LineChartDataSet(values: chartData, label: "Temperature")
        self.lineChart.data = LineChartData(dataSet: self.chartDataSet)
        self.embedController!.viewData = (JSONCustomPaser.getInstance().parsedJSON as! WeatherModel)

    }
    
    @objc(LineChartFormatter)
    class ChartFormatter:NSObject,IAxisValueFormatter{
        
        var values = (JSONCustomPaser.getInstance().parsedJSON as! WeatherModel).dailyforecast
        func stringForValue(_ value: Double, axis: AxisBase?) -> String {
            return values![Int(value)].day!
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch(segue.destination) {
        case is DetailedController:
            self.embedController = (segue.destination as! DetailedController)
        default: super.prepare(for: segue, sender: sender)
        }
    }
}
