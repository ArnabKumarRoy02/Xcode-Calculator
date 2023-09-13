//
//  ContentView.swift
//  Calculator
//
//  Created by Arnab Kumar Roy on 13/09/23.
//

import SwiftUI

enum CalculateButton: String {
    case one = "1"
    case two = "2"
    case three = "3"
    case four = "4"
    case five = "5"
    case six = "6"
    case seven = "7"
    case eight = "8"
    case nine = "9"
    case zero = "0"
    case add = "+"
    case subtract = "-"
    case multiply = "*"
    case divide = "/"
    case equal = "="
    case clear = "AC"
    case decimal = "."
    case percent = "%"
    case negative = "+/-"
    
    var buttonColor: Color {
        switch self {
            case .add, .subtract, .multiply, .divide, .equal:
                return .orange
            case .clear, .negative, .percent:
            return Color(CGColor(red: 164/255.0, green: 164/255.0, blue: 165/255.0, alpha: 1))
            default:
                return Color(CGColor(red: 50/255.0, green: 51/255.0, blue: 52/255.0, alpha: 1))
        }
    }
}

enum Operation {
    case add, subtract, multiply, divide, none
}

struct ContentView: View {
    
    @State var value = "0"
    @State var prevNumber = 0.0
    @State var currentOperation: Operation = .none
    @State var hasDecimal = false
    @State var isNegative = false
    
    let buttons: [[CalculateButton]] = [
        [.clear, .negative, .percent, .divide],
        [.seven, .eight, .nine, .multiply],
        [.four, .five, .six, .subtract],
        [.one, .two, .three, .add],
        [.zero, .decimal, .equal]
    ]
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all);
            
            VStack {
                Spacer()
                
                // For Text and Output
                HStack {
                    Spacer()
                    Text(value)
                        .bold()
                        .font(.system(size: 84))
                        .foregroundColor(.white)
                }
                .padding()
                
                // For Buttons
                ForEach(buttons, id: \.self) { row in
                    HStack(spacing: 12) {
                        ForEach(row, id: \.self) { item in
                            Button(action: {
                                self.madeTap(button: item)
                            }, label: {
                                Text(item.rawValue)
                                    .font(.system(size: 32))
                                    .frame(
                                        width: self.buttonWidth(item: item),
                                        height: self.buttonHeight())
                                    .background(item.buttonColor)
                                    .foregroundColor(.white)
                                    .cornerRadius(self.buttonWidth(item: item)/2)
                            })
                        }
                    }
                    .padding(.bottom, 3)
                }
            }
        }
    }
    func madeTap(button: CalculateButton) {
        switch button {
            case .add, .subtract, .multiply, .divide, .equal:
                if button == .add {
                    self.currentOperation = .add
                    self.prevNumber = Double(self.value) ?? 0
                }
                else if button == .subtract {
                    self.currentOperation = .subtract
                    self.prevNumber = Double(self.value) ?? 0
                }
                else if button == .multiply {
                    self.currentOperation = .multiply
                    self.prevNumber = Double(self.value) ?? 0
                }
                else if button == .divide {
                    self.currentOperation = .divide
                    self.prevNumber = Double(self.value) ?? 0
                }
                else if button == .equal {
                    let runningnumber = self.prevNumber
                    let currentValue = Double(self.value) ?? 0
                    switch self.currentOperation {
                    case .add:
                        self.value = "\(runningnumber + currentValue)"
                    case .subtract:
                        self.value = "\(runningnumber - currentValue)"
                    case .multiply:
                        self.value = "\(runningnumber * currentValue)"
                    case .divide:
                        self.value = "\(runningnumber / currentValue)"
                    case .none:
                        break
                    }
                }
            
                if button != .equal {
                    self.value = "0"
                }
                case .clear:
                    self.value = "0"
                case .decimal:
                    if !hasDecimal {
                        self.value += "."
                        hasDecimal = true
                    }
                case .percent:
                    if let currentValue = Double(value) {
                        self.value = "\(currentValue / 100)"
                        hasDecimal = self.value.contains(".")
                    }
                case .negative:
                    self.isNegative.toggle()
                    if self.isNegative {
                        self.value = "-\(value)"
                    } else {
                        if value.hasPrefix("-") {
                            value.removeFirst()
                        }
                    }
                default:
                    let number = button.rawValue
                    if self.value == "0" || self.value == "-0"{
                        value = number
                    }
                    else {
                        self.value = "\(self.value)\(number)"
                    }
            }
    }
    
    func buttonWidth(item: CalculateButton) -> CGFloat {
        if item == .zero {
            return ((UIScreen.main.bounds.width - (4*12)) / 4) * 2
        }
        return (UIScreen.main.bounds.width - (5*12)) / 4
    }
    
    func buttonHeight() -> CGFloat {
        return (UIScreen.main.bounds.width - (5*12)) / 4
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
