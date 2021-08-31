//
//  ListExercises+CoreDataProperties.swift
//  SportTime
//
//  Created by Alex on 27.05.2021.
//
//

import Foundation
import CoreData


extension ListExercises {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ListExercises> {
        return NSFetchRequest<ListExercises>(entityName: "ListExercises")
    }

    @NSManaged public var countExercises: String?
    @NSManaged public var name: String?
    @NSManaged public var exercise: NSSet?

}

// MARK: Generated accessors for exercise
extension ListExercises {

    @objc(addExerciseObject:)
    @NSManaged public func addToExercise(_ value: Exercise)

    @objc(removeExerciseObject:)
    @NSManaged public func removeFromExercise(_ value: Exercise)

    @objc(addExercise:)
    @NSManaged public func addToExercise(_ values: NSSet)

    @objc(removeExercise:)
    @NSManaged public func removeFromExercise(_ values: NSSet)

}

extension ListExercises : Identifiable {

}
