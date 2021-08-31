//
//  Exercise+CoreDataProperties.swift
//  SportTime
//
//  Created by Alex on 27.05.2021.
//
//

import Foundation
import CoreData


extension Exercise {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Exercise> {
        return NSFetchRequest<Exercise>(entityName: "Exercise")
    }

    @NSManaged public var descriptionEx: String?
    @NSManaged public var name: String?
    @NSManaged public var timeExercise: String?
    @NSManaged public var timeRelax: String?
    @NSManaged public var img: String?
    @NSManaged public var listExercises: ListExercises?

}

extension Exercise : Identifiable {

}
