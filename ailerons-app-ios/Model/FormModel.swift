//
//  FormModel.swift
//  ailerons-app-ios
//
//  Created by Jérémie - Ada on 15/12/2023.
//

import Foundation
import UIKit

protocol FormItem {
    var id: UUID { get}
}

protocol FormSectionItem {
    var id: UUID { get }
    var items: [FormComponent] { get }
    init(items: [FormComponent])
}

// Section Component

final class FormSectionComponent: FormSectionItem, Hashable {
    
    var id: UUID = UUID()
    var items: [FormComponent]
    
    init(items: [FormComponent]) {
        self.items = items
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: FormSectionComponent, rhs: FormSectionComponent) -> Bool {
        lhs.id == rhs.id
    }
    
}
 
// Form Component

class FormComponent: FormItem, Hashable {
    
    var id: UUID = UUID()
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: FormComponent, rhs: FormComponent) -> Bool {
        lhs.id == rhs.id
    }
}


// Text Component

final class TextFormComponent: FormComponent {
    
    let placeholder: String
    let keyboardType: UIKeyboardType
    
    init(placeholder: String, keyboardType: UIKeyboardType = .default) {
        self.placeholder = placeholder
        self.keyboardType = keyboardType
    }
}


// Date Component

final class DateFormComponent: FormComponent {
    
    let mode: UIDatePicker.Mode
    
    init(mode: UIDatePicker.Mode) {
        self.mode = mode
    }
}

// Species Component

final class SpeciesFormComponent: FormComponent {
    
    let mode: UIPickerView
    
    init(mode: UIPickerView) {
        self.mode = mode
    }
}

// Button Component

final class ButtonFormComponent: FormComponent {
    
    let title: String
    
    init(title: String) {
        self.title = title
    }
}
