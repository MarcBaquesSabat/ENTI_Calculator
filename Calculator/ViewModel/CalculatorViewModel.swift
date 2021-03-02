//
//  CalculatorViewModel.swift
//  Calculator
//
//  Created by Guillermo Fernandez on 24/02/2021.
//

import Foundation
import SwiftUI
import Combine

enum CalculatorOperation {
    case none
    case swipeSign
    case percentage
    case division
    case multiplication
    case subtraction
    case addition
    case equal
}
enum ClearOperation: String{
    case ClearAll = "AC"
    case Clear = "C"
}

protocol CalculatorViewModelProtocol {
    func addDigit(_ digit: String)
    func resetOperands()
}

class CalculatorViewModel: CalculatorViewModelProtocol,
                           ObservableObject {
    
    @Published var display: String = "0"
    @Published var buttonText: String = ClearOperation.ClearAll.rawValue

    private var operation: Calculation = Calculation(firstOperator: 0,
                                                     secondOperator: 0,
                                                     operation: .none)
    private var operationFinished: Bool = false
    private var addingNumbers: Bool = false
    
    public func addDigit(_ digit: String) {
        addingNumbers = true
        buttonText = ClearOperation.Clear.rawValue
        
        if self.operation.operation != .none && self.operation.secondOperator == nil {
            self.operation.secondOperator = 0
            self.display = digit
            return
        }
        guard self.display != "0" else {
            self.display = digit
            return
        }
                
        guard self.display.count < 6 else {
            return
        }
        
        self.display += digit
    }
    
    public func resetOperands() {
        if(addingNumbers){
            
            self.buttonText = ClearOperation.ClearAll.rawValue
            addingNumbers = false;
            self.display = "0"
 
        }else if(self.display != "0"){
            EndCalculations()
            
            self.operation.reset()
            self.display = "0"
        }
    }
    
    public func perform(operation: CalculatorOperation) {
        guard let value = Int(display) else { return }
        
        addingNumbers = true;
        
        switch operation {
        case .swipeSign:
            self.display = String(-value)
        case .equal:
            self.operation.secondOperator = value
            guard let result = calculateResult(for: self.operation) else { return }
            self.display = String(result)
            self.operation.reset()
            self.operation.firstOperator = result
            self.operationFinished = true
            return
        default:
            self.operation.firstOperator = value
            self.operation.operation = operation
        }

    }
    
    func calculateResult(for values: Calculation) -> Int? {
        guard let secondOperator = values.secondOperator else { return nil }
        
        addingNumbers = true;
        
        switch values.operation {
        case .addition:
            return operation.firstOperator + secondOperator
        case .division:
            return operation.firstOperator / secondOperator
        case .multiplication:
            return operation.firstOperator * secondOperator
        case .subtraction:
            return operation.firstOperator - secondOperator
        case .percentage:
            let base = Double(secondOperator)
            let percentage = Double(operation.firstOperator) / 100
            let result = base * percentage
            return Int(result)
        default:
            return nil
        }
    }
    
    func EndCalculations(){
        self.addingNumbers = true
        self.buttonText = ClearOperation.Clear.rawValue
    }
}
