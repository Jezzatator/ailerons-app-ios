//
//  FormContentBuilderImpl.swift
//  ailerons-app-ios
//
//  Created by Jérémie - Ada on 15/12/2023.
//

import Foundation


final class FormContentBuilderImpl {
    
    var content: [FormSectionComponent] {
        
        return [
        
            FormSectionComponent(items: [
                
                TextFormComponent(placeholder: "first.name"),
                TextFormComponent(placeholder: "last.name"),
                TextFormComponent(placeholder: "email",
                                  keyboardType: .emailAddress),
                DateFormComponent(mode: .date),
                ButtonFormComponent(title: "confirm")
            ])
        ]
    }
}
