//
//  CalculeResult.swift
//  Calculator
//
//  Created by Alumne on 2/3/21.
//

import Foundation

public class OperationFactory{
    static func CreateOperation(op:CalculatorOperation)->Calcule?{
        
        switch op {
        case .addition:
            return AdditionCalcule()
        case .division:
            return DivisionCalcule()
        case .multiplication:
            return MultiplicationCalcule()
        case .subtraction:
            return SubstractionCalcule()
        case .percentage:
            return PercentageCalcule()
        default:
            return nil
        }
    }
}

protocol Calcule{
    
    func CalculeResult(operation : Calculation)-> Double?
    
}

public class AdditionCalcule : Calcule{
    
    func CalculeResult(operation: Calculation) -> Double? {
        guard let secondOperator = operation.secondOperator else {
            return nil
        }
        
        return operation.firstOperator + secondOperator
    }
}

public class DivisionCalcule : Calcule{
    func CalculeResult(operation: Calculation) -> Double? {
        guard let secondOperator = operation.secondOperator else {
            return nil
        }
        
        return operation.firstOperator / secondOperator
    }
}

public class MultiplicationCalcule : Calcule{
    func CalculeResult(operation: Calculation) -> Double? {
        guard let secondOperator = operation.secondOperator else {
            return nil
        }
        return operation.firstOperator * secondOperator
    }
}

public class SubstractionCalcule : Calcule{
    func CalculeResult(operation: Calculation) -> Double? {
        guard let secondOperator = operation.secondOperator else {
            return nil
        }
        return operation.firstOperator - secondOperator
    }
}

public class PercentageCalcule : Calcule{
    func CalculeResult(operation: Calculation) -> Double? {
        guard let secondOperator = operation.secondOperator else {
            return nil
        }
        
        let base = Double(secondOperator)
        let percentage = Double(operation.firstOperator) / 100
        let result = base * percentage
        return Double(result)
    }
}
